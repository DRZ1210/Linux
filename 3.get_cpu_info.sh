#!/bin/bash

time=`date +"%F %T"`
cpuLoad=(`cat /proc/loadavg | cut -d " " -f 1-3`)

total=0
info_array=(`cat /proc/stat | head -n 1`)
for ((i=1; i<11; i++)); do
    total=$[${total}+${info_array[i]}]
done
idle=${info_array[4]}

usedPercent=`echo "scale=2; 100*(${total}-${idle})/${total}" | bc`

cpuTemprature=`cat /sys/class/thermal/thermal_zone0/temp`
cpuTemprature=`echo "scale=2; ${cpuTemprature}/1000" | bc`

warnLevel="normal"
if [[ `echo "${cpuTemprature} >= 70" | bc -l` == 1 ]]; then
    warnLevel="warning"
elif [[ `echo "${cpuTemprature} >= 50" | bc -l` == 1 ]]; then
    warnLevel="note"
fi

echo -e "\033[1;34m当前时间：\033[0m${time}"
echo -e "\033[1;34mCPU负载：\033[0m${cpuLoad[*]}"
echo -e "\033[1;34mCPU使用率：\033[0m${usedPercent}%"
echo -e "\033[1;34mCPU温度：\033[0m${cpuTemprature}"
echo -e "\033[1;34m温度警告等级：\033[0m${warnLevel}"

