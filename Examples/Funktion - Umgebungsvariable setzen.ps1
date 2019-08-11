# Beispiel - Funktion: Neue Umgebungsvariable
function Set-Environment
{
    param(
        [String] $Name,
        [String] $VariableValue,
        [Switch] $System
    )

    $UserName = if ($System) { "<SYSTEM>" } else { "$ENV:COMPUTERNAME\$env:USERNAME" }

    [System.Management.ManagementClass] $envClass = [System.Management.ManagementClass]::new("Win32_Environment")
    [System.Management.ManagementObjectCollection] $Instances = $envClass.GetInstances()
    foreach ($instance in $Instances)
    {
        if ($instance.Name -eq $Name -and $instance.UserName -eq $UserName)
        {
            $instance["VariableValue"] = $VariableValue
            $instance.Put()
        }
    }
}
