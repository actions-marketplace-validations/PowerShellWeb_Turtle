<#
.SYNOPSIS
    Sets the turtle's heading.
.DESCRIPTION
    Sets the turtle's heading.  
    
    This is one of two key properties of the turtle, the other being its position.
#>
param(
# The new turtle heading.  
[double]
$Heading
)

if ($this -and -not $this.psobject.properties['.TurtleHeading']) {
    $this.psobject.properties.add([PSNoteProperty]::new('.TurtleHeading', 0), $false)
}
$this.'.TurtleHeading' = $Heading

# $this.psobject.properties.add([PSNoteProperty]::new('.TurtleHeading', $Heading), $false)
# $this |  Add-Member -MemberType NoteProperty -Force -Name '.TurtleHeading' -Value $Heading
if ($VerbosePreference -ne 'SilentlyContinue') {
    Write-Verbose "Heading to $Heading"
}