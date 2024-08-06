function Start-WriteThis {
    <#
    .SYNOPSIS
    Start using Write-This.

    .DESCRIPTION
    This function should be called in the begin block of any script that uses Write-This. It creates the string builder
    and defines the log file that will be written to.

    .PARAMETER LogFile
    The path and filename that log text will be written to.

    .EXAMPLE
    Start-WriteThis -LogFile 'C:\Temp\StartLogging.txt'

    #>
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
            $script:LogFile = "Log File {0}.txt" -f ($StartTime.ToString("yyyy-MM-dd HH_mm_ss"))
        } else {
            $script:LogFile = $LogFile
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
