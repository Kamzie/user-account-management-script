# User Account Management Script

The purpose of this script is to assist me in managing user accounts created during my Linux administration learning process. Often, when deleting user accounts like "John," "Jane," and "Doe," I realised that their home directories still existed, and there were entries in /etc/passwd and other locations.

To streamline user account management, this script offers functionality to disable user accounts by default. Additionally, it provides options to archive home directories, delete user accounts, or delete their home directories.

## Features

- Disables user accounts by default.
- Supports multiple options for user account management:
  - `-a`: Archive user account.
  - `-d`: Delete user account.
  - `-r`: Delete user home directory.

## Default Archive Directory

By default, the script archives user home directories to `/vagrant/archive`. You can modify this directory by editing the `ARCHIVE_DIR` variable in the script.

If no option is provided, the default action is to disable the user account. This means that if no `-a`, `-d`, or `-r` option is specified, the script will disable the user account(s) provided as arguments.

## Error Handling

- The script checks for root privileges. If run without root privileges, it displays an error message and exits.
- If no options are provided or if insufficient arguments are passed, the script displays usage instructions and exits.

## Usage

1. **Make the script executable:**

   ```bash
   chmod +x user_account_management.sh

   ```

2. Run the script with the desired options:

   <pre>
   <code>
   ./user_account_management.sh [-adr] USER [USER...]
   </code>
   </pre>

   - `-a`: Archive user account.
   - `-d`: Delete user account.
   - `-r`: Delete user home directory.
   - `USER`: User account name to manage.

   Example:

   <pre>
   <code>
   ./user_account_management.sh -d -r john
   </code>
   </pre>

   This command will delete the user account `john` and its associated home directory.

   ![Screenshot of terminal once user_account_management.sh deleting the account john](./user_account_01.png)

## Options

- `-a`: Archive the user's home directory before performing any other action.
- `-d`: Delete the specified user account.
- `-r`: Remove the specified user's home directory.

## Multiple Users Example

You can manage multiple users at once by specifying their usernames separated by spaces. For example, to archive, delete, and remove the home directories of multiple users `john`, `jane`, and `doe`, you would use:

   <pre>
   <code>
   ./user_account_management.sh -a -d -r john jane doe
   </code>
   </pre>

This command will:

- Archive the home directories of `john`, `jane`, and `doe`.
- Delete the user accounts `john`, `jane`, and `doe`.
- Remove the home directories of `john`, `jane`, and `doe`.

  ![Screenshot of terminal once user_account_management.sh, archiving and deleting the accounts john, jane and doe](./user_account_02.png)

## Final Prompts

After executing each option, the script provides final prompts indicating the completion of the action. For example:

- If an account is disabled: "Account for 'USER' has been disabled."
- If a user account is deleted: "User account 'USER' was deleted."
- If a home directory is deleted: "Home directory for user 'USER' was deleted."

## Notes

- Root privileges are required to run this script.
- User accounts with a UID below 1000 will be skipped, as they are typically system accounts.
