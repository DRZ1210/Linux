#!/bin/bash

time=`date +"%F %T"`
hostname=`hostname`
OS_Version=`uname -v`
kernel_version=`uname -r`
running_time=`cat /proc/uptime | awk -F"." '{Days=$1/86400; hours=$1%86400/3600; mins=$1%3600/60; seconds=$1%60} \
    END {printf("%d天 %d时 %d分 %d秒\n"), Days, hours, mins, seconds}'`

loadAverage=`cat /proc/loadavg | cut -d " " -f 1-3`

eval `df -h --total | tail -n 1 | awk '{printf("disk_size=%s", $2)}'`
eval `df -h --total | tail -n 1 | awk '{printf("disk_used_percent=%s", $5)}'`
eval `free -m | head -n 2 | tail -n 1 | \
    awk '{printf("memory_size=%s memo_free_size=%s", $2, $4)}'`

memo_used_percent=`echo "100*(${memory_size}-${memo_free_size})/${memory_size}" | bc`

CpuTemp=`cat /sys/class/thermal/thermal_zone0/temp`
CpuTemp=`echo "scale=2; ${CpuTemp}/1000" | bc`

DiskWarn="normal"
tmp=${disk_used_percent:0:2}
if [[ `echo ${tmp} '>=' 90 | bc` == 1 ]];then
    DiskWarn="waring"
elif [[ `echo ${tmp} '>=' 80 | bc` == 1 ]];then
    DiskWarn="note"
fi

CpuWarn="normal"
if [[ `echo $CpuTemp '>=' 70 | bc` == 1 ]];then
    CpuWarn="waring"
elif [[ `echo $CpuTemp '>=' 50 | bc` == 1 ]];then
    CpuWarn="note"
fi

MemWarn="normal"
if [[ `echo ${memo_used_percent} '>=' 80 | bc` == 1 ]];then
    MemWarn="warning"
elif [[ `echo ${memo_used_percent} '>=' 70 | bc` == 1 ]];then
    MemWarn="note"
fi

echo -e "\033[01;34m当前时间：\033[0m${time}"
echo -e "\033[01;34m主机名：\033[0m${hostname}"
echo -e "\033[01;34mOS版本：\033[0m${OS_Version}"
echo -e "\033[01;34m内核版本：\033[0m${kernel_version}"
echo -e "\033[01;34m运行时间：\033[0m${running_time}"
echo -e "\033[01;34m平均负载：\033[0m${loadAverage}"
echo -e "\033[01;34m磁盘大小：\033[0m${disk_size}"
echo -e "\033[01;34m磁盘使用率：\033[0m${disk_used_percent}"
echo -e "\033[01;34m内存大小：\033[0m${memory_size}M"
echo -e "\033[01;34m内存使用率：\033[0m${memo_used_percent}%"
echo -e "\033[01;34mCPU温度：\033[0m${CpuTemp}"
echo -e "\033[01;34m硬盘状态：\033[0m${DiskWarn}"
echo -e "\033[01;34mCPU状态：\033[0m${CpuWarn}"
echo -e "\033[01;34m内存状态：\033[0m${MemWarn}"



