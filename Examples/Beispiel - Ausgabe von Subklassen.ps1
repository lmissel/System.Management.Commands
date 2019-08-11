# ----------------------
# Beispiel - Ausgabe von Subklassen
# ----------------------
[System.Management.EnumerationOptions] $opt = [System.Management.EnumerationOptions]::new()
$opt.EnumerateDeep = $true;

[System.Management.ManagementObjectCollection] $subclasses = ([System.Management.ManagementClass]::new("CIM_LogicalDisk")).GetSubclasses($opt)
foreach($subclass in $subclasses)
{
    Write-Host ("Subclass found: {0}" -f $subclass["__CLASS"]);
}