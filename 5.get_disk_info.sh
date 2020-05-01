#!/bin/bash

# 获取磁盘信息，每一行输出含义如下：
# 时间、标识(0代表整个磁盘，1标识分区)、挂载点、总量、剩余量、使用率 

time=`date +"%F__%T"`

tmp_array=(`df -m | grep ^/dev | awk -v tmp=time '{printf("%s 1 %s %s %s %s\n", tmp, $6, $2, $4, $5)}'`)

total=0
idle=0
for ((i=0; i <${#tmp_array[*]}; i+=6)); do
    total=$[${total}+${tmp_array[i+3]}]
    idle=$[${idle}+${tmp_array[i+4]}]
    echo "${time} 1 ${tmp_array[i+2]}  ${tmp_array[i+3]}M  ${tmp_array[i+4]}M  ${tmp_array[i+5]}"
done

usedPercent=`echo "scale=2; 100*(${total}-${idle})/${total}" | bc`

echo "${time} 0 disk  ${total}M  ${idle}M ${usedPercent}%"


