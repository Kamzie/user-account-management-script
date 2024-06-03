#!/bin/bash

# This script takes in one or more user account names and disable the accounts as a default feature.

# The following options are available for the user account: -d to delete the acount, -r to delete the home directory, -a to archive the home directory.

# Default Archive Directory
ARCHIVE_DIR="/vagrant/archive"

# Check for root privilege
if [[ "${UID}" -ne 0 ]]; then
  echo "You do not have root privileges." >&2
  exit 1
fi

usage() {
  echo "Usage: ${0} [-adr] USER [USER...]" >&2
  echo "-a	Archive user account"
  echo "-d	Delete user account"
  echo "-r	Delete user home directory"
  echo "USER	user account name to disable."
  exit 1
}

# Initailising variables
DELETE_ACC='false'
DELETE_HOME='false'
ARCHIVE_ACC='false'

# Parsing options
while getopts adr OPTION; do
	case ${OPTION} in
		a)
		ARCHIVE_ACC='true'
		;;
		d)
                DELETE_ACC='true'
		;;
		r)
                DELETE_HOME='true'
                ;;
		?)
		usage
		;;
	esac
done

# Remove parse option from the list
shift "$((OPTIND -1))"

# If the user doesn't supply at least one argument.
if [[ $# -lt 1 ]]; then
  usage
fi

# For loop to process order.
for USER in "$@"; do

	# Check if the user exists and then find user UID.
	USER_UID=$(id -u "${USER}" 2>/dev/null)
	if [[ $? -ne 0 ]]; then
	  echo "User '${USER}' does not exist."
	  continue
	fi

	# Check if UID is greater than 1000.
	if (( USER_UID >= 1000 )); then
	  UID_VALID='true'
     	  echo "Processing user '${USER}' with UID '${USER_UID}'."
	else
	  UID_VALID='false'
	  echo "UID for '${USER}' is below 1000, skipping order."
	continue
	fi

	# Disable the user account as default if no other options are selected.
	if [[ ${DELETE_ACC} = 'false' && ${DELETE_HOME} = 'false' && ${ARCHIVE_ACC} = 'false' && ${UID_VALID} = 'true' ]]; then
	  chage -E 0 "${USER}"
	  echo "Account for '${USER}' has been disabled."
	fi

	# Naming convention for archive
	FILE_NAME="${USER}-$(date +%s%N | tail -c9)"

	# Archive the user's home directory
	HOME_DIR="/home/${USER}"
	ARCHIVE_FILE="${ARCHIVE_DIR}/${FILE_NAME}"
	
	if [[ ${ARCHIVE_ACC} = 'true' ]]; then
	  mkdir -p ${ARCHIVE_DIR}
	  tar -zcf ${ARCHIVE_FILE}.tgz ${HOME_DIR} 2>/dev/null	
	  if [[ $? -eq 0 ]]; then
	    echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}."
	  else
	    echo "Archive for user '${USER}' failed." 
	    continue
	  fi
	fi

	# Delete user's account
	if [[ ${DELETE_ACC} = 'true' && ${UID_VALID} = 'true' ]]; then
	  userdel "${USER}"
	  if [[ $? -eq 0 ]]; then
	    echo "User account '${USER}' was deleted."
	  else
	    echo "Failed to delete user account '${USER}'."
	    continue
	  fi
	fi

	# Remove user's home directory
	if [[ ${DELETE_HOME} = 'true' && ${UID_VALID} = 'true' ]]; then
	  rm -r /home/${USER}
	  if [[ $? -eq 0 ]]; then 
	    echo "Home directory for user "${USER}" was deleted."
	  else
	    echo "Failed to delete home directory for user '${USER}'."
	    continue
	  fi
   	fi
done

exit 0




































