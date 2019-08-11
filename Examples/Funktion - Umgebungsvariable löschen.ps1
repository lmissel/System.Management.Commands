# Beispiel - Funktion: Umgebungsvariable löschen
function Remove-Environment
{
    param(
        [String] $Name,
        [Switch] $System
    )

    [System.Management.ManagementClass] $envClass = [System.Management.ManagementClass]::new("Win32_Environment")
    [System.Management.ManagementObjectCollection] $Instances = $envClass.GetInstances()
    foreach ($instance in $Instances)
    {
        if ($instance.Name -eq $Name)
        {
            if (-not ($System))
            {
                if ($instance.UserName -eq $env:USERNAME)
                {            
                    $instance.Delete()
                }
            }
            else
            {
                if ($instance.UserName -eq '<SYSTEM>')
                {            
                    $instance.Delete()
                }
            }
        }
    }
}
