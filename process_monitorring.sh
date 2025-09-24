#!/bin/bash

# Process Monitoring Script
# Write a bash script that monitors CPU and memory usage of a specific process (e.g., nginx or sshd or anything else).
# If usage exceeds a threshold (say 70%), log the event with timestamp into /var/log/custom_monitor.log.

PROCESS_NAME="nginx"    
CPU_THRESHOLD=70 
MEM_THRESHOLD=70
LOG_FILE="/var/log/process_monitor.log"
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE
# Check if process is running
#! if process not found
if ! pgrep "$PROCESS_NAME" > /dev/null; then #/dev/null to not show output
    echo "$(date): Process $PROCESS_NAME not found" >> "$LOG_FILE"
    exit 1
fi

# Get PID
PID=$(pgrep "$PROCESS_NAME" | head -1) # head -1 to get first PID if multiple instances

# Get usage statistics
CPU_USAGE=$(ps -p "$PID" -o %cpu=) #ps is process status, -p for pid, -o for output format, %cpu to show only cpu usage = without header
MEMORY_USAGE=$(ps -p "$PID" -o %mem=)




# Check thresholds and log if exceeded
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "$(date): WARNING - $PROCESS_NAME CPU usage: ${CPU_USAGE}% (exceeds ${CPU_THRESHOLD}%)" >> "$LOG_FILE"
fi

if [ "$MEMORY_USAGE" -gt "$MEMORY_THRESHOLD" ]; then
    echo "$(date): WARNING - $PROCESS_NAME Memory usage: ${MEMORY_USAGE}% (exceeds ${MEMORY_THRESHOLD}%)" >> "$LOG_FILE"
fi

# Display current status
echo "$(date): $PROCESS_NAME - CPU: ${CPU_USAGE}%, Memory: ${MEMORY_USAGE}%"