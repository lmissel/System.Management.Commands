function Get-Environment
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
                   ParameterSetName='Name')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1,
                   ParameterSetName='Name')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Switch] $System,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='All')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Switch] $All
    )
    
    Begin
    {
    }

    Process
    {
        if ($pscmdlet.ShouldProcess($env:COMPUTERNAME, "Get environment variable."))
        {
            if ($pscmdlet.ParameterSetName -eq 'Name')
            {
                $UserName = if ($System) { "<SYSTEM>" } else { "$ENV:COMPUTERNAME\$env:USERNAME" }
                [System.Management.ManagementObject] $ManagementObject = [System.Management.ManagementObject]::new("Win32_Environment.Name='$($Name)',UserName='$($UserName)'")
                $ManagementObject
            }

            if ($pscmdlet.ParameterSetName -eq 'All')
            {
                [System.Management.ManagementClass] $envClass = [System.Management.ManagementClass]::new("Win32_Environment")
                [System.Management.ManagementObjectCollection] $ManagementObjectCollection = $envClass.GetInstances()
                $ManagementObjectCollection
            }
        }
    }

    End
    {
    }
}
