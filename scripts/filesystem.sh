#!/bin/bash

# ==========================================
# Project: Linux Admin Automation
# Script: File System Management
# Environment: Amazon Linux 2023
# ==========================================

while true
do
	echo "===================================="
	echo "    FILE SYSTEM MANAGEMENT"
	echo "===================================="

	echo "1. Create Directory"
	echo "2. Delete Directory"
	echo "3. List Directories"
	echo "4. Change Permissions"
	echo "5. Change Ownership"
	echo "6. Check Disk Usage"
	echo "7. Generate Disk Usage Report"
	echo "8. Exit"

	read -p "Enter your choice: " choice

	case $choice in

		1)
			echo "========== CREATE DIRECTORY =========="

			read -p "Enter directory path: " dirpath

			if [ -z "$dirpath" ]; then
				echo "Error: Directory path cannot be empty"

			elif [ -d "$dirpath" ]; then
				echo "Error: directory already exists"

			elif [ -e "$dirpath" ]; then
				echo "Error: A file with this name already exists"

			else
				mkdir -p -- "$dirpath"

				if [ $? -eq 0 ]; then
					echo "Directory created successfull"
				else
					echo "error: Directory creation failed"
				fi
			fi
			;;	

		2)
			echo "========== DELETE DIRECTORY =========="

			read -p "Enter directory path to delete: " dirpath

			if [ -z "$dirpath" ]; then
        			echo "Error: Directory path cannot be empty!"

			elif [ ! -d "$dirpath" ]; then
				echo "Error: Directory does not exist!"

			elif [[ "$dirpath" == "/" || "$dirpath" == "/linux-admin-automation" ]]; then
				echo "Error: Protected directory. Deletion not allowed!"

			else
				echo "WARNING: This will delete the directory and all its contents."

				read -p "Are you sure? (yes/no): " confirm

				if [[ "$confirm" == "yes" ]]; then
					rm -r -- "$dirpath"

					if [ $? -eq 0 ]; then
						echo "Directory deleted successfully!"
					else
						echo "Error: Directory deletion failed!"
					fi
				else
					echo "Directory deletion cancel"
				fi
			fi
			;;

		3)
			echo "========== LIST DIRECTORIES =========="

			read -p "Enter directory path to inspect: " dirpath

			if [ -z "$dirpath" ]; then
				echo "Error: Directory path cannot be empty!"

			elif [ ! -d "$dirpath" ]; then
				echo "Error: Directory does not exist!"

			else
				echo "Directories inside $dirpath:"
				find "$dirpath" -mindepth 1 -maxdepth 1 -type d -print
			fi
			;;

		4)
			echo "========== CHANGE PERMISSIONS =========="

			read -p "Enter file/directory path: " filepath

			if [ -z "$filepath" ]; then
        			echo "Error: Path cannot be empty!"

			elif [ ! -e "$filepath" ]; then
        			echo "Error: File or directory does not exist!"

			else
				read -p "Enter permission (e.g. 755, 644, 700): " permission
				
				if [[ ! "$permission" =~ ^[0-7]{3,4}$ ]]; then
            				echo "Error: Invalid permission format!"

				else
					chmod "$permission" "$filepath"

					if [ $? -eq 0 ]; then
                				echo "Permissions changed successfully!"
                				ls -ld "$filepath"
					else
						echo "Error: Permission change failed!"
					fi
				fi
			fi
			;;

		5)
			echo "========== CHANGE OWNERSHIP =========="

			read -p "Enter file/directory path: " filepath

			if [ -z "$filepath" ]; then
        			echo "Error: Path cannot be empty!"

			elif [ ! -e "$filepath" ]; then
        			echo "Error: File or directory does not exist!"

			else
				read -p "Enter new owner username: " owner
        			read -p "Enter new group name: " groupname

				if ! id "$owner" &>/dev/null; then
            				echo "Error: User does not exist!"

				elif ! getent group "$groupname" > /dev/null; then
            				echo "Error: Group does not exist!"

				else
					chown "$owner:$groupname" "$filepath"

					if [ $? -eq 0 ]; then
                				echo "Ownership changed successfully!"
                				ls -ld "$filepath"
					else
						echo "Error: Ownership change failed!"
					fi
				fi
			fi
			;;

		6)
			echo "========== DISK USAGE MONITOR =========="

    			echo ""
    			echo "1. Filesystem Disk Usage"
    			echo "2. Directory Disk Usage"

    			read -p "Enter your choice: " diskchoice

			case "$diskchoice" in
				1)
					echo "========== FILESYSTEM USAGE =========="
            				df -h
            				;;

				2)
					read -p "Enter directory path: " dirpath

					if [ -z "$dirpath" ]; then
                				echo "Error: Directory path cannot be empty!"

					elif [ ! -d "$dirpath" ]; then
                				echo "Error: Directory does not exist!"

					else
                				echo "========== DIRECTORY USAGE =========="
                				du -sh -- "$dirpath"
            				fi
            				;;

				*)
            				echo "Invalid disk usage option!"
            				;;

			esac
			;;

		7)
			echo "========== GENERATE DISK REPORT =========="

    			report_dir="/linux-admin-automation/reports"

    			timestamp=$(date +"%Y%m%d_%H%M%S")

    			report_file="$report_dir/disk_report_$timestamp.txt"

			if [ ! -d "$report_dir" ]; then
        			echo "Error: Reports directory does not exist!"

			elif [ ! -w "$report_dir" ]; then
        			echo "Error: No write permission for reports directory!"

			else
				{
					echo "========================================"
				        echo "       LINUX DISK USAGE REPORT"
            				echo "========================================"

            				echo "Generated On: $(date)"

            				echo ""
            				echo "========== FILESYSTEM USAGE =========="

            				df -h

            				echo ""
            				echo "========== PROJECT DIRECTORY USAGE =========="

            				du -sh /linux-admin-automation

            				echo ""
            				echo "========== REPORT COMPLETED =========="
				} | tee "$report_file"
				
				if [ ${PIPESTATUS[0]} -eq 0 ]; then
            				echo ""
            				echo "Report generated successfully!"
            				echo "Report location: $report_file"
				else
					echo "Error: Report generation failed!"
				fi
			fi
			;;


		8)
			echo "Exiting..."
			exit 0
			;;

		*)
			echo "Invalid Choice! Please select between 1 and 8."
			;;

	esac

	echo ""
	read -p "Press Enter to continue..."
done

