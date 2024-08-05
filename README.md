# Write-This

## Synopsis

Write a message to the console and a log file at the same time.

## Description

A little function to help write output to the console and log files at the same time to keep your actual code cleaner. Instead of having separate lines for interactive output and log files, one function can handle both.

## Example

Until this is an actual module, the following example shows how to manually import the three scripts and use them:

```powershell
. .\Start-WriteThis.ps1
. .\Write-This.ps1
. .\Stop-WriteThis.ps1

Start-WriteThis -LogFile "TestLog"

Write-This -LogText "First!" -Output Both -ForegroundColor White -BackgroundColor DarkBlue
$Directories = Get-ChildItem -Directory $env:TEMP
$DirectoryCount = $Directories.Count
Write-This -LogText "Found $DirectoryCount directories in the current folder." -Output Both
Write-This -LogText "These details are only going into the log file:`n$Directories" -Output LogOnly
Write-This -LogText "Let's finish this up." -ForegroundColor Green -BackgroundColor Black

Stop-WriteThis -LogFile $script:LogFile
```
