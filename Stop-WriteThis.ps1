function Stop-WriteThis {
    <#
    .SYNOPSIS
    Write the Write-This string builder to a log file.

    .DESCRIPTION
    Write the Write-This string builder to a log file. This function should be called in the end block of any script
    that uses Write-This to create a log file.

    .PARAMETER LogFile
    The log file that all "Write-This" text gets written to.

    .EXAMPLE
    Stop-Write-This -LogFile $script:LogFile
    #>
    [CmdletBinding()]
    param (
        # Log path and filename.
        [Parameter()]
        [ValidateScript({Test-Path $LogFile -IsValid})]
        [string]
        $LogFile
    )

    begin {
        $script:FinishTime = Get-Date

        # Need to add validation for log file path.
        if (-not $PSBoundParameters.ContainsKey('LogFile')) {
            $LogFile = $script:LogFile
        }
    }

    process {
        try {
            $script:LogStringBuilder.ToString() | Out-File -FilePath $LogFile -Encoding utf8 -Force
            Write-Output "`nThe log file has been written to `'$LogFile`'."
        } catch {
            Write-Warning -Message "Unable to write to the logfile `'$LogFile`'."
            $_
        }
    }

    end {
        # Nothing here yet.
    }
}
