## User Account Management Script

This Bash script is designed to manage user accounts on a Unix-like system. It provides functionality to disable user accounts and perform additional actions such as archiving user directories and deleting user accounts and their associated home directories.

Features
Disables user accounts by default.
Supports multiple options for user account management:
-a: Archive user account.
-d: Delete user account.
-r: Delete user home directory.
Prerequisites
Unix-like operating system.
Bash shell.
Usage

<pre>
<code>
./user_account_management.sh [-adr] USER [USER...]
</code>
</pre>

-a: Archive user account.
-d: Delete user account.
-r: Delete user home directory.
USER: User account name to manage.
Example:

<pre>
<code>
./user_account_management.sh -d -r john
</code>
</pre>

This command will delete the user account john and its associated home directory.

Options
-a: Archive the user's home directory before performing any other action.
-d: Delete the specified user account.
-r: Remove the specified user's home directory.
Multiple Users Example
You can manage multiple users at once by specifying their usernames separated by spaces. For example, to archive, delete, and remove the home directories of multiple users john, jane, and doe, you would use:

<pre>
<code>
./user_account_management.sh -a -d -r john jane doe
</code>
</pre>

This command will:

Archive the home directories of john, jane, and doe.
Delete the user accounts john, jane, and doe.
Remove the home directories of john, jane, and doe.
Notes
Root privileges are required to run this script.
User accounts with a UID below 1000 will be skipped, as they are typically system accounts.
License
This script is licensed under the MIT License.

##