#!/bin/bash
# Disk Usage Monitor
# Script to check free space on /home and /var.
# If usage exceeds 80%, send a warning message to all logged-in users using wall.

home_usage+$(df /home | grep /home | awk '{print $5}' | cut -d'%' -f1)

