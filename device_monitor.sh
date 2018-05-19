#!/bin/bash
function getCurrentDiskUsage() {
  path=$1
  echo $(df $path | grep $path | awk '{print $4}')
}

interval=$2

diskUsage1=$(getCurrentDiskUsage $1)
time1=$(date +"%H:%M.%S")

while sleep $interval;
  do
    diskUsage2=$(getCurrentDiskUsage $1)
    time2=$(date +"%H:%M.%S")
    difference=$(($diskUsage2 - $diskUsage1))
    if [ ! $difference -eq 0 ]
    then
      echo "Disk free at $time1: $diskUsage1 | Disk free at $time2: $diskUsage2"
      echo "Difference: $difference K"
    fi
    diskUsage1=$diskUsage2
    time1=$time2
done;
