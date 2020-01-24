#!/bin/bash

# Get parameters
while getopts ":d:u:p:i:l:" opt; do
  case $opt in
    d) DATABASE="$OPTARG"
    ;;
    u) USER="$OPTARG"
    ;;
    p) PASSWORD="$OPTARG"
    ;;
    i) IDENTITY="$OPTARG"
    ;;
    l) LOCATION="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# Check parameters
if [ -z ${DATABASE+x} ] || [ -z ${USER+x} ] || [ -z ${PASSWORD+x} ] || [ -z ${LOCATION+x} ]; then
	
	# Stop
	echo "Please provide database details with -d DATABASE -u USER -p PASSWORD and a LOCATION with -l /your/location/"

else
	
	CURRENT_DATE=$(date +"%Y-%m-%d")


	# Preparing backup directory if it doesn't exists
	mkdir -p ~/.backups

	# Entering the directory
	cd ~/.backups

	# Do the backup and compress it to a gz file
	echo "Starting the new backup. This may take a while..."

	mysqldump -u $USER -p$PASSWORD $DATABASE | gzip > "$DATABASE.$CURRENT_DATE.sql.gz"

	echo "Local backup finished."

	# Copy to LOCATION
	if [ -z ${IDENTITY+x} ]; then
		
		# Moving it to the specified location
		echo "Moving it to the specified location..."
		mv "$DATABASE.$CURRENT_DATE.sql.gz" $LOCATION
		
	else
		
		# Copy it via scp
		echo "Starting to copy it via SSH."
		scp -i $IDENTITY "$DATABASE.$CURRENT_DATE.sql.gz" $LOCATION

		echo "Removing the local file."
		rm "$DATABASE.$CURRENT_DATE.sql.gz"
		
	fi

	echo "Done!"

fi