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
CPU_USAGE=$(ps -p "$PID" -o %cpu= | awk '{print int($1+0.5)}') #ps is process status, -p for pid, -o for output format, %cpu to show only cpu usage = without header
MEMORY_USAGE=$(ps -p "$PID" -o %mem= | awk '{print int($1+0.5)}') #awk '{print int($1+0.5)}' to round to nearest integer

# Set default values if empty
CPU_USAGE=${CPU_USAGE:-0}
MEMORY_USAGE=${MEMORY_USAGE:-0}

# Check thresholds and log if exceeded
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "$(date): WARNING - $PROCESS_NAME CPU usage: ${CPU_USAGE}% (exceeds ${CPU_THRESHOLD}%)" >> "$LOG_FILE"
fi

if [ "$MEMORY_USAGE" -gt "$MEM_THRESHOLD" ]; then
    echo "$(date): WARNING - $PROCESS_NAME Memory usage: ${MEMORY_USAGE}% (exceeds ${MEM_THRESHOLD}%)" >> "$LOG_FILE"
fi

# Display current status
echo "$(date): $PROCESS_NAME - CPU: ${CPU_USAGE}%, Memory: ${MEMORY_USAGE}%"


# =============================================================================
    #    Quick Test Guide for Your Process Monitor Script   
# =============================================================================

# First, make sure everything is ready
#   chmod +x process_monitorring.sh
#   sudo systemctl start nginx

# Test 1: Normal monitoring (should show low usage)
#   ./process_monitorring.sh

# Test 2: Check the log was created
#   cat /var/log/process_monitor.log

# Test 3: What happens when process is missing?
#   sudo systemctl stop nginx
#   ./process_monitorring.sh
# Should say "Process nginx not found"

# Test 4: Start nginx again
#   sudo systemctl start nginx

# Test 5: Create high CPU usage to trigger alerts
#   yes > /dev/null &
# Edit your script temporarily: change "nginx" to "yes"
#   sed -i 's/nginx/yes/' process_monitorring.sh

# Test 6: Run script - should trigger WARNING!
#   sleep 2
#   ./process_monitorring.sh

# Test 7: Check for the warning message
#   tail /var/log/process_monitor.log

# Clean up
#   pkill yes
#   sed -i 's/yes/nginx/' process_monitorring.sh

# Final check - everything working?
#   ./process_monitorring.sh
#   echo " Done! Your script is working perfectly."

# =============================================================================
# What you should see:
#  No errors when running the script
#  Log file gets entries with timestamps  
#  WARNING appears when CPU > 70%
#  "Process not found" when nginx is stopped
# =============================================================================