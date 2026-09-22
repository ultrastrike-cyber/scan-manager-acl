# Script to find groups where the group manager can update the group membership
# i.e. where "Manager can update membership list" is checked in Active Directory Users and Computers console
# 
# Author: Carl Pearson
# Ultrastrike Cybersecurity
#

# Array to hold results
$results = @()

# Collect all groups in the environment.
# Include the ManagedBy attribute, which stores the manager if one has been set
$groups = Get-ADGroup -Filter * -properties Name, distinguishedName, ManagedBy

# Iterate through each group
foreach ($group in $groups) {
	# Check if the group has a manager. Only proceed if the group has a manager set
	if ($group.ManagedBy -ne $null) {
		# Get the manager's AD user object and SamAccountName attribute
		$manager = Get-ADUser $group.ManagedBy -Properties SamAccountName
		
		# Get the ACL of the current group
		$acl = Get-ACL "AD:$($group.distinguishedName)"
		
		# Parse out the manager user's permissions
		$manageracl = $acl | Select-Object -ExpandProperty Access | Where-Object IdentityReference -like "*$($manager.SamAccountName)*" | Where-Object ActiveDirectoryRights -eq "WriteProperty"
		
		# If the manager has access rights granted, then add the account to the results array for later reporting
		if ($manageracl.ActiveDirectoryRights -ne $null) {
			$results += [PSCustomObject]@{Group = $group.Name; Manager = $manageracl.IdentityReference; Permission = $manageracl.ActiveDirectoryRights}
		}
	}
}
# Output results
$results