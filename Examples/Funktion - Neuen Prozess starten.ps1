# ----------------------
# Beispiel - Prozess starten
# ----------------------
[System.Management.InvokeMethodOptions] $methodOptions = [System.Management.InvokeMethodOptions]::new($null, [System.TimeSpan]::MaxValue)
[System.Management.ManagementClass] $processClass = [System.Management.ManagementClass]::new("Win32_Process")
[System.Management.ManagementBaseObject] $inParams = $processClass.GetMethodParameters("Create")
$inParams["CommandLine"] = "C:\\Windows\\System32\\notepad.exe"
$inParams["CurrentDirectory"] = "C:\\Windows\\System32\\"
$processClass.InvokeMethod("Create", $inParams, $methodOptions)

# Variante 2

[System.Management.ManagementClass] $processClass = [System.Management.ManagementClass]::new("Win32_Process")
[Object[]] $methodArgs = "C:\Windows\System32\notepad.exe", $null, $null, 0
$processClass.InvokeMethod("Create", $methodArgs)