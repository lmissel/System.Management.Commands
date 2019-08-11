# The sample below demonstrates the various conversions
# that can be done using ManagementDateTimeConverter class 

# Variablen
[string] $dmtfDate = "20020408141835.999999-420"
[string] $dmtfTimeInterval = "00000010122532:123456:000"

# Converting DMTF datetime to System.DateTime
[DateTime] $dt = [System.Management.ManagementDateTimeConverter]::ToDateTime($dmtfDate)

# Converting System.DateTime to DMTF datetime
[string] $dmtfDateTime = [System.Management.ManagementDateTimeConverter]::ToDmtfDateTime([DateTime]::Now);

# Converting DMTF time interval to System.TimeSpan
[System.TimeSpan] $tsRet = [System.Management.ManagementDateTimeConverter]::ToTimeSpan($dmtfTimeInterval);

# Converting System.TimeSpan to DMTF time interval format
[System.TimeSpan] $ts = [System.TimeSpan]::new(10,12,25,32,456)
[string] $dmtfTimeInt = [System.Management.ManagementDateTimeConverter]::ToDmtfTimeInterval($ts)