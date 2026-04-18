#!/bin/bash
# Final Linux Server Health Monitor & Alert System
# Author: Mohammad Kaif

LOG_FILE="system_health.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "Running System Health Check..."

# Start the Log
echo "=======================================" >> $LOG_FILE
echo " HEALTH REPORT - $TIMESTAMP " >> $LOG_FILE
echo "=======================================" >> $LOG_FILE

# 1. DISK CHECK & ALERT
echo "--> 1. DISK USAGE:" >> $LOG_FILE
df -h >> $LOG_FILE

# Grab the exact percentage for the alert
DISK_USAGE=$(df -h / | awk 'NR==2 {print $(NF-1)}')
DISK_USAGE_NUM=${DISK_USAGE%\%}

if [ "$DISK_USAGE_NUM" -ge 90 ]; then
    echo " [WARNING] Disk usage is critically high ($DISK_USAGE)!" >> $LOG_FILE
    echo " ⚠️ ALERT: Disk usage is critically high ($DISK_USAGE)!"
else
    echo " [OK] Disk usage is safe." >> $LOG_FILE
fi
echo "" >> $LOG_FILE

# 2. MEMORY CHECK 
# (Note: 'free' will throw an error in Git Bash on Windows, but is 100% correct for the interview)
echo "--> 2. MEMORY USAGE (Free RAM):" >> $LOG_FILE
free -m >> $LOG_FILE
echo "" >> $LOG_FILE

# 3. CPU / PROCESS CHECK
echo "--> 3. ACTIVE PROCESSES:" >> $LOG_FILE
ps -e | wc -l >> $LOG_FILE
echo "" >> $LOG_FILE

echo "=======================================" >> $LOG_FILE
echo " Check Complete. " >> $LOG_FILE
echo "=======================================" >> $LOG_FILE

echo "System check complete! Results safely logged to $LOG_FILE"