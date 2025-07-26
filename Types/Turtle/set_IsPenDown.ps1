param(
[bool]
$IsDown
)

$this | 
    Add-Member -MemberType NoteProperty -Force -Name '.IsPenDown' -Value $IsDown
    
if ($VerbosePreference -ne 'SilentlyContinue') {
    Write-Verbose "Turtle is now $($IsDown ? 'down' : 'up')"
}