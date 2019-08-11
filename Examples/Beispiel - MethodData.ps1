# Get the WMI class
[System.Management.ManagementClass] $processClass = [System.Management.ManagementClass]::new("Win32_Process");
$processClass.Options.UseAmendedQualifiers = $true;

# Get the methods in the class
[System.Management.MethodDataCollection] $methods = $processClass.Methods;

# display the method names
[Console]::WriteLine("Method Name: ");
foreach ($method in $methods)
{
    [Console]::WriteLine($method.Name);
    [Console]::WriteLine("Description: " + $method.Qualifiers["Description"].Value);
    [Console]::WriteLine("");
        
    try
    {
        [Console]::WriteLine("In-parameters: ");
        foreach($i in $method.InParameters.Properties)
        {
            [Console]::WriteLine($i.Name);
        }
    }
    catch
    {
        [Console]::WriteLine("keine.");
    }
    finally
    {
        [Console]::WriteLine("");
    }

    try
    {
        [Console]::WriteLine("Out-parameters: ");
        foreach($o in $method.OutParameters.Properties)
        {
            [Console]::WriteLine($o.Name);
        }
    }
    catch
    {
        [Console]::WriteLine("keine.");
    }
    finally
    {
        [Console]::WriteLine("");
    }

    try
    {
        [Console]::WriteLine("Qualifiers: ");
        foreach($q in $method.Qualifiers)
        {
            [Console]::WriteLine($q.Name);
        }
    }
    catch
    {
        [Console]::WriteLine("keine.");
    }
    finally
    {
        [Console]::WriteLine("");
    }
}