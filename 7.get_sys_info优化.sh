#!/bin/bash

time=`date +"%F__%T"`
HostName=`hostname`
OSType=`cat /etc/issue.net | tr " " "_"`
KernalVersion=`uname -r`
LoadAvg=`cut -d " " -f 1-3 /proc/loadavg`
UpTime=`uptime -p | tr -s " " "_"`

eval `df -h --total | tail -n 1 | awk \
    '{printf("DiskTotal=%d DiskUsedP=%d", $2, $5)}'`

DiskWarningLevel="normal"
if [[ ${DiskUsedP} -gt 90 ]]; then
    DiskWarningLevel="warning"
elif [[ ${DiskUsedP} -gt 80 ]]; then
    DiskWarningLevel="note"
fi


eval `free -m | head -n 2 | tail -n 1 | awk \
    '{printf("MemTotal=%s MemUsed=%s", $2, $3)}'`
MemUsedP=$[ ${MemUsed}*100/${MemTotal} ]

MemWarningLevel="normal"
if [[ ${MemUsedP} -gt 80 ]]; then
    MemWarningLevel="warning"
elif [[ ${MemUsedP} -gt 70 ]]; then
    MemWarningLevel="note"
fi

CpuTemp=`cat /sys/class/thermal/thermal_zone8/temp`
CpuTemp=`echo "scale=2; ${CpuTemp}/1000" | bc`

CpuWarningLevel="normal"
if [[ `echo "${CpuTemp}>=70" | bc -l` == 1 ]]; then
    CpuWarningLevel="warning"
elif [[ `echo "${CpuTemp}>=50" | bc -l` == 1 ]]; then
    CpuWarningLevel="note"
fi

echo -e "\033[1;34m当前时间：\033[0m${time}"
echo -e "\033[1;34m主机名：\033[0m${HostName}"
echo -e "\033[1;34mOS版本：\033[0m${OSType}"
echo -e "\033[1;34m内核版本：\033[0m${KernalVersion}"
echo -e "\033[1;34m运行时间：\033[0m${UpTime}"
echo -e "\033[1;34m平均负载：\033[0m${LoadAvg}"
echo -e "\033[1;34m磁盘大小：\033[0m${DiskTotal}G"
echo -e "\033[1;34m磁盘使用率：\033[0m${DiskUsedP}%"
echo -e "\033[1;34m内存大小：\033[0m${MemTotal}M"
echo -e "\033[1;34m内存使用率 \033[0m${MemUsedP}%"
echo -e "\033[1;34mCPU温度：\033[0m${CpuTemp}"
echo -e "\033[1;34m磁盘警告级别：\033[0m${DiskWarningLevel}"
echo -e "\033[1;34m内存警告级别：\033[0m${MemWarningLevel}"
echo -e "\033[1;34mCPU警告级别：\033[0m${CpuWarningLevel}"


