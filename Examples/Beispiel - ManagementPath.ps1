# Get the WMI class path
[System.Management.ManagementPath] $p = [System.Management.ManagementPath]::new("\\.\root\cimv2:Win32_LogicalDisk.DeviceID='C:\'");

[Console]::WriteLine("IsClass: " + $p.IsClass);
[Console]::WriteLine("IsInstance: " + $p.IsInstance);
[Console]::WriteLine("ClassName: " + $p.ClassName);
[Console]::WriteLine("NamespacePath: " + $p.NamespacePath);
[Console]::WriteLine("Server: " + $p.Server);
[Console]::WriteLine("Path: " + $p.Path);
[Console]::WriteLine("RelativePath: " + $p.RelativePath);