# -------------------------------------------------------
#
# Module: System.Management.Commands
# 
# Bietet Zugriff auf umfassende Verwaltungsinformationen und -ereignisse über System, Geräte und Anwendungen, 
# die zur WMI-Infrastruktur (Windows Management Instrumentation) instrumentiert sind. Anwendungen und Dienste 
# können Abfragen zu interessanten Verwaltungsinformationen ausführen (z. B. zur Menge an freiem Speicherplatz, 
# zur aktuellen CPU-Auslastung oder dazu, mit welcher Datenbank eine bestimmte Anwendung verbunden ist usw.), 
# wobei von ManagementObjectSearcher und ManagementQuery abgeleitete Klassen verwendet werden. Außerdem kann 
# mithilfe der ManagementEventWatcher-Klasse eine Vielzahl von Verwaltungsereignissen abonniert werden. Die 
# verfügbaren Daten können sowohl aus verwalteten als auch aus nicht verwalteten Komponenten der verteilten 
# Umgebung stammen.
# 
# Written by: lmissel
#
# Die nachfolgenden Befehle sind in angegebenen Modul Microsoft.PowerShell.Management bereits vorhanden und 
# werden daher nicht behandelt.
#
# Get-WmiObject     : Gets instances of Windows Management Instrumentation (WMI) classes or information about the available classes.
# Set-WmiInstance   : Creates or updates an instance of an existing Windows Management Instrumentation (WMI) class.
# Invoke-WmiMethod  : Calls WMI methods.
# Remove-WmiObject  : Deletes an instance of an existing Windows Management Instrumentation (WMI) class.
#
# -------------------------------------------------------

$Script:CurrentObject = $null

# -------------------------------------------------------
# ManagementScope - WMI Namespaces
# -------------------------------------------------------

#region Namespace

function New-ManagementScope
{
    param(
        [String] $NamespaceName
    )

    Begin
    {
    }

    Process
    {
        [System.Management.ManagementScope] $ManagementScope = [System.Management.ManagementScope]::new("\\.\root")
        [System.Management.ManagementPath] $ManagementPath = [System.Management.ManagementPath]::new("__NAMESPACE")
        [System.Management.ManagementClass] $ManagementClass = [System.Management.ManagementClass]::new($ManagementScope, $ManagementPath, $null);
        $Instance = $ManagementClass.CreateInstance()
        $Instance.Name = $NamespaceName
        $Instance.Put()
        $Instance.Dispose()
    }

    End
    {
    }
}

function Get-ManagementScope
{
    param(
        [String] $NamespaceName
    )

    Begin
    {
    }

    Process
    {
        [System.Management.ManagementScope] $ManagementScope = [System.Management.ManagementScope]::new("\\.\root\$($NamespaceName)")
        $ManagementScope
    }

    End
    {
    }
}

function Remove-ManagementScope
{
    [CmdletBinding(DefaultParameterSetName='Name', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='High')]
    [Alias()]
    param(
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Name')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $Name
    )
    Begin
    {
    }

    Process
    {
        if ($pscmdlet.ShouldProcess("[$($Name)]", "Remove a Namespace."))
        {
            $ManagementClass = Get-ManagementClass -ClassName "__Namespace" -Namespace "\\.\root"
            foreach ($ManagementObject in $ManagementClass.GetInstances())
            {
                 if($ManagementObject["Name"] -eq $Name)
                 {
                    $ManagementObject.Delete()
                 }
            }
        }
    }

    End
    {
    }
}

#endregion

# -------------------------------------------------------
# ManagementClass - WMI Classes
# -------------------------------------------------------

#region ManagementClass

