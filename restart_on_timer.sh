#!/bin/bash

LOG_FILE="/home/niklas/mc/spigot/logs/latest.log"

curl -H "Content-Type: application/json" -X POST -d '{"content":"Minecraft server will be restarting in 5 minutes...\nNext restart will be in 12 hours..."}'

sleep 300

sudo systemctl stop mc.service

sleep 20

sudo systemctl start mc.service

sleep 200

# Check if server started up properly else restart againi

while true; do
    echo "Checking server status..."
    # Check if the server started up properly
    if grep -q "Dedicated server took .* seconds to load" "$LOG_FILE"; then
        echo "Server started successfully."
      	exit 0
    else
        echo "Server did not start properly. Restarting..."
        # Restart the server
        sudo systemctl restart mc.service
        sleep 200  # Sleep for 3 minutes before checking again
    fi
done
