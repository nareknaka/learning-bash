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
PID=$(pgrep "$PROCESS_NAME" | head -1)