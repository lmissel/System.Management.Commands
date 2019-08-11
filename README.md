# System.Management.Commands
Dieses PowerShell Module soll bei der Erstellung von neuen WMI Namensräumen, Klassen und Instanzen (Namespaces, Classes und Properties) unterstützen.

Es bietet Zugriff auf umfassende Verwaltungsinformationen und -ereignisse über System, Geräte und Anwendungen, die zur WMI-Infrastruktur (Windows Management Instrumentation) instrumentiert sind. Anwendungen und Dienste können Abfragen zu interessanten Verwaltungsinformationen ausführen (z. B. zur Menge an freiem Speicherplatz, zur aktuellen CPU-Auslastung oder dazu, mit welcher Datenbank eine bestimmte Anwendung verbunden ist usw.), wobei von ManagementObjectSearcher und ManagementQuery abgeleitete Klassen verwendet werden. Außerdem kann mithilfe der ManagementEventWatcher-Klasse eine Vielzahl von Verwaltungsereignissen abonniert werden. Die verfügbaren Daten können sowohl aus verwalteten als auch aus nicht verwalteten Komponenten der verteilten Umgebung stammen.

Ebenso wurde es von mir als Werkzeug für weitere PowerShell Module verwendet, um beispielweise Installationen von Namensräumen, Klassen und Instanzen abzubilden.

**Hinweis:** Dieses Module wurde nicht weiterentwickelt. Ein ähnliches Module [PSWmiToolKit](https://github.com/Ioan-Popovici/PSWmiToolKit) von Ioan-Popovici ist sehr empfehlenswert.
