#!/bin/bash

# ==========================================
# Project: Linux Admin Automation
# Script: User and Group Management
# Environment: Amazon Linux 2023
# ==========================================

while true
do 
	echo "===================================="
	echo "   LINUX USER & GROUP MANAGEMENT"
	echo "===================================="

	echo "1. Add User"
	echo "2. Delete User"
	echo "3. List Users"
	echo "4. Create Group"
	echo "5. Delete Group"
	echo "6. List Groups"
	echo "7. Add user to group"
	echo "8. Remove user from group"
	echo "9. Exit"

	read -p "Enter your choice: " choice

	case $choice in
		1)
			echo "========== ADD NEW USER =========="

			read -p "Enter username: " username

			if id "$username" &>/dev/null; then
				echo "Error: User already exists!"
			else
				useradd -m "$username"

				if [ $? -eq 0 ]; then
					echo "User $username created successfully"

					passwd "$username"

				else
					echo "Error: User creation failed"
				fi
			fi
			;;

		2)
			echo "========== DELETE USER =========="

    			read -p "Enter username to delete: " username

    			if [ -z "$username" ]; then
        			echo "Error: Username cannot be empty!"

    			elif [[ "$username" == "root" || "$username" == "ec2-user" ]]; then
        			echo "Error: Cannot delete protected system user!"

    			elif ! id "$username" &>/dev/null; then
        			echo "Error: User does not exist!"

    			else
        			read -p "Are you sure you want to delete $username? (yes/no): " confirm

        			if [[ "$confirm" == "yes" ]]; then
            				userdel -r "$username"

            				if [ $? -eq 0 ]; then
                				echo "User $username deleted successfully!"
            				else
                				echo "Error: User deletion failed!"
            				fi
        			else
            				echo "User deletion cancelled."
        			fi
    			fi
    			;;
		

		3)
			echo "========== SYSTEM USERS =========="
    			cut -d: -f1 /etc/passwd
    			;;

		4)
       			echo "========== CREATE NEW GROUP =========="

			read -p "enter group name: " groupname

			if [ -z "$groupname" ]; then
				echo "Error: Group name cannot be empty"

			elif getent group "$groupname" > /dev/null; then
				echo "Error: Group already exists"

			else
				groupadd "$groupname"

				if [ $? -eq 0 ]; then
					echo "Group $groupname created successfull"
				else
					echo "Error: group creation failed"
				fi
			fi
			;;

      		5)
    			echo "========== DELETE GROUP =========="

    			read -p "Enter group name to delete: " groupname
	
    			if [ -z "$groupname" ]; then
        			echo "Error: Group name cannot be empty!"

    			elif [[ "$groupname" == "root" || "$groupname" == "wheel" ]]; then
        			echo "Error: Cannot delete protected system group!"

    			elif ! getent group "$groupname" > /dev/null; then
        			echo "Error: Group does not exist!"

    			else
        			read -p "Are you sure you want to delete $groupname? (yes/no): " confirm

        			if [[ "$confirm" == "yes" ]]; then
            				groupdel "$groupname"

            				if [ $? -eq 0 ]; then
                				echo "Group $groupname deleted successfully!"
            				else
                				echo "Error: Group deletion failed!"
            				fi
        			else
            				echo "Group deletion cancelled."
        			fi
    			fi
    			;;

    		6)
    			echo "========== SYSTEM GROUPS =========="
    			cut -d: -f1 /etc/group
    			;;

		7)
			echo "========== ADD USER TO GROUP =========="

			read -p "Enter user name: " username
			read -p "Enter group name: " groupname

			if ! id "$username" &>/dev/null; then
				echo "Error: User does not exist"

			elif ! getent group "$groupname" > /dev/null; then
				echo "Error: Group does not exist"

			else
				usermod -aG "$groupname" "$username"

				if [ $? -eq 0 ]; then
					echo "user added to group successfull"
				else
					echo "Error: Failed to add user to group"
				fi
			fi
			;;

		8)
			echo "========== REMOVE USER FROM GROUP =========="

			read -p "Enter username: " username
			read -p "Enter group name: " groupname

			if ! id "$username" &>/dev/null; then
				echo "Error: username does not exist"

			elif ! getent group "$groupname" > /dev/null; then
				echo "Error: group doesn't exist"

			elif [ "$(id -gn "$username")" = "$groupname" ]; then
				echo "Error: Cannot remove the user's primary group"

			elif ! id -nG "$username" | tr ' ' '\n' | grep -Fxq "$groupname"; then
				echo "User is not a member of this group"

			else
				gpasswd -d "$username" "$groupname"

				if [ $? -eq 0 ]; then
					echo "user removed from group successfully"
				else
					echo "Error: failed to remove user from group"
				fi
			fi
			;;

    		9)
        		echo "Exiting..."
        		exit 0
        		;;

    		*)
        		echo "Invalid Choice! Please select between 1 and 7."
        		;;

	esac

	echo ""
	read -p "Press Enter to continue..."

done
