#!/bin/bash

# GamerX Log Collection Script
# This script collects all installation logs into a single file

LOG_COLLECTION_FILE="/tmp/gx_installation_logs_$(date +%Y%m%d_%H%M%S).txt"

echo "=== GamerX Linux Installation Log Collection ===" > "$LOG_COLLECTION_FILE"
echo "Generated on: $(date)" >> "$LOG_COLLECTION_FILE"
echo "===============================================" >> "$LOG_COLLECTION_FILE"
echo "" >> "$LOG_COLLECTION_FILE"

# Function to append log file if it exists
append_log() {
    local log_file="$1"
    local log_name="$2"
    
    if [ -f "$log_file" ]; then
        echo "=== $log_name ===" >> "$LOG_COLLECTION_FILE"
        echo "File: $log_file" >> "$LOG_COLLECTION_FILE"
        echo "Size: $(du -h "$log_file" | cut -f1)" >> "$LOG_COLLECTION_FILE"
        echo "Last modified: $(stat -c %y "$log_file")" >> "$LOG_COLLECTION_FILE"
        echo "----------------------------------------" >> "$LOG_COLLECTION_FILE"
        cat "$log_file" >> "$LOG_COLLECTION_FILE"
        echo "" >> "$LOG_COLLECTION_FILE"
        echo "" >> "$LOG_COLLECTION_FILE"
    else
        echo "=== $log_name ===" >> "$LOG_COLLECTION_FILE"
        echo "File: $log_file (NOT FOUND)" >> "$LOG_COLLECTION_FILE"
        echo "----------------------------------------" >> "$LOG_COLLECTION_FILE"
        echo "Log file not found or empty" >> "$LOG_COLLECTION_FILE"
        echo "" >> "$LOG_COLLECTION_FILE"
        echo "" >> "$LOG_COLLECTION_FILE"
    fi
}

# Collect main installer logs
echo "Collecting main installer logs..." >> "$LOG_COLLECTION_FILE"
for log_file in /tmp/gxinstall_logs/gxinstall_*.log; do
    if [ -f "$log_file" ]; then
        append_log "$log_file" "Main Installer Log"
    fi
done

# Collect profile installer logs
echo "Collecting profile installer logs..." >> "$LOG_COLLECTION_FILE"
append_log "/tmp/hyprland_installer.log" "Hyprland Installer Log"
append_log "/tmp/gaming_installer.log" "Gaming Installer Log"
append_log "/tmp/hacking_installer.log" "Hacking Installer Log"

# Collect profile package installation logs
echo "Collecting profile package installation logs..." >> "$LOG_COLLECTION_FILE"
append_log "/tmp/hyprland_profile_install.log" "Hyprland Profile Package Installation Log"
append_log "/tmp/gaming_profile_install.log" "Gaming Profile Package Installation Log"
append_log "/tmp/hacking_profile_install.log" "Hacking Profile Package Installation Log"

# Collect system information
echo "=== System Information ===" >> "$LOG_COLLECTION_FILE"
echo "Kernel: $(uname -r)" >> "$LOG_COLLECTION_FILE"
echo "Architecture: $(uname -m)" >> "$LOG_COLLECTION_FILE"
echo "Distribution: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)" >> "$LOG_COLLECTION_FILE"
echo "Available memory: $(free -h | grep Mem | awk '{print $2}')" >> "$LOG_COLLECTION_FILE"
echo "Disk space: $(df -h / | tail -1 | awk '{print $4}') available" >> "$LOG_COLLECTION_FILE"
echo "" >> "$LOG_COLLECTION_FILE"

# Collect package manager logs
echo "=== Package Manager Logs ===" >> "$LOG_COLLECTION_FILE"
if [ -f "/var/log/pacman.log" ]; then
    echo "Last 50 pacman log entries:" >> "$LOG_COLLECTION_FILE"
    tail -50 /var/log/pacman.log >> "$LOG_COLLECTION_FILE"
else
    echo "Pacman log not found" >> "$LOG_COLLECTION_FILE"
fi
echo "" >> "$LOG_COLLECTION_FILE"

# Collect error logs
echo "=== Error Logs ===" >> "$LOG_COLLECTION_FILE"
if [ -f "/var/log/messages" ]; then
    echo "Recent system messages:" >> "$LOG_COLLECTION_FILE"
    tail -20 /var/log/messages >> "$LOG_COLLECTION_FILE"
else
    echo "System messages log not found" >> "$LOG_COLLECTION_FILE"
fi
echo "" >> "$LOG_COLLECTION_FILE"

echo "Log collection completed: $LOG_COLLECTION_FILE"
echo "File size: $(du -h "$LOG_COLLECTION_FILE" | cut -f1)"
echo ""
echo "You can now provide this log file for debugging purposes."
echo "Location: $LOG_COLLECTION_FILE" 