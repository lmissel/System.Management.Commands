[System.Management.ManagementScope] $scope = [System.Management.ManagementScope]::new("root\CIMV2")
[System.Management.SelectQuery] $q = [System.Management.SelectQuery]::new("SELECT * FROM Win32_LogicalDisk")
[System.Management.EnumerationOptions] $o = [System.Management.EnumerationOptions]::new($null, [System.TimeSpan]::MaxValue, 1, $true, $false, $true, $true, $false, $true, $true);

[System.Management.ManagementObjectSearcher] $s = [System.Management.ManagementObjectSearcher]::new($scope, $q, $o)
foreach ($disk in $s.Get()) 
{
    [Console]::WriteLine($disk.ToString());
}