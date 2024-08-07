#!/bin/bash

cd ahmia

MAX_TIME=8520
FINAL_MAX_TIME=8640

echo ""
time timeout --signal=SIGKILL $FINAL_MAX_TIME timeout --kill-after=120 --signal=SIGINT $MAX_TIME scrapy crawl ahmia-tor -s DEPTH_LIMIT=3
echo ""
