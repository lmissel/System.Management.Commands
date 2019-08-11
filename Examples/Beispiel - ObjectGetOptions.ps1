# Get the WMI class
# Options specify that amended qualifiers
# should be retrieved along with the class
[System.Management.ObjectGetOptions] $ObjectGetOptions = [System.Management.ObjectGetOptions]::new($null, [System.TimeSpan]::MaxValue, $true)
[System.Management.ManagementClass] $class = [System.Management.ManagementClass]::new("Win32_ComputerSystem",$ObjectGetOptions)

