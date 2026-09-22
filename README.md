# scan-manager-acl
A simple PowerShell script to find groups in AD where the group Manager can update group membership.

## Usage

`.\scan-manager-acl.ps1` 

Returns a table with group name, manager name, and permission. The listed manager account has permission to update membership of the corresponding group.
