#!/bin/bash

show_menu() {
    echo
    echo "================================="
    echo "     USER MANAGEMENT SYSTEM"
    echo "================================="
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. Create Group"
    echo "4. Delete Group"
    echo "5. Add User to Group"
    echo "6. Remove User from Group"
    echo "7. User Information"
    echo "8. List Users"
    echo "9. exit"
    echo "================================="
}

LOG_FILE="User_management.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

create_user(){
	read -p "username:" username

	if [ -z "$username" ]; then
		echo "enter an an valid username"
		return
	fi

	if ! id "$username" &>/dev/null; then
		echo "Error: User '$username' does not exist"
		return 1
        fi

	sudo useradd "$username"


	if [ $? -eq 0 ]; then
		echo "username $username is created sucessfully"
		log_message "User $username created successfully"

		sudo passwd "$username"

	else
		echo "user creation failed"
		log_message "Failed to create user $username"
	fi
}

delete_user(){
	read -p "Enter username to delete:" username

	if [ -z "$username" ]; then
		echo "username cannot be empty"
		return
	fi

	if ! id "$username" &>/dev/null; then
		echo "Error: User '$username' does not exist"
		return 1
	fi

	sudo userdel "$username"

	if [ $? -eq 0 ]; then
		echo "$username deleted sucessfully"
		log_message "User $username deleted successfully"
	else
		echo " Deletion failed"
		log_message "Failed to delete user $username"
	fi
}

create_group(){
	read -p "Enter groupname:" groupname

	if [ -z "$groupname" ]; then
		echo "groupname cannot be empty"
	fi

	if ! getent group "$group" &>/dev/null; then
		 echo "Error: group '$groupname' does not exist"
		 return 1
	 fi

	sudo groupadd "$groupname"

	if [ $? -eq 0 ]; then
		echo "$groupname created sucessfully"
		log_message "group $groupname created successfully"
	else
		echo "failed to create group"
		log_message "Failed to create group $groupname"
	fi
}

delete_group(){
	    read -p "Enter group name to delete: " groupname

	    if [ -z "$groupname" ]; then
		    echo "groupname cannot be empty"
	    fi


            if ! getent group "$groupname" &>/dev/null; then
		    echo "Error: group '$groupname' does not exist"
		    return 1
	    fi

            sudo groupdel "$groupname"

           if [ $? -eq 0 ]; then
		   echo "$groupname deleted successfully"
		   log_message "group $groupname deleted successfully"
	   else
		   echo "Group deletion failed"
		   log_message "Failed to delete group $groupname"
	   fi
}

add_user_group(){
	read -p "username:" username
	read -p "groupname:" groupname


	if [ -z "$username" ] || [ -z "$groupname" ]; then
		echo " the username and the groupname cannot be empty"
		return
	fi


        if ! id "$username" &>/dev/null; then
	       	echo "Error: User '$username' does not exist"
	       	return 1
       	fi

 
        if ! getent group "$groupname" &>/dev/null; then
		echo "Error: group '$groupname' does not exist"
		return 1
        fi

	sudo usermod -aG "$groupname" "$username"

        if [ $? -eq 0 ]; then
	        echo "$username added to $groupname"
		log_message "User $username added in $groupname successfully"
	else
	        echo "user name added"
		log_message "Failed to add $username to group $groupname"
	fi
}

remove_user_from_group(){
	read -p "username:" username
	read -p "groupname:" groupname

	if [ -z "$username" ] || [ -z "$groupname" ]; then
		echo "the username and groupname cannot be empty"
		return
	fi


        if ! id "$username" &>/dev/null; then
	       	echo "Error: User '$username' does not exist"
	       	return 1
	fi


        if ! getent group "$groupname" &>/dev/null; then
		echo "Error: group '$groupname' does not exist" 
		return 1
       	fi

	sudo gpasswd "$username" "$groupname"

	if [ $? -eq 0 ]; then
		echo "$username removed $groupname"
		log_message "User $username is removed from $groupname successfully"
	else
		echo "failed to remove"
		log_message "Failed to remove $username from group $groupname"
	fi
}

user_information(){
    read -p "Enter username: " username

    if id "$username" &>/dev/null; then
        echo "===== USER INFORMATION ====="
        id "$username"
        echo
        echo "Groups:"
        groups "$username"

	log_message "Viewed information for user $username"
    else
        echo "User does not exist"
	log_message "Failed to get user information"
    fi
}

List_user(){
	echo "======User======"
	
	cut -d: -f1 /etc/passwd

}

show_menu

while true
do
	read -p "enter your choice:" choice

	case $choice in

		1)
			create_user
			;;

		2)
			delete_user
			;;

		3)
			create_group
			;;
		4)
			delete_group
			;;

		5)
			add_user_group
			;;

		6)
			remove_user_from_group
			;;

		7)
			user_information
			;;

		8)
			List_user
			;;

		9)
                        echo "Exiting..."
                        exit 0
			;;
		*)
                        echo "Invalid choice"
                        ;;
	esac
done
