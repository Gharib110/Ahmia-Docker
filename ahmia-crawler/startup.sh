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

bash /root/codes/torfleet/runfleet.sh

sleep 3m

# Run your initial commands
bash /root/codes/run.sh &> /root/codes/crawler.log


# Add a simple line to cron.log
echo "Cron job setup started." >> /var/log/cron.log

# Tail cron log to keep the container running
cron && tail -f /var/log/cron.log
