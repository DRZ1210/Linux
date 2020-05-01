#!/bin/bash

time=`date +"%F %T"`

eval `cat /etc/passwd | awk -F: -v userSum=0 \
    '{if ($3>=1000 && $3!=65534) {userSum+=1}} END {printf("userSum=%s", userSum)}'`


Users=(`cat /etc/passwd | w | tail -n 3  | cut -d ' ' -f 1`)

UserRoot=(`cat /etc/group |grep wheel |cut -d ':' -f 4-|cut -d ',' -f 1-`)

UserInfo=(`w | awk 'NR==1 {next} NR==2 {next} {printf ","$1"_"$3"_"$2}' \
    | tr -d '\n'|cut -d ',' -f 2-`)

echo "${NowTime} ${UserNum} [${Users[0]},${Users[1]},${Users[2]}] [${UserRoot[*]}] [${UserInfo}]"

