#!/bin/bash

# Run initial setup commands
echo "Running initial setup..."

# Ensure the crawler log is present
touch /root/codes/crawler.log

# Wait for Elasticsearch to be available
echo "Waiting for Elasticsearch to be available..."
while ! curl -s http://elasticsearch1:9200/_cluster/health | grep -E '"status":"(green|yellow)"' > /dev/null; do
  echo "Elasticsearch not available yet. Waiting..."
  sleep 5  # Wait for 5 seconds before checking again
done

echo "Elasticsearch is up and running!"

# Run your initial commands
bash /root/codes/setup_index.sh
python3 /root/codes/point_to_indexes.py
bash /root/codes/call_filtering.sh

# Add a simple line to cron.log
echo "Cron job setup started." >> /var/log/cron.log

# Tail cron log to keep the container running
sh -c cron && tail -f /var/log/cron.log
