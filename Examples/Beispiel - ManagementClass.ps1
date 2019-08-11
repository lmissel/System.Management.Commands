
# Das folgende Beispiel zeigt, wie eine ManagementClass Variable mit dem ManagementClass Parameter losen 
# Konstruktor initialisiert wird. Im Beispiel werden die Methoden, Eigenschaften und Qualifizierer für die 
# erstellte Klasse aufgelistet.

# Get the WMI Class
[System.Management.ManagementClass] $processClass = [System.Management.ManagementClass]::new()
$processClass.Path = [System.Management.ManagementPath]::new("Win32_Process")

# Get the methods in the class
[System.Management.MethodDataCollection] $methods = $processClass.Methods

# display the methods
[Console]::WriteLine("Method Names: ")
foreach ($method in $methods)
{
    [Console]::WriteLine($method.Name)
}
[Console]::WriteLine("")

# Get the properties in the class
[System.Management.PropertyDataCollection] $properties = $processClass.Properties

# display the properties
[Console]::WriteLine("Property Names: ")
foreach ($property in $properties)
{
    [Console]::WriteLine($property.Name)
}
[Console]::WriteLine("")

# Get the Qualifiers in the class
[System.Management.QualifierDataCollection] $qualifiers = $processClass.Qualifiers

# display the qualifiers
[Console]::WriteLine("Qualifier Names: ")
foreach ($qualifier in $qualifiers)
{
    [Console]::WriteLine($qualifier.Name)
}