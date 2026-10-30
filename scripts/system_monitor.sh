#!/bin/bash

# Function to monitor CPU usage
check_cpu_usage() {

    echo "========================================"
    echo "          CPU USAGE MONITOR"
    echo "========================================"

    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

    echo "CPU Usage: ${cpu_usage}%"

    echo "========================================"
}

# Function to monitor memory usage
check_memory_usage() {

    echo "========================================"
    echo "        MEMORY USAGE MONITOR"
    echo "========================================"

    free -h

    echo ""
    echo "Memory Usage Percentage:"

    memory_usage=$(free | awk '/Mem:/ {
        printf "%.2f", ($3/$2)*100
    }')

    echo "Memory Used: ${memory_usage}%"

    echo "========================================"
}

# Function to monitor disk usage
check_disk_usage() {

    echo "========================================"
    echo "          DISK USAGE MONITOR"
    echo "========================================"

    df -h

    echo ""
    echo "Root Filesystem Usage:"

    root_usage=$(df -h / | awk 'NR==2 {print $5}')

    echo "Root Disk Usage: ${root_usage}"

    echo "========================================"
}

# Function to display system information
show_system_info() {

    echo "========================================"
    echo "          SYSTEM INFORMATION"
    echo "========================================"

    echo "Hostname: $(hostname)"
    echo "Operating System: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)"
    echo "Kernel Version: $(uname -r)"
    echo "System Uptime: $(uptime -p)"
    echo "Current Date: $(date)"

    echo "========================================"
}

# Function to run complete system monitoring
run_all_checks() {

    echo ""
    echo "########################################"
    echo "       COMPLETE SYSTEM MONITOR"
    echo "########################################"
    echo ""

    show_system_info
    check_cpu_usage
    check_memory_usage
    check_disk_usage

    echo ""
    echo "########################################"
    echo "       MONITORING COMPLETED"
    echo "########################################"
}

# Function to generate system monitoring report
generate_monitoring_report() {

    report_dir="/linux-admin-automation/reports"
    timestamp=$(date +"%Y%m%d_%H%M%S")
    report_file="$report_dir/system_report_$timestamp.txt"

    if [ ! -d "$report_dir" ]; then
        echo "Error: Reports directory does not exist!"
        return 1
    fi

    if [ ! -w "$report_dir" ]; then
        echo "Error: No write permission for reports directory!"
        return 1
    fi

    echo "Generating system monitoring report..."

    {
        run_all_checks
    } > "$report_file" 2>&1

    if [ $? -eq 0 ]; then
        echo "Report generated successfully!"
        echo "Report location: $report_file"
    else
        echo "Error: Report generation failed!"
        return 1
    fi
}

# Function for periodic system monitoring
start_periodic_monitoring() {

    read -p "Enter monitoring interval in seconds: " interval

    if [[ ! "$interval" =~ ^[0-9]+$ ]] || [ "$interval" -lt 1 ]; then
        echo "Error: Enter a valid interval greater than zero."
        return 1
    fi

    echo "Starting periodic monitoring..."
    echo "Monitoring interval: $interval seconds"
    echo "Press Ctrl+C to stop monitoring."

    while true; do

        echo ""
        echo "Generating monitoring report..."

        generate_monitoring_report

        echo "Next monitoring cycle in $interval seconds."

        sleep "$interval"

    done
}

# Main menu
main_menu() {

    while true; do

        echo ""
        echo "========================================"
        echo "       SYSTEM MONITORING MENU"
        echo "========================================"
        echo "1. Show System Information"
        echo "2. Check CPU Usage"
        echo "3. Check Memory Usage"
        echo "4. Check Disk Usage"
        echo "5. Run Complete System Monitoring"
        echo "6. Generate Monitoring Report"
        echo "7. Start Periodic Monitoring"
        echo "8. Exit"
        echo "========================================"

        read -p "Enter your choice: " choice

        case "$choice" in

            1) show_system_info ;;
            2) check_cpu_usage ;;
            3) check_memory_usage ;;
            4) check_disk_usage ;;
            5) run_all_checks ;;
            6) generate_monitoring_report ;;
            7) start_periodic_monitoring ;;
            8)
                echo "Exiting System Monitoring..."
                break
                ;;
            *)
                echo "Invalid choice! Please select 1-8."
                ;;
        esac

        if [[ "$choice" != "8" ]]; then
            read -p "Press Enter to continue..."
        fi

    done
}

# Launch the main menu
main_menu
