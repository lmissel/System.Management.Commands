# Get the WMI class
[System.Management.ManagementScope] $s = [System.Management.ManagementScope]::new("root\cimv2");
[System.Management.ManagementPath] $p = [System.Management.ManagementPath]::new("Win32_Environment");
[System.Management.ObjectGetOptions] $o = [System.Management.ObjectGetOptions]::new($null, [System.TimeSpan]::MaxValue, $true);
[System.Management.ManagementClass] $c = [System.Management.ManagementClass]::new($s, $p, $o);