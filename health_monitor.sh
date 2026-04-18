#!/bin/bash
# Automated Linux Server Health Monitor & Alert System
# Author: Mohammad Kaif

LOG_FILE="system_health.log"

echo "Starting Health Monitor... (Press Ctrl+C to stop)"
echo "Logging data to $LOG_FILE"

# The "while true" creates an infinite loop so it runs forever (Automation!)
while true
do
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Grab the exact percentage of your C: drive (Using awk to filter the text)
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $(NF-1)}')
    # Remove the % sign so we can do math on the number
    DISK_USAGE_NUM=${DISK_USAGE%\%}

    echo "[$TIMESTAMP] Running system check..."

    echo "=======================================" >> $LOG_FILE
    echo " HEALTH REPORT - $TIMESTAMP " >> $LOG_FILE
    echo "=======================================" >> $LOG_FILE

    # CPU/Process check (Using 'ps' to count running processes since 'uptime' failed on Windows)
    PROCESS_COUNT=$(ps -e | wc -l)
    echo "--> ACTIVE PROCESSES: $PROCESS_COUNT" >> $LOG_FILE

    # Disk Alert Logic (If disk is over 90% full, trigger a warning)
    if [ "$DISK_USAGE_NUM" -ge 90 ]; then
        echo "--> [WARNING] DISK SPACE CRITICAL: $DISK_USAGE" >> $LOG_FILE
        echo " ⚠️ ALERT: Disk usage is critically high ($DISK_USAGE)!" # Prints to your screen!
    else
        echo "--> [OK] Disk Space Normal: $DISK_USAGE" >> $LOG_FILE
    fi

    echo "---------------------------------------" >> $LOG_FILE

    # Pause for 5 seconds before checking again
    sleep 5
done