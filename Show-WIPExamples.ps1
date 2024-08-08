# Just messing around with style template ideas

# Title style settings
$StyleTitle = @{
    ForegroundColor = White
    BackgroundColor = DarkBlue
    UseWrapper      = $true
    TitleMargin     = 8
    Wrapper         = "|$("=" * ($TitleString.Length + $TitleMargin*2))|`n|    $TitleString    |`n|$("=" * ($TitleString.Length + $TitleMargin*2))|"
}

# Sample: White text on a blue background. Title framed in a box.
$TitleString    = "Welcome to Write-This!"
$TitleMargin    = 16
$BorderWidth    = $TitleString.Length + ($TitleMargin*2)
$BorderTop      = "`|$("=" * $BorderWidth)`|"
$BorderLeft     = "`|$(" " * $TitleMargin)"
$BorderRight    = "$(" " * $TitleMargin)`|"
$BorderBottom   = "`|$("=" * $BorderWidth)`|"

$HostForegroundColor = $Host.UI.RawUI.ForegroundColor
$HostBackgroundCOlor = $Host.UI.RawUI.BackgroundColor
Function Reset-LineColor { Write-Host "" -ForegroundColor $HostForegroundColor -BackgroundColor $HostBackgroundColor }

# Top border 1
Write-Host $BorderTop -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
# Top border 2: side borders and blank line above title
Write-Host "$BorderLeft$(" " * $TitleString.Length)$BorderRight" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
# Title left border / Title / Title right border
Write-Host "$BorderLeft" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
Write-Host $TitleString -ForegroundColor Blue -BackgroundColor White -NoNewline
Write-Host $BorderRight -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
# Bottom border 2: side borders and blank line below title
Write-Host "$BorderLeft$(" " * $TitleString.Length)$BorderRight" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
# Bottom border 1
Write-Host "$BorderBottom" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor

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

# H1

# H2

# H3

# Detail level 1 indent

# Detail level 2 indent

# Detail level 3 indent
