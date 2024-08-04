function Write-This {
    # Write a string of text to the host and/or a log file simultaneously.
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Support using Write-Host and colors for interactive scripts.')]
    [OutputType([string])]
        param (
            # The message to display and/or write to a log file
            [Parameter(Mandatory, Position = 0)]
            [string]
            $LogText,

            # Type of output to write
            [Parameter(Position = 1)]
            [ValidateSet('Both','HostOnly','LogOnly')]
            [string]
            $Output = 'Both'

# Trying to code on my phone
# Set the foreground color for streams that support it
[Parameter()]
[System.ConsoleColor]$ForegroundColor

# Set the background color for streams that support it
[Parameter()]
[System.ConsoleColor]$BackgroundColor

# Apply a style where supported
[Parameter()]
#finish later
$Style

        )

    switch ($Output) {
        Both {
            Write-Host "$LogText"
            [void]$LogStringBuilder.AppendLine($LogText)
        }
        HostOnly {
            Write-Host "$LogText"
        }
        LogOnly {
            [void]$LogStringBuilder.AppendLine($LogText)
        }
    } # end switch Output
} # end function Write-This
