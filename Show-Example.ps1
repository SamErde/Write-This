# An example of using Write-This by importing the 3 functions it relies on.
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
