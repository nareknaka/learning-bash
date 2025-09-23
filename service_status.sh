#!/bin/bash
# Custom Service with systemd

# Create a simple shell script (e.g., one that prints “Service Running” every 10 seconds).
# Register it as a systemd service.
# Practice enabling, disabling, starting, stopping, and checking its logs with journalctl.




while true; do
   echo "Service is running"
   echo "----------------------------"
   sleep 10
done 


# ------------------------------
# Next steps to register as a systemd service:
#
# 1. Copy this script to /usr/local/bin/service_status.sh and make it executable:
#    sudo cp ~/homeworks/service_status.sh /usr/local/bin/service_status.sh
#    sudo chmod +x /usr/local/bin/service_status.sh

# 2. Create a systemd service file:
#    sudo nano /etc/systemd/system/service_status.service
#    Paste the following content:
#    [Unit]
#    Description=Custom Service Status Script

#    [Service]
#    ExecStart=/usr/local/bin/service_status.sh
#    Restart=always
#    User=(your-username)  # Replace with your actual username

#    [Install]
#    WantedBy=multi-user.target

# 3. Reload systemd and enable the service:
#    sudo systemctl daemon-reload
#    sudo systemctl enable service_status

# 4. Start the service:
#    sudo systemctl start service_status

# 5. Check the status:
#    sudo systemctl status service_status
# 6. View logs:
#    journalctl -u service_status

# 7. Stop the service:
#    sudo systemctl stop service_status
#    sudo systemctl status service_status

# 8. Disable the service:
#    sudo systemctl disable service_status
# ------------------------------