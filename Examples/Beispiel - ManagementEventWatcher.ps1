<#

Beispiel - ManagementEventWatcher

Das folgende Beispiel zeigt, wie der Client eine Benachrichtigung empfängt, 
wenn eine Instanz von Win32_Process erstellt wird, da die-Ereignisklasse __InstanceCreationEventist.
Weitere Informationen finden Sie in der Windows-Verwaltungsinstrumentation -Dokumentation. 
Der Client empfängt Ereignisse synchron durch Aufrufen der WaitForNextEvent-Methode.
Während der Beispielcode ausgeführt wird, kann dieses Beispiel durch Starten eines Prozesses wie Editor getestet werden.

#>

# Create event query to be notified within 1 second of a change in a service
[System.Management.EventQuery] $query = [System.Management.EventQuery]::new();
$query.QueryString = "SELECT * FROM __InstanceCreationEvent WITHIN 1 WHERE TargetInstance isa 'Win32_Process'";

# Initialize an event watcher and subscribe to events that match this query
[System.Management.ManagementEventWatcher] $watcher = [System.Management.ManagementEventWatcher]::new($query);

# times out watcher.WaitForNextEvent in 5 seconds
$watcher.Options.Timeout = [timespan]::new(0,0,5);

# Block until the next event occurs 
# Note: this can be done in a loop if waiting for more than one occurrence
[Console]::WriteLine("Open an application (notepad.exe) to trigger an event.");
[System.Management.ManagementBaseObject] $e = $watcher.WaitForNextEvent();

# Display information from the event
[Console]::WriteLine("Process {0} has been created, path is: {1}", 
            ($e["TargetInstance"])["Name"],
            ($e["TargetInstance"])["ExecutablePath"]);

#Cancel the subscription
$watcher.Stop();