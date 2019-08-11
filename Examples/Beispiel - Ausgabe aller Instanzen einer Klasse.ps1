# ----------------------
# Beispiel - Ausgabe aller Instanzen einer Klasse
# ----------------------
[System.Management.ManagementClass] $processClass = [System.Management.ManagementClass]::new("Win32_Process")
foreach ($o in $processClass.GetInstances())
{
    Write-Host ("Next instance of Win32_Process : {0}" -f $o["Name"])
}