function New-ManagementClass
{
    param(
        [String] $ClassName,
        [String] $Namespace
    )

    Begin
    {
    }

    Process
    {
        if (-not (Get-WmiObject -Class $ClassName -Namespace $Namespace -List))
        {
            [System.Management.ManagementScope] $ManagementScope = [System.Management.ManagementScope]::new($Namespace)
            [System.Management.ManagementClass] $ManagementClass = [System.Management.ManagementClass]::new($ManagementScope, $null, $null)
            $ManagementClass.Name = $ClassName
            $ManagementClass.Put()
        }
        else
        {
            [Console]::WriteLine("Diese Klasse existiert bereits.")
        }
    }

    End
    {
    }
}

function Get-ManagementClass
{
    param(
        [String] $ClassName,
        [String] $Namespace
    )

    Begin
    {
    }
    
    Process
    {
        [System.Management.ManagementScope] $ManagementScope = [System.Management.ManagementScope]::new($Namespace);
        [System.Management.ManagementPath] $ManagementPath = [System.Management.ManagementPath]::new($ClassName);
        [System.Management.ManagementClass] $ManagementClass = [System.Management.ManagementClass]::new($ManagementScope, $ManagementPath, $null);
        $ManagementClass
    }

    End
    {
    }
}

function Remove-ManagementClass
{
    [CmdletBinding(DefaultParameterSetName='Path', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='High')]
    [Alias()]
    param(
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Path')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $Path
    )

    Begin
    {
    }

    Process
    {
        if ($pscmdlet.ShouldProcess("[$($Path)]", "Remove a ManagementClass from Namespace."))
        {
            try
            {
                [System.Management.ManagementClass] $ManagementClass = [System.Management.ManagementClass]::new($Path)
                $ManagementClass.Delete()
            }
            catch
            {
                throw $_
            }
            finally
            {
            }
        }
    }

    End
    {
    }
}

function ConvertFrom-ManagementClass
{
    param(
        [String] $Path,
        [System.Management.TextFormat] $TextFormat
    )

    Begin
    {
    }

    Process
    {
        try
        {
            [System.Management.ManagementClass] $ManagementClass = [System.Management.ManagementClass]::new($Path)
            $ManagementClass.GetText($TextFormat)
        }
        catch
        {
            throw $_
        }
        finally
        {
        }
    }

    End
    {
    }
}

#endregion

#region PropertyData

function Get-PropertyData
{
    [CmdletBinding(DefaultParameterSetName='All', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([Object])]
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='PropertyName')]
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='All')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $NameSpace,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1,
                   ParameterSetName='PropertyName')]
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='All')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $ClassName,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2,
                   ParameterSetName='PropertyName')]
        [String] $PropertyName
    )

    Begin
    {
    }

    Process
    {
        if ($pscmdlet.ShouldProcess("[$($ClassName)]", "Get a or all PropertyData from Class."))
        {
            if ($PSCmdlet.ParameterSetName -eq 'All')
            {
                [System.Management.ManagementClass] $ManagementClass = Get-ManagementClass -Namespace $NameSpace -Class $ClassName
                $ManagementClass.Properties
            }

            if ($PSCmdlet.ParameterSetName -eq 'PropertyName')
            {
                [System.Management.ManagementClass] $ManagementClass = Get-ManagementClass -Namespace $NameSpace -Class $ClassName
                $ManagementClass.Properties["$($PropertyName)"]
            }
        }
    }

    End
    {
    }
}

function Add-PropertyData
{
    [CmdletBinding(DefaultParameterSetName='Default', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [Alias()]
    [OutputType([Object])]
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='IsArray')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $NameSpace,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1,
                   ParameterSetName='IsArray')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $ClassName,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2,
                   ParameterSetName='IsArray')]
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $PropertyName,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $PropertyValue,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3,
                   ParameterSetName='IsArray')]
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=4,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Management.CimType] $PropertyType = [System.Management.CimType]::String,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=4,
                   ParameterSetName='IsArray')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Switch] $isArray
    )

    Begin
    {
    }

    Process
    {
        if ($pscmdlet.ShouldProcess("[$($ClassName)]", "Add a PropertyData to Class."))
        {            
            [System.Management.ManagementClass] $ManagementClass = Get-ManagementClass -Namespace $NameSpace -Class $ClassName

            if ($PSCmdlet.ParameterSetName -eq 'Default')
            {
                $ManagementClass.Properties.Add($PropertyName,$PropertyValue,$PropertyType)
            }

            if ($PSCmdlet.ParameterSetName -eq 'IsArray')
            {
                $ManagementClass.Properties.Add($PropertyName,$PropertyType,$isArray)
            }

            [Void] $ManagementClass.Put()        
        }
    }

    End
    {
    }
}

