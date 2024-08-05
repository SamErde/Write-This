function Stop-WriteThis {
    [CmdletBinding()]
    param (
        # Log path and filename.
        [Parameter(Mandatory)]
        [string]
        $LogFile
    )

    begin {
        $script:FinishTime = Get-Date

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
