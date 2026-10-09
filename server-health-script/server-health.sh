#!/bin/bash

# ==========================================
# Server Health Monitoring Script
# ==========================================

LOG_FILE="logs/health.log"

# Create logs directory if it doesn't exist
mkdir -p logs


# ------------------------------------------
# Function: Log message
# ------------------------------------------
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}


# ------------------------------------------
# Function: Check CPU
# ------------------------------------------
check_cpu() {

    CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')

    CPU_USAGE=${CPU_USAGE%.*}

    echo "CPU Usage      : $CPU_USAGE%"

    if [ "$CPU_USAGE" -gt 80 ]; then
        echo "WARNING: High CPU usage!"
        log_message "WARNING: High CPU usage: $CPU_USAGE%"
        HEALTH_STATUS="UNHEALTHY"
    else
        echo "CPU Status     : Normal"
        log_message "CPU usage normal: $CPU_USAGE%"
    fi
}


# ------------------------------------------
# Function: Check Memory
# ------------------------------------------
check_memory() {

    MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

    echo "Memory Usage   : $MEMORY_USAGE%"

    if [ "$MEMORY_USAGE" -gt 80 ]; then
        echo "WARNING: High memory usage!"
        log_message "WARNING: High memory usage: $MEMORY_USAGE%"
        HEALTH_STATUS="UNHEALTHY"
    else
        echo "Memory Status  : Normal"
        log_message "Memory usage normal: $MEMORY_USAGE%"
    fi
}


# ------------------------------------------
# Function: Check Disk
# ------------------------------------------
check_disk() {

    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

    DISK_NUMBER=${DISK_USAGE%\%}

    echo "Disk Usage     : $DISK_USAGE"

    if [ "$DISK_NUMBER" -gt 80 ]; then
        echo "WARNING: High disk usage!"
        log_message "WARNING: High disk usage: $DISK_USAGE"
        HEALTH_STATUS="UNHEALTHY"
    else
        echo "Disk Status    : Normal"
        log_message "Disk usage normal: $DISK_USAGE"
    fi
}


# ------------------------------------------
# Function: Check Network
# ------------------------------------------
check_network() {

    if ping -c 1 8.8.8.8 &>/dev/null; then
        echo "Network Status : UP"
        log_message "Network status: UP"
    else
        echo "WARNING: Network is DOWN!"
        log_message "WARNING: Network is DOWN"
        HEALTH_STATUS="UNHEALTHY"
    fi
}


# ------------------------------------------
# Function: Server Information
# ------------------------------------------
server_information() {

    echo "Hostname       : $(hostname)"
    echo "Uptime         : $(uptime -p)"
    echo "Current User   : $(whoami)"
    echo "Date           : $(date '+%Y-%m-%d %H:%M:%S')"
}


# ------------------------------------------
# Main Program
# ------------------------------------------

HEALTH_STATUS="HEALTHY"

echo "=========================================="
echo "       SERVER HEALTH MONITOR"
echo "=========================================="

server_information

echo
echo "------------- SYSTEM HEALTH --------------"

check_cpu

check_memory

check_disk

check_network

echo
echo "=========================================="

if [ "$HEALTH_STATUS" = "HEALTHY" ]; then
    echo "SERVER STATUS : HEALTHY"
    log_message "Server status: HEALTHY"
else
    echo "SERVER STATUS : UNHEALTHY"
    log_message "Server status: UNHEALTHY"
fi

echo "=========================================="

echo
echo "Log file: $LOG_FILE"
