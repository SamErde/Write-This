function Write-This {
    <#
    .SYNOPSIS
    Write a string of text to the host and/or a log file simultaneously.

    .DESCRIPTION
    Write-This can write text to the host console and to a log file simulatenously. Its purpose is to reduce the amount
    of code that is needed to provide interactive output and logs during an operation.

    .PARAMETER Text
    The text that will be written.

    .PARAMETER Output
    The stream or type of output to write to: host and/or log file.

    .PARAMETER ForegroundColor
    When writing to the host console, a foreground color can be specified.

    .PARAMETER BackgroundColor
    When writing to the host console, a background color can be specified.

    .EXAMPLE
    Write a string of text to the host console and to the log file, with colors in the host.

    Write-This -Text "This is a sample message." -Output Both -ForegroundColor White -BackgroundColor DarkBlue
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Support using Write-Host and colors for interactive scripts.')]
    [OutputType([string])]
    param (
        # The message to display and/or write to a log file
        [Parameter(Mandatory, Position = 0)]
        [string]
        $Text,

        # Type of output to write
        [Parameter(Position = 1)]
        [ValidateSet('Both','HostOnly','LogOnly')]
        [string]
        $Output = 'Both',

        # Set the foreground color for streams that support it
        [Parameter(ParameterSetName = 'Decoration')]
        [System.ConsoleColor]$ForegroundColor,

        # Set the background color for streams that support it
        [Parameter(ParameterSetName = 'Decoration')]
        [System.ConsoleColor]$BackgroundColor

        <# Concept for optional decoration of host output.
        # Apply a style where supported
        [Parameter(ParameterSetName = 'Decoration')]
        $Style
        #>
    )

    begin {
        # Add colors to the host output if they are specified in the function parameters.
        if ($PSBoundParameters.ContainsKey('ForegroundColor') -and $PSBoundParameters.ContainsKey('BackgroundColor')) {
            [scriptblock]$HostOutput = {Write-Host $LogText -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor}
        } else {
            [scriptblock]$HostOutput = {Write-Host $LogText}
        }
    }

    process {
        switch ($Output) {
            Both {
                $HostOutput.Invoke()
                [void]$script:LogStringBuilder.AppendLine($LogText)
            }
            HostOnly {
                $HostOutput.Invoke()
            }
            LogOnly {
                [void]$script:LogStringBuilder.AppendLine($LogText)
            }
        } # end switch Output
    }

    end {
        # Nothing here yet.
    }
} # end function Write-This
