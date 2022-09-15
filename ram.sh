#!/usr/bin/bash

#create memory log file
touch system_memory_usage.log

#get memory usage from free command
MemoryUsage=`free --mega | awk 'NR==2{printf("- " "%.2f",$3*100/$2)}'`

#echo the value of MemoryUsage to the memory log file
echo $MemoryUsage"%" >> system_memory_usage.log

#condition that sends email when it's midnight
if [[ $(date +%H:%M) == "00:00" ]]
then
echo "Here's the memory usage log for the day" | mutt -a system_memory_usage.log -s "Memory Usage Log" -- kayzeel@yahoo.com

#clears the memory log file
> system_memory_usage.log

fi
