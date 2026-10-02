#!/bin/bash

echo "========================================"
echo "        SYSTEM INFORMATION              "
echo "========================================"


General_info(){
echo "hostname  : $(hostname)"  
# displays kernal 
echo "Kernel         : $(uname -r)"
echo "User           : $(whoami)"
echo "Uptime         : $(uptime -p)"
}

CPU_info(){
echo "CPU Cores      : $(nproc)"

echo "CPU            : $(lscpu | grep 'Model name' | cut -d ':' -f2)"
# above we write 3 commands at a time using | called as pipe
# grep gives the value od model name
}

Memory_info(){
echo "Memory Used    : $(free -h | awk '/Mem:/ {print $3}')"
e:cho "Memory Total   : $(free -h | awk '/Mem:/ {print $2}')"
# in this awk is the command used to search and extract and process column of text and here $1,$2 etc reprasent feild number
}

Other_info(){
echo "Disk Usage     : $(df -h / | awk 'NR==2 {print $3 " used / " $2 " total (" $5 ")"}')"
# NR is line number

echo "IP Address     : $(hostname -I | awk '{print $1}')"

echo "Logged Users   : $(who | wc -l)"
echo "Date & Time    : $(date)"
}

General_info
CPU_info
Memory_info
Other_info

echo "========================================"
