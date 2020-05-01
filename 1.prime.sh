#!/bin/bash
# this is my first shell programming
#get the sum of all prime numbers less than 1000

max_n=1000

declare -a prime
for i in `seq 0 $[$max_n+5]`; do
    prime[$i]=0
done

cnt=0

function _init_() {
    for i in `seq 2 $max_n`; do
        if [[ ${prime[$i]} -eq 0 ]]; then
            cnt=$[$cnt+1]
            prime[$cnt]=$i
            #printf "prime[%d] = %d\n" $cnt ${prime[$cnt]}
        fi
        for j in `seq 1 $cnt`; do
            if [[ $[$i*${prime[$j]}] -gt $max_n ]]; then
                break
            fi
            prime[${prime[$j]}*$i]=1
            if [[ $[$i%${prime[$j]}] -eq 0 ]]; then
                break
            fi
        done
    done
}

_init_
ans=0
for i in `seq 1 $cnt`; do
    ans=$[$ans+${prime[$i]}]
done

echo "ans = $ans"

