# System.Management.Commands
Dieses PowerShell Module soll bei der Erstellung von neuen WMI Namensräumen, Klassen und Instanzen (Namespaces, Classes und Properties) unterstützen. Es wurde entwickelt, um Namensräumen, Klassen und Instanzen editieren zu können und Informationen aus den jeweiligen Klassen und deren Methoden zu beziehen.

Das PowerShell Module bietet einen umfassenden Zugriff auf Verwaltungsinformationen und -ereignisse über System, Geräte und Anwendungen, die zur WMI-Infrastruktur (Windows Management Instrumentation) instrumentiert sind. Skripte, die dieses Module verwenden, können Abfragen zu interessanten Verwaltungsinformationen ausführen (z. B. zur Menge an freiem Speicherplatz, zur aktuellen CPU-Auslastung oder dazu, mit welcher Datenbank eine bestimmte Anwendung verbunden ist usw.), wobei von ManagementObjectSearcher und ManagementQuery abgeleitete Klassen verwendet werden. Außerdem kann mithilfe der ManagementEventWatcher-Klasse eine Vielzahl von Verwaltungsereignissen abonniert werden. Die verfügbaren Daten können sowohl aus verwalteten als auch aus nicht verwalteten Komponenten der verteilten Umgebung stammen.

Ebenso wurde es von mir als Werkzeug für weitere PowerShell Module verwendet, um beispielweise Installationen von Namensräumen, Klassen und Instanzen abzubilden.

**Hinweis:** Dieses Module wird nicht weiterentwickelt. Ein ähnliches Module [PSWmiToolKit](https://github.com/Ioan-Popovici/PSWmiToolKit) von Ioan-Popovici ist sehr empfehlenswert.

## Voraussetzungen

Um dieses Module nutzen zu können, ist ein Windowssystem sowie das .Net Framework notwendig.

## Installation

Kopieren Sie das Module in eins der PowerShell Module Pfade.

## Verwendung

In diesem Beispiel wird gezeigt und erläutert, wie das Module verwendet werden kann.

```powershell
# Importiere das Moduls
PS C:\Users\lmissel> Import-Module System.Management.Commands

# Neuen ManagementScope / WMI Namespaces erstellen
PS C:\Users\lmissel> New-ManagementScope -NamespaceName lmissel

# Neue ManagementClass / WMI Class erstellen
PS C:\Users\lmissel> New-ManagementClass -ClassName LMI_Filter -Namespace lmissel

# Eine Eigenschaft einer Klasse hinzufügen
PS C:\Users\lmissel> Add-PropertyData -ClassName LMI_Filter -Namespace lmissel -PropertyName 'Test' -PropertyValue 'Value1' -PropertyType String

```
## Hinweis
Dieses PowerShell Module wird nicht mehr weiterentwickelt.
