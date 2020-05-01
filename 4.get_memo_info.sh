#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 usedPercent"
    exit 1
fi

time=`date +"%F %T"`

eval `free -m | head -n 2 | tail -n 1 | awk '{printf("total=%s idle=%s", $2, $4)}'`

usedPercent=`echo "scale=2; 100*(${total}-${idle})/${total}" | bc`

dyUsedPercent=`echo "scale=2; 0.3*$1+0.7*${usedPercent}" | bc`

echo -e "\033[1;34m当前时间：\033[0m${time}"
echo -e "\033[1;34m内存总量：\033[0m${total}M"
echo -e "\033[1;34m内存剩余量：\033[0m${idle}M"
echo -e "\033[1;34m当前内存使用率：\033[0m${usedPercent}%"
echo -e "\033[1;34m动态内存使用率：\033[0m${dyUsedPercent}%"


