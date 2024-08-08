# Just messing around with style template ideas

# Title style settings
$StyleTitle = @{
    ForegroundColor = White
    BackgroundColor = DarkBlue
    UseWrapper      = $true
    TitleMargin     = 8
    Wrapper         = "|$("=" * ($TitleString.Length + $TitleMargin*2))|`n|    $TitleString    |`n|$("=" * ($TitleString.Length + $TitleMargin*2))|"
}


# Pass style settings
$StylePass = @{
    ForegroundColor = Green
    BackgroundColor = Black
    PrefixTimeStamp = $false
    PrefixPassStamp = ' [Pass] '
    PassText        = "$(if ($PrefixTimeStamp) {$PrefixTimeStamp}) $PrefixPassStamp $Text"
}

# Fail style settings
$StyleFail = @{
    ForegroundColor = Red
    BackgroundColor = Black
    PrefixTimeStamp = $false
    PrefixPassStamp = ' [Fail] '
    FailText        = "$(if ($PrefixTimeStamp) {$PrefixTimeStamp}) $PrefixFailStamp $Text"
}

# eg
$TitleString = "Welcome to Write-This!"
$TitleMargin = 4
$BorderWidth    = $TitleString.Length + ($TitleMargin*2)
$BorderTop      = "`|$("=" * $BorderWidth)`|"
$BorderLeft     = "`|$(" " * $TitleMargin)"
$BorderRight    = "$(" " * $TitleMargin)`|"
$BorderBottom   = "`|$("=" * $BorderWidth)`|"
$HostForegroundColor = $Host.UI.RawUI.ForegroundColor
$HostBackgroundCOlor = $Host.UI.RawUI.BackgroundColor
Function Reset-LineColor { Write-Host " " -ForegroundColor $HostForegroundColor -BackgroundColor $HostBackgroundColor }
# Top border
Write-Host $BorderTop -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
Reset-LineColor
# Left border for title
Write-Host "$BorderLeft" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
# Title
Write-Host $TitleString -ForegroundColor Blue -BackgroundColor White -NoNewline
# Right border
Write-Host $BorderRight -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
Reset-LineColor
# Bottom border
Write-Host "$BorderBottom" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
Reset-LineColor
