#!/usr/bin/bash

#create memory log file
touch /home/vagrant/my_work/RAMUsageScript/system_memory_usage.log

#get memory usage from free command
MemoryUsage=`free --mega | awk 'NR==2{printf("- " "%.2f",$3*100/$2)}'`

#time
Time=$(date +%H:%M)

#echo the value of MemoryUsage to the memory log file
echo $MemoryUsage"%" "|" $Time >> /home/vagrant/my_work/RAMUsageScript/system_memory_usage.log

#condition that sends email when it's midnight
if [[ $(date +%H:%M) == "00:00" ]]
then
echo "Here's the memory usage log for the day" | mutt -a /home/vagrant/my_work/RAMUsageScript/system_memory_usage.log -s "Memory Usage Log" -- email@email.com

#clears the memory log file
> /home/vagrant/my_work/RAMUsageScript/system_memory_usage.log

fi
