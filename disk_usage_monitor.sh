#!/bin/bash
# Disk Usage Monitor
# Script to check free space on /home and /var.
# If usage exceeds 80%, send a warning message to all logged-in users using wall.

home_usage=$(df /home | tail -1 | awk '{print $5}' | cut -d'%' -f1)

if [ "$home_usage" -gt 80 ]; then
    echo "WARNING: /home usage is ${home_usage}%" | wall
fi
# Check /var usage
var_usage=$(df /var | tail -1 | awk '{print $5}' | cut -d'%' -f1)
if [ -n "$var_usage" ] && [ "$var_usage" -gt 80 ]; then
    echo "WARNING: /var usage is ${var_usage}%" | wall
fi