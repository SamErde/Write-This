# Just messing around with style template ideas

#region SampleTitle
# Sample: White text on a blue background. Title framed in a box.
$TitleText    = "Welcome to Write-This!"
$TitleMargin    = 16
$BorderWidth    = $TitleText.Length + ($TitleMargin*2)
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
Write-Host "$BorderLeft$(" " * $TitleText.Length)$BorderRight" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
# Title left border / Title / Title right border
Write-Host "$BorderLeft" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
Write-Host $TitleText -ForegroundColor Blue -BackgroundColor White -NoNewline
Write-Host $BorderRight -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
# Bottom border 2: side borders and blank line below title
Write-Host "$BorderLeft$(" " * $TitleText.Length)$BorderRight" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
# Bottom border 1
Write-Host "$BorderBottom" -ForegroundColor White -BackgroundColor DarkBlue -NoNewline ; Reset-LineColor
#endregion SampleTitle

#region DraftStyleSettings

# Title style settings
$StyleTitle = @{
    ForegroundColor = 'White'
    BackgroundColor = 'DarkBlue'
    UseWrapper      = $true
    TitleMargin     = 8
    Wrapper         = "|$("=" * ($TitleText.Length + $TitleMargin*2))|`n|    $TitleText    |`n|$("=" * ($TitleText.Length + $TitleMargin*2))|"
}

# Pass style settings
$StylePass = @{
    ForegroundColor = 'Green'
    BackgroundColor = 'Black'
    PrefixTimeStamp = $false
    PrefixPassStamp = ' [Pass] '
    PassText        = "$(if ($PrefixTimeStamp) {$PrefixTimeStamp}) $PrefixPassStamp $Text"
}

# Fail style settings
$StyleFail = @{
    ForegroundColor = 'Red'
    BackgroundColor = 'Black'
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
#endregion DraftStyleSettings

#region ClassExperiments
#region RegisterTypeAccellerator
# Define the types to export with type accelerators.
$ExportableTypes =@(
    [StyleTitle]
)
# Get the internal TypeAccelerators class to use its static methods.
$TypeAcceleratorsClass = [psobject].Assembly.GetType(
    'System.Management.Automation.TypeAccelerators'
)
# Ensure none of the types would clobber an existing type accelerator.
# If a type accelerator with the same name exists, throw an exception.
$ExistingTypeAccelerators = $TypeAcceleratorsClass::Get
foreach ($Type in $ExportableTypes) {
    if ($Type.FullName -in $ExistingTypeAccelerators.Keys) {
        $Message = @(
            "Unable to register type accelerator '$($Type.FullName)'"
            'Accelerator already exists.'
        ) -join ' - '

throw [System.Management.Automation.ErrorRecord]::new(
            [System.InvalidOperationException]::new($Message),
            'TypeAcceleratorAlreadyExists',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $Type.FullName
        )
    }
}
# Add type accelerators for every exportable type.
foreach ($Type in $ExportableTypes) {
    $TypeAcceleratorsClass::Add($Type.FullName, $Type)
}
# Remove type accelerators when the module is removed.
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    foreach($Type in $ExportableTypes) {
        $TypeAcceleratorsClass::Remove($Type.FullName)
    }
}.GetNewClosure()
#endregion RegisterTypeAccellerator

class StyleTitle {
    static $HostForegroundColor = $Host.UI.RawUI.ForegroundColor
    static $HostBackgroundCOlor = $Host.UI.RawUI.BackgroundColor

    [string] $TitleText
    [int] $TitleMargin

    [ConsoleColor]  $ForegroundColor = 'White'
    [ConsoleColor]  $BackgroundColor = 'DarkBlue'
    [bool]          $UseWrapper = $true

    [int] $BorderWidth       = ($this.TitleText.Length) + ($this.TitleMargin*2)
    [string] $BorderTop      = "`|$("=" * $this.BorderWidth)`|"
    [string] $BorderLeft     = "`|$(" " * $this.TitleMargin)"
    [string] $BorderRight    = "$(" " * $this.TitleMargin)`|"
    [string] $BorderBottom   = "`|$("=" * $this.BorderWidth)`|"

    StyleTitle([hashtable]$Title) {
        switch ($Title.Keys) {
            'TitleText'       { $this.TitleText = $Title.TitleText }
            'TitleMargin'     { $this.TitleMargin = $Title.TitleMargin }
            'ForegroundColor' { $this.ForegroundColor = $Title.ForegroundColor }
            'BackgroundCOlor' { $this.BackgroundColor = $Title.BackgroundColor }
        }
    }

    StyleTitle (
        [string]$TitleText,
        [int]$TitleMargin,
        [System.ConsoleColor]$ForegroundColor,
        [System.ConsoleColor]$BackgroundColor
    ) {
        $this.TitleText = $TitleText
        $this.TitleMargin = $TitleMargin
        $this.ForegroundColor = $ForegroundColor
        $this.BackgroundColor = $BackgroundColor
    }

    StyleTitle (
        [string]$TitleText
    ) {
        $this.TitleText = $TitleText
    }

    #[StyleTitle]::new(@{
    #    $this.TitleText = $TitleText
    #})



    WriteHost () {
        # Write-Host "|$("=" * ($this.Title.Length + $this.TitleMargin*2))|`n|$(" " * $this.TitleMargin)$($this.Title)$(" " * $this.TitleMargin)|`n|$("=" * ($this.Title.Length + $this.TitleMargin*2))|"
        Function Reset-LineColor { Write-Host "" -ForegroundColor $HostForegroundColor -BackgroundColor $HostBackgroundColor }
        # Top border 1
        Write-Host $($this.BorderTop) -ForegroundColor White -BackgroundColor DarkBlue #-NoNewline ; Reset-LineColor
        # Top border 2: side borders and blank line above title
        Write-Host "$($this.BorderLeft)$(" " * ($this.TitleText.Length))$($this.BorderRight)" -ForegroundColor White -BackgroundColor DarkBlue #-NoNewline ; Reset-LineColor
        # Title left border / Title / Title right border
        Write-Host $($this.BorderLeft) -ForegroundColor White -BackgroundColor DarkBlue -NoNewline
        Write-Host $($this.TitleText) -ForegroundColor Blue -BackgroundColor White -NoNewline
        Write-Host $($this.BorderRight) -ForegroundColor White -BackgroundColor DarkBlue #-NoNewline ; Reset-LineColor
        # Bottom border 2: side borders and blank line below title
        Write-Host "$($this.BorderLeft)$(" " * $this.TitleText.Length)$($this.BorderRight)" -ForegroundColor White -BackgroundColor DarkBlue #-NoNewline ; Reset-LineColor
        # Bottom border 1
        Write-Host $($this.BorderBottom) -ForegroundColor White -BackgroundColor DarkBlue #-NoNewline ; Reset-LineColor
    }

    WriteLog ($Title) {
        #
    }

}
#endregion ClassExperiments
