#!/usr/bin/env bash
CHROME_RUNNING=$(ps aux | grep "chrome" | wc -l)
IDLE_PROCS=1
if [ "$CHROME_RUNNING" -gt "$IDLE_PROCS" ]; then
    echo "CHROME IS RUNNING"
fi
