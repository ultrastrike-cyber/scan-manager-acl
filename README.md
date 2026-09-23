# scan-manager-acl
A simple PowerShell script to find groups in AD where the group Manager can update group membership.

## Usage

Just run the script from a domain-joined Windows system while logged in as a domain account.

`.\scan-manager-acl.ps1` 

The script enumerates all groups and collects groups with a manager set. The script then checks to see if the manager has an explicit ACL entry that permits them to make changes to the group.

The output is a table with group name, manager name, and permission. The listed manager account has permission to update membership of the corresponding group.

![Output Table](https://github.com/ultrastrike-cyber/scan-manager-acl/blob/main/sample-output.png?raw=true)
