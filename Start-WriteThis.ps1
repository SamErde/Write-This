function Start-WriteThis {

    [CmdletBinding()]
    param (
        # Log path and filename. A default name will be generated if none is provided.
        [Parameter()]
        [string]
        $LogFile
    )

    begin {
        $script:StartTime = Get-Date

        # Generate a log file name if one was not specified in the parameters.
        if ( -not $PSBoundParameters.ContainsKey('LogFile') ) {
            $LogFile = "Log File {0}.txt" -f ($StartTime.ToString("yyyy-MM-dd HH_mm_ss"))
        }
    }

    process {
        # Start the log string builder.
        $script:LogStringBuilder = [System.Text.StringBuilder]::New()
        Write-Verbose -Message "Log string builder initialized for [script name]."
    }

    end {
        # Nothing here yet
    }
}
