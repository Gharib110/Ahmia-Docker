#!/bin/bash

# Run initial setup commands
echo "Running initial setup..."

# Ensure the crawler log is present
touch /root/codes/crawler.log

# Run your initial commands
bash /root/codes/run.sh &> /root/codes/crawler.log

# Set up cron jobs
cron

# Add a simple line to cron.log
echo "Cron job setup started." >> /var/log/cron.log

# Tail cron log to keep the container running
tail -f /var/log/cron.log
