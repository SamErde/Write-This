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
    #region StyleTitleDefinition
    class StyleTitle {
        $HostForegroundColor # HOW CAN I GET $Host.UI.RawUI.[__]Color INTO THE CLASS?!
        $HostBackgroundColor # HOW CAN I GET $Host.UI.RawUI.[__]Color INTO THE CLASS?!

        [string] $TitleText
        [ValidateRange(0,32)]
        [int] $TitleMargin              = 16
        [ConsoleColor] $ForegroundColor = 'White'
        [ConsoleColor] $BackgroundColor = 'DarkBlue'
        [bool]   $Border                = $true
        [int]    $BorderWidth           = ($this.TitleText.Length) + ($this.TitleMargin*2)
        [string] $BorderTop             = "`|$("=" * $this.BorderWidth)`|"
        [string] $BorderLeft            = "`|$(" " * $this.TitleMargin)"
        [string] $BorderRight           = "$(" " * $this.TitleMargin)`|"
        [string] $BorderBottom          = "`|$("=" * $this.BorderWidth)`|"

        #region Constructs
        # Default empty construct.
        StyleTitle () { }

        # Construct with just the TitleText specified.
        StyleTitle ( [string]$TitleText ) { $this.TitleText = $TitleText }

        # Construct with a hash table that incldues TitleText, TitleMargin, ForegroundColor, and BackgroundColor.
        StyleTitle([hashtable]$StyleTitle) {
            switch ($StyleTitle.Keys) {
                'TitleText'       { $this.TitleText = $StyleTitle.TitleText }
                'TitleMargin'     { if ($StyleTitle.ContainsKey('TitleMargin')) { $this.TitleMargin = $StyleTitle.TitleMargin } else { $this.TitleMargin = 16 } }
                'ForegroundColor' { if ($StyleTitle.ContainsKey('ForegroundColor')) { $this.ForegroundColor = $StyleTitle.ForegroundColor } else { $this.ForegroundColor = 'White' } }
                'BackgroundCOlor' { if ($StyleTitle.ContainsKey('BackgroundColor')) { $this.BackgroundColor = $StyleTitle.BackgroundColor } else { $this.BackgroundColor = 'DarkBlue' } }
            }
        }

        # Construct with manually defined overrides.
        StyleTitle (
            [string] $TitleText,
            [int] $TitleMargin              = 16,
            [ConsoleColor] $ForegroundColor = 'White',
            [ConsoleColor] $BackgroundColor = 'DarkBlue'#,
            #[bool]   $Border                = $true,
            #[int]    $BorderWidth           = ($this.TitleText.Length) + ($this.TitleMargin*2),
            #[string] $BorderTop             = "`|$("=" * $this.BorderWidth)`|",
            #[string] $BorderLeft            = "`|$(" " * $this.TitleMargin)",
            #[string] $BorderRight           = "$(" " * $this.TitleMargin)`|",
            #[string] $BorderBottom          = "`|$("=" * $this.BorderWidth)`|",
            #$HostForegroundColor,            #= $Host.UI.RawUI.ForegroundColor,
            #$HostBackgroundColor            #= $Host.UI.RawUI.BackgroundColor
        ) {
            $this.TitleText = $TitleText
            $this.TitleMargin = $TitleMargin
            $this.ForegroundColor = $ForegroundColor
            $this.BackgroundColor = $BackgroundColor
            #$this.BorderWidth = $TitleText.Length + ($TitleMargin*2)
            #$this.Border = $true
            #$this.HostForegroundColor = $HostForegroundColor
            #$this.HostBackgroundCOlor = $HostBackgroundColor
        }

        #endregion Constructs

        #region Methods
        [StyleTitle]UpdateBorders() {
            [int]    $this.BorderWidth           = ($this.TitleText.Length) + ($this.TitleMargin*2)
            [string] $this.BorderTop             = "`|$("=" * $this.BorderWidth)`|"
            [string] $this.BorderLeft            = "`|$(" " * $this.TitleMargin)"
            [string] $this.BorderRight           = "$(" " * $this.TitleMargin)`|"
            [string] $this.BorderBottom          = "`|$("=" * $this.BorderWidth)`|"
            return $this
        }

        WriteHost() {
            $this.UpdateBorders()
            Function Reset-LineColor { Write-Host "" -ForegroundColor White -BackgroundColor Black }
            # Top border 1
            Write-Host $($this.BorderTop) -ForegroundColor $this.ForegroundColor -BackgroundColor $this.BackgroundColor -NoNewline ; Reset-LineColor
            # Top border 2: side borders and blank line above title
            Write-Host "$($this.BorderLeft)$(" " * ($this.TitleText.Length))$($this.BorderRight)" -ForegroundColor $this.ForegroundColor -BackgroundColor $this.BackgroundColor -NoNewline ; Reset-LineColor
            # Title left border / Title / Title right border
            Write-Host $($this.BorderLeft) -ForegroundColor $this.ForegroundColor -BackgroundColor $this.BackgroundColor -NoNewline
            Write-Host $($this.TitleText) -ForegroundColor $this.BackgroundColor -BackgroundColor $this.ForegroundColor -NoNewline
            Write-Host $($this.BorderRight) -ForegroundColor $this.ForegroundColor -BackgroundColor $this.BackgroundColor -NoNewline ; Reset-LineColor
            # Bottom border 2: side borders and blank line below title
            Write-Host "$($this.BorderLeft)$(" " * $this.TitleText.Length)$($this.BorderRight)" -ForegroundColor $this.ForegroundColor -BackgroundColor $this.BackgroundColor -NoNewline ; Reset-LineColor
            # Bottom border 1
            Write-Host $($this.BorderBottom) -ForegroundColor $this.ForegroundColor -BackgroundColor $this.BackgroundColor -NoNewline ; Reset-LineColor
        }

        WriteLog ($Title) {
            #
        }
        #endregion Methods
    }
    #endregion StyleTitleDefinition

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

    # ====== # ClassExperiments Examples # ====== #
    [styletitle]::new("Hello, World!",16,'Green','Black').WriteHost()
    [styletitle]::new("Hello, Everyone!",4,'White','DarkBlue').WriteHost()
    $Title = [StyleTitle]::new(@{
        TitleText = "This Report Will Be Amazing"
        TitleMargin = 8
        ForegroundColor = 'Cyan'
        BackgroundCOlor = 'DarkBlue'
    })
    $Title.WriteHost()
#endregion ClassExperiments
