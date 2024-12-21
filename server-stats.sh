#!/bin/bash

printf "=========== SERVER STATS ===========\n\n"

# Provide help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: ./server-stats.sh"
    echo "Displays server hardware and usage statistics."
    exit 0
fi

#Hardware info
printf "\n---------- Server Hardware ----------\n\n"

# CPU Name
if ! [ -f /proc/cpuinfo ]; then
    echo "Error: /proc/cpuinfo not found."
    exit 1
fi
grep -m 1 'model name' /proc/cpuinfo | \
awk -F": " '{printf "CPU: \t%s\n", $2}'

# Disk Information
df -BG . | awk 'NR==2 {printf "Disk: \t%s | Total: %s | Used: %s\n", $1, $2, $3}'

# Memory Information
free -h | awk '/Mem:/ {printf "RAM: \t%s\n", $2}'

printf "\n---------- CPU Usage ----------\n\n"

# CPU Usage Calculation
cpu_mesure1=($(grep 'cpu ' /proc/stat))
idle_mesure1=${cpu_mesure1[4]}
total1=0

for value in "${cpu_mesure1[@]:1}"; do
  total1=$((total1 + value))
done

sleep 1

cpu_mesure2=($(grep 'cpu ' /proc/stat))
idle_mesure2=${cpu_mesure2[4]}
total2=0

for value in "${cpu_mesure2[@]:1}"; do
  total2=$((total2 + value))
done

diff_idle=$((idle_mesure2 - idle_mesure1))
diff_total=$((total2 - total1))
usage=$((100 * (diff_total - diff_idle) / diff_total))
free_cpu=$((100 - usage))

# Alert CPU usage
if [ "$usage" -gt 90 ]; then
    echo "Warning: High CPU usage: $usage%"
fi
printf "\t%d%% | Free: %d%%\n" "$usage" "$free_cpu"


printf "\n---------- Disk Usage ----------\n\n"

# Disk Usage
df -B1 . | awk 'NR==2 {used=$3; total=$2; free=total-used; printf "\t%.2f%% | Free: %.2f%%\n", used/total*100, free/total*100}'


printf "\n---------- Memory Usage ----------\n\n"

# Memory Usage
free | grep Mem | \
awk '{printf "\t%.2f%% | Free: %.2f%%\n", $3/$2 * 100, $4/$2 * 100}'

# Five CPU greediest processes
printf "\n---------- Top 5 processes by CPU usage ----------\n"
ps -eo comm,pid,user,%mem,%cpu --sort=-%cpu | \
grep -v -x "ps" | head -6

# Five Memory greediest processes
printf "\n---------- Top 5 processes by Memory usage ----------\n"
ps -eo comm,pid,user,%cpu,%mem --sort=-%mem | \
grep -v -x "ps" | head -6