function Set-PropertyData
{
    param(
        [String] $NameSpace,
        [String] $ClassName,
        [String] $PropertyName,
        [Object] $PropertyValue
    )

    Begin
    {
    }

    Process
    {
        if ($pscmdlet.ShouldProcess("[$($PropertyName)]", "Set a PropertyValue."))
        {            
            [System.Management.ManagementClass] $ManagementClass = Get-ManagementClass -Namespace $NameSpace -Class $ClassName
            $ManagementClass.SetPropertyValue($PropertyName,$PropertyValue)
            [Void] $ManagementClass.Put()
        }
    }

    End
    {
    }
}

function Remove-PropertyData
{
    param(
        [String] $NameSpace,
        [String] $ClassName,
        [String] $PropertyName
    )

    [System.Management.ManagementClass] $ManagementClass = Get-ManagementClass -Namespace $NameSpace -Class $ClassName
    $ManagementClass.Properties.Remove($PropertyName)
    [Void] $ManagementClass.Put()
}

#endregion

# -------------------------------------------------------
# ManagementObject - WMI Instances
# -------------------------------------------------------

# Hinweis: Siehe Beschreibung!

#region ManagementObject

# Initialisiert eine neue Instanz der ManagementObject-Klasse für den angegebenen WMI-Objektpfad. Der Pfad wird als ManagementPath bereitgestellt.
function Get-ManagementObject
{
    param(
        [System.Management.ManagementPath] $ManagementPath
    )

    [wmi] $ManagementObject = [Wmi]::new($ManagementPath)
    return $ManagementObject
}

#endregion

# -------------------------------------------------------
# ManagementDateTimeConverter
# -------------------------------------------------------

#region ManagementDateTimeConverter

function ConvertFrom-DmtfDateTime
{
    [CmdletBinding()]
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [String] $DmtfDateTime
    )

    Begin
    {
    }
    Process
    {
        [System.Management.ManagementDateTimeconverter]::ToDateTime($DmtfDateTime)
    }
    End
    {
    }
}

function ConvertTo-DmtfDateTime
{
    [CmdletBinding()]
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [DateTime] $DateTime
    )

    Begin
    {
    }
    Process
    {
        [System.Management.ManagementDateTimeConverter]::ToDmtfDateTime($DateTime)
    }
    End
    {
    }
}

function ConvertFrom-DmtfTimeInterval
{
    [CmdletBinding()]
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string] $DmtfTimeInterval
    )

    Begin
    {
    }
    Process
    {
        [System.Management.ManagementDateTimeconverter]::ToTimeSpan($DmtfTimeInterval)
    }
    End
    {
    }
}

function ConvertTo-DmtfTimeInterval
{
    [CmdletBinding()]
    Param
    (
        # Hilfebeschreibung zu Param1
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [System.TimeSpan] $TimeSpan
    )

    Begin
    {
    }
    Process
    {
        [System.Management.ManagementDateTimeConverter]::ToDmtfTimeInterval($TimeSpan)
    }
    End
    {
    }
}

#endregion

# -------------------------------------------------------
# Andere
# -------------------------------------------------------

# Initialisiert eine neue Instanz der ManagementPath-Klasse für den angegebenen Pfad.
function New-ManagementPath
{
    param(
        [String] $path
    )

    [System.Management.ManagementPath] $ManagementPath = [System.Management.ManagementPath]::new($path)
    return $ManagementPath
}
