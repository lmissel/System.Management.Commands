# ----------------------
# Beispiel - Prozess starten
# ----------------------
[System.Management.ManagementClass] $processClass = [System.Management.ManagementClass]::new("Win32_Process")
[System.Management.ManagementBaseObject] $inParams = $processClass.GetMethodParameters("Create")
$inParams["CommandLine"] = "notepad.exe"
$processClass.InvokeMethod("Create", $inParams, $null)
