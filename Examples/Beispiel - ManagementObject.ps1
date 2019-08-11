[System.Management.ManagementObject] $o = [System.Management.ManagementObject]::new();

# Now set the path on this object to
# bind it to a 'real' manageable entity
$o.Path = [System.Management.ManagementPath]::new("Win32_LogicalDisk='c:'"); 

# Now it can be used 
[Console]::WriteLine($o["FreeSpace"]);