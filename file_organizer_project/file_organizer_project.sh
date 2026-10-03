#!/bin/bash

# Get the directory from the user
SOURCE_DIR="$1"


# Check if the user provided a directory
if [ -z "$SOURCE_DIR" ]; then

    echo "Please provide a directory"
    echo "Example: ./file_organizer.sh test_files"

    exit 1
fi


# Check if the directory exists
if [ ! -d "$SOURCE_DIR" ]; then

    echo "Error: Directory does not exist"

    exit 1
fi


# Create folders for different types of files

mkdir -p "$SOURCE_DIR/Images"
mkdir -p "$SOURCE_DIR/Documents"
mkdir -p "$SOURCE_DIR/Music"
mkdir -p "$SOURCE_DIR/Videos"
mkdir -p "$SOURCE_DIR/Scripts"


# Go through every item inside the directory

for file in "$SOURCE_DIR"/*
do

    # Check if the item is a file

    if [ -f "$file" ]
    then

        # Get the file extension

        extension="${file##*.}"


        # Decide where to move the file

        case "$extension" in

            # Image files

            jpg)
                mv "$file" "$SOURCE_DIR/Images/"
                ;;

            jpeg)
                mv "$file" "$SOURCE_DIR/Images/"
                ;;

            png)
                mv "$file" "$SOURCE_DIR/Images/"
                ;;

            gif)
                mv "$file" "$SOURCE_DIR/Images/"
                ;;


            # Document files

            pdf)
                mv "$file" "$SOURCE_DIR/Documents/"
                ;;

            doc)
                mv "$file" "$SOURCE_DIR/Documents/"
                ;;

            docx)
                mv "$file" "$SOURCE_DIR/Documents/"
                ;;

            txt)
                mv "$file" "$SOURCE_DIR/Documents/"
                ;;


            # Music files

            mp3)
                mv "$file" "$SOURCE_DIR/Music/"
                ;;

            wav)
                mv "$file" "$SOURCE_DIR/Music/"
                ;;


            # Video files

            mp4)
                mv "$file" "$SOURCE_DIR/Videos/"
                ;;

            mkv)
                mv "$file" "$SOURCE_DIR/Videos/"
                ;;

            avi)
                mv "$file" "$SOURCE_DIR/Videos/"
                ;;


            # Shell script files

            sh)
                mv "$file" "$SOURCE_DIR/Scripts/"
                ;;


            # Unknown file type

            *)
                echo "Unknown file: $file"
                ;;

        esac

    fi

done


# Show success message

echo "Files organized successfully!"

