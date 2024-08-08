#!/bin/bash

# Run initial setup commands
echo "Running initial setup..."

# Ensure the crawler log is present
touch /root/codes/crawler.log

# Run your initial commands
bash /root/codes/setup_index.sh
python3 /root/codes/point_to_indexes.py
bash /root/codes/call_filtering.sh

# Start cron
cron

# Add a simple line to cron.log
echo "Cron job setup started." >> /var/log/cron.log

# Tail cron log to keep the container running
tail -f /var/log/cron.log
