# Server Stats

Project from: [https://roadmap.sh/projects/server-stats](https://roadmap.sh/projects/server-stats)

Server Stats is a Bash script designed to provide an overview of the hardware and system usage statistics. It offers real-time insights into CPU, memory, and disk usage while identifying the most resource-intensive processes.

## Features
- Displays CPU model and RAM capacity.
- Provides disk usage details including total, used, and free space.
- Calculates and alerts high CPU usage (above 90%).
- Displays real-time memory and disk usage percentages.
- Lists the top 5 processes by CPU and memory usage.

## Usage
### Syntax
```
./server-stats.sh
```
- **`-h` or `--help`**: Displays usage instructions.

### Output
1. **Server Hardware**:
   - CPU name
   - Total RAM
   - Disk capacity (total and used)
2. **CPU Usage**:
   - Percentage of CPU usage and free capacity.
   - Warning message if CPU usage exceeds 90%.
3. **Disk Usage**:
   - Used and free space percentages.
4. **Memory Usage**:
   - Used and free memory percentages.
5. **Top Processes**:
   - Top 5 processes by CPU usage.
   - Top 5 processes by memory usage.

### Examples
Run the script directly:
```bash
./server-stats.sh
```
Display help information:
```bash
./server-stats.sh -h
```

## Development Environment
- **OS:** Linux (Ubuntu)
- **Language:** Bash
- **Tools Used:**
  - `awk` for text processing.
  - `grep` for pattern matching.
  - `df` for disk usage information.
  - `free` for memory statistics.
  - `ps` for process monitoring.

## Improvements
- Allow output redirection to a log file for archival purposes.
- Enable real-time monitoring mode with periodic updates.
- Support more detailed process grouping and filtering (e.g., grouping by user).
- Extend to provide network statistics (e.g., bandwidth usage).
- Manage multi-instances programs

## Conclusion
Server Stats is a practical script for system administrators and developers to monitor server performance and identify resource bottlenecks. It combines essential statistics with actionable insights in a lightweight and portable tool.

The [project link](https://roadmap.sh/projects/server-stats).

Thanks to [https://roadmap.sh](https://roadmap.sh/).