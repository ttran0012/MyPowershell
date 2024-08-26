#Style default PowerShell Console
$shell = $Host.UI.RawUI
$shell.BackgroundColor = "Black"
$shell.ForegroundColor = "Green"

function prompt {

    # I want to see the full path of the current directory as the window title
    $host.ui.RawUI.WindowTitle = "[PWD] $pwd"

    ## part1: Check if i'm admin
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    Write-host ($(if ($IsAdmin) { 'ADMIN ' } else { '' })) -BackgroundColor DarkBlue -ForegroundColor White -NoNewline

    ## part2: month and day
    $Day = (Get-Date -Format 'yyyy/MM/dd')
    $JulianDate = (Get-Date).DayOfYear # Example "001"
    Write-Host "$Day" -ForegroundColor White -Backgroundcolor DarkMagenta -nonewline

    ## part3: time
    $CurrentTime = Get-Date -Format 'HH:mm:ss' # Example "23:59:59"
    Write-Host "$($CurrentTime) " -ForegroundColor White -Backgroundcolor Magenta -nonewline

    # part4: just the PS> prompt
    Return "PS> "

} #end prompt function
