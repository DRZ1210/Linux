#!/bin/bash

time=`date +"%F__%T"`

proc_array1=(`ps aux | tail -n +2 | awk '{if ($3>0.2 || $4>0.2) {printf("%s ", $2)}}'`)

if [[ ${#proc_array1[@]} -ne 0 ]]; then
    sleep 5
else 
    echo "没有恶意进程"
    exit 0
fi

proc_array2=(`ps aux | tail -n +2 | awk '{if ($3>0.2 || $4>0.2) {printf("%s ", $2)}}'`)

if [[ ${#proc_array2[@]} -eq 0 ]]; then
    echo "没有恶意进程"
    exit 0
fi

ind=0
ans=()
for i in ${proc_array2[@]}; do
    for j in ${proc_array1[@]}; do
        if [[ ${i} -eq ${j} ]]; then
            ans[${ind}]=${i}
            ind=${ind}+1
            break
        fi
    done
done


for i in ${ans[@]}; do
    ps aux | tail -n +2 | awk -v t=${i} -v t1=${time} '{if ($2==t) \
        {printf("\033[1;34m%s\033[0m \033[1;35m%s\033[0m \033[1;33m%s\033[0m \033[1;31m%s\033[0m \033[1;32m%s\033[0m %s\n", t1, $2, $1, $3, $4, $11)}}'
done



