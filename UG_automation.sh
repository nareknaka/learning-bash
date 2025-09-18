#!/bin/bash

# User and Group Automation Script
# Write a script that creates a group devops.
# Add three new users (dev1, dev2, dev3) to that group.
# Each should have a home directory, restricted permissions, and their own .bashrc with a custom welcome message.

sudo groupadd devops
for user in dev1 dev2 dev3; do
    sudo useradd -m -g devops -s /bin/bash "$user"
    echo 'echo "Welcome to the system, '"$user"'!"' | sudo tee /home/"$user"/.bashrc
    sudo chmod 700 /home/"$user"
done

