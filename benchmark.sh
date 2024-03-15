#!/bin/bash

options=(
    "-l 1000 -n 1"
    "-l 1000 -n 5"
    "-l 1000 -n 10"
    "-l 550000 -n 1"
    "-l 550000 -n 5"
    "-l 550000 -n 10"
    "-l 1999999 -n 1"
    "-l 1999999 -n 5"
    "-l 1999999 -n 10"
)

base_command () {
    ./bin/lab2 "$@"
}

run_banchmark() {
    mkdir -p benchmark
    rm -f benchmark/result.txt

    for i in "${options[@]}";
    do
        touch temp.txt && (time base_command -v ${i} -m 987) &>> temp.txt
        threads=$(cat temp.txt | awk '/Threads:/ {print $2}')
        length=$(cat temp.txt | awk '/Arr length:/ {print $3}')
        filename="benchmark/${threads}_${length}.txt"
        cat temp.txt | awk '/real/ {print $2}' >> ${filename}
        awk 'gsub(",", ".")' ${filename} | awk -v file=${filename} -F '[m]' '{sum+=$1*60+$2} END {printf "%s = %.5f s\n", file, sum/NR}' 1>> benchmark/result.txt

        rm temp.txt
    done
}

run_banchmark
