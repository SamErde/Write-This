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

    .PARAMETER Style
    The style to use for your message.

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
        [ValidateSet('Both', 'HostOnly', 'LogOnly')]
        [string]
        $Output = 'Both',

        # The style to use for your message
        [Parameter()]
        [ValidateSet('Title', 'Subtitle', 'Basic', 'Code', 'Detail1', 'Detail2', 'Detail3')]
        [string]
        $Style = 'Basic',

        # Override the style's default foreground color
        [Parameter()]
        [System.ConsoleColor]$ForegroundColor,

        # Override the style's default background color
        [Parameter()]
        [System.ConsoleColor]$BackgroundColor
    )

    begin {
        # Define text wrappers for styles
        $Wrap = @{
            Title    = @{
                Prefix = "`n.:: "
                Suffix = " ::.`n"
            }
            SubTitle = @{
                Prefix = "`n... "
                Suffix = " ...`n"
            }
        }

        # Define a Write-Host splat for each style with overridable colors
        $StyleSplatter = @{
            Title    = @{
                ForegroundColor = if ($ForegroundColor) { $ForegroundColor } else { 'Cyan' }
                BackgroundColor = if ($BackgroundColor) { $BackgroundColor } else { 'Black' }
                Object          = if ($Wrap.ContainsKey($Style)) { '{0}{1}{2}' -f ($Wrap[$Style].Prefix, $Text, $Wrap[$Style].Suffix) } else { $Text }
            }
            SubTitle = @{
                ForegroundColor = if ($ForegroundColor) { $ForegroundColor } else { 'White' }
                BackgroundColor = if ($BackgroundColor) { $BackgroundColor } else { 'Black' }
                Object          = if ($Wrap.ContainsKey($Style)) { '{0}{1}{2}' -f ($Wrap[$Style].Prefix, $Text, $Wrap[$Style].Suffix) } else { $Text }
            }
            Code     = @{
                ForegroundColor = if ($ForegroundColor) { $ForegroundColor } else { 'Black' }
                BackgroundColor = if ($BackgroundColor) { $BackgroundColor } else { 'Gray' }
                Object          = if ($Wrap.ContainsKey($Style)) { '{0}{1}{2}' -f ($Wrap[$Style].Prefix, $Text, $Wrap[$Style].Suffix) } else { $Text }
            }
            Basic    = @{
                Object = $Text
            }
        }
        $HostSplat = $StyleSplatter[$Style]
    } #end Begin

    process {
        switch ($Output) {
            Both {
                Write-Host @HostSplat
                [void]$script:LogStringBuilder.AppendLine($LogText)
            }
            HostOnly {
                Write-Host @HostSplat
            }
            LogOnly {
                [void]$script:LogStringBuilder.AppendLine($LogText)
            }
        } # end switch Output
    } # end Process

    end {
        # Nothing here yet.
    }
} # end function Write-This
