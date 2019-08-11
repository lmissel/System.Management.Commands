# Beispiel - Funktion: Neue Umgebungsvariable
function New-Environment
{
    param(
        [String] $Name,
        [String] $VariableValue,
        [Switch] $System
    )

    [System.Management.ManagementClass] $envClass = [System.Management.ManagementClass]::new("Win32_Environment")
    [System.Management.ManagementObject] $newInstance = $envClass.CreateInstance()
    $newInstance["Name"] = $Name
    $newInstance["VariableValue"] = $VariableValue

    if ($System)
    {
        $newInstance["UserName"] = "<SYSTEM>"
    }
    else
    {
        $newInstance["UserName"] = $env:USERNAME
    }

    $newInstance.Put()
}
