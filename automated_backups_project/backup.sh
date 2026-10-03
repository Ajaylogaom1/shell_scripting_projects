#!/bin/bash

SOURCE_DIR=$1
BACKUP_DIR=$2

LOG_FILE="$BACKUP_DIR/backup.log"

check_arguments(){
	if [ -z "$SOURCE_DIR" ] || [ -z "$BACKUP_DIR" ]; then
	       	echo "Usage: $0 <source_directory> <backup_directory>"
	       	exit 1
	fi
}

create_directory(){
	mkdir -p "$BACKUP_DIR"
}

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}


create_backup(){
	TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
	
	BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
	
	if tar -czf "$BACKUP_FILE" "$SOURCE_DIR"; then
		log_message "backup created sucessfully: $BACKUP_FILE"
		echo "backup crated sucessfully"
		echo "$BACKUP_FILE"
	else
		log_message "backup failed"
		echo "backup failed"
		exit 1
	fi
	
}

check_arguments
create_directory
log_message "Backup started"
create_backup
	
