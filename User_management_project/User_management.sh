#!/bin/bash

create_user(){
	read -p "username:" username

	sudo useradd "$username"

	if [ $? -eq 0 ]; then
		echo "username $username is created sucessfully"

		sudo passwd "$username"

	else
		echo "user creation failed"
	fi
}

delete_user(){
	read -p "Enter username to delete:" username

	sudo userdel "$username"

	if [ $? -eq 0 ]; then
		echo "$username deleted sucessfully"
	else
		echo " Deletion failed"
	fi
}

create_group(){
	read -p "Enter groupname:" groupname

	sudo groupadd "$groupname"

	if [ $? -eq 0 ]; then
		echo "$group created sucessfully"
	else
		echo "failed to created"
	fi
}
add_user_group(){
	read -p "username:" username
	read -p "groupname:" groupname
	
	sudo usermod -aG "$groupname" "$username"

        if [ $? -eq 0 ]; then
	        echo "$username added to $groupname"
	else
	        echo "user namot added"
	fi
}

remove_user_from_group(){
	read -p "username:" username
	read -p "groupname:" groupname

	sudo gpasswd -d "$username" "$groupname"

	if [ $? -eq 0 ]; then
		echo "$username removed $groupname"
	else
		echo "failed to remove"
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
    else
        echo "User does not exist"
    fi
}

List_user(){
	echo "======User======"
	
	cut -d: -f1 /etc/passwd

}


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
			add_user_group
			;;

		5)
			remove_user_from_group
			;;

		6)
			user_information
			;;

		7)
			list_user
			;;

		8)
                        echo "Exiting..."
                        exit 0
			;;
		*)
                        echo "Invalid choice"
                        ;;
	esac
done
