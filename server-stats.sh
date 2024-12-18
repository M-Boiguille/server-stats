#!/bin/bash

printf "=========== SERVER STATS ===========\n\n"
printf "\n---------- Server Hardware ----------\n\n"

# CPU Name
grep -m 1 'model name' /proc/cpuinfo | \
awk -F": " '{printf "CPU: \t%s\n", $2}'

# Disk Information
df -h . | grep -vi size | \
awk '{printf "Disk: \t%s\t| size: %s\n", $1, $2}'

# Memory Information
free -h | grep Mem | awk '{printf "Mem: \t%s", $2}'

echo ""
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

printf "\t%d%% | Free: %d%%\n" "$usage" "$free_cpu"

printf "\n---------- Disk Usage ----------\n\n"

# Disk Usage
df -h . | grep -vi use | \
awk '{printf "\t%.2f%% | Free: %.2f%%    (%s)\n", $3/$2 * 100, $4/$2 * 100, $1}'

printf "\n---------- Memory Usage ----------\n\n"

# Memory Usage
free | grep Mem | \
awk '{printf "\t%.2f%% | Free: %.2f%%\n", $3/$2 * 100, $4/$2 * 100}'

# Five CPU greediest processes
printf "\n---------- Top 5 processes by CPU usage ----------\n"
top -c -o=+"%CPU" -b -n 1 | awk '/^$/{flag=1} flag' | head -6 #| awk -F, '{print $3}'

# Five Memory greediest processes
printf "\n---------- Top 5 processes by Memory usage ----------\n"
top -c -o=+"%MEM" -b -n 1 | awk '/^$/{flag=1} flag' | head -6 #| awk -F, '{print $3}'

