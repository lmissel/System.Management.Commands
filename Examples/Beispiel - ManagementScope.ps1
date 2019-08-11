
# Build an options object for the remote connection
# if you plan to connect to the remote
# computer with a different user name
# and password than the one you are currently using.
[System.Management.ConnectionOptions]  $options = [System.Management.ConnectionOptions]::new("MS_409", 
            "userName", 
            $pw, 
            "ntlmdomain:DOMAIN", 
            [System.Management.ImpersonationLevel]::Impersonate, 
            [System.Management.AuthenticationLevel]::Default,
            $true,
            $null, 
            [System.TimeSpan]::MaxValue);

# Make a connection to a remote computer.
[System.Management.ManagementScope] $ManagementScope = [System.Management.ManagementScope]::new("\\.\root\cimv2");
$ManagementScope.Connect();

# Query system for Operating System information
[System.Management.ObjectQuery] $ObjectQuery = [System.Management.ObjectQuery]::new("SELECT * FROM Win32_OperatingSystem");
[System.Management.ManagementObjectSearcher] $ManagementObjectSearcher = [System.Management.ManagementObjectSearcher]::new($ManagementScope,$ObjectQuery);

# Display the remote computer information
[System.Management.ManagementObjectCollection] $ManagementObjectCollection = $ManagementObjectSearcher.Get();
foreach ($ManagementObject in $ManagementObjectCollection)
{
    [Console]::WriteLine("Computer Name : {0}", $ManagementObject["csname"]);
    [Console]::WriteLine("Windows Directory : {0}", $ManagementObject["WindowsDirectory"]);
    [Console]::WriteLine("Operating System: {0}", $ManagementObject["Caption"]);
    [Console]::WriteLine("Version: {0}", $ManagementObject["Version"]);
    [Console]::WriteLine("Manufacturer : {0}", $ManagementObject["Manufacturer"]);
}