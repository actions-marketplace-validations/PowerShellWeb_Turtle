<#
.SYNOPSIS
    Saves the turtle.
.DESCRIPTION
    Saves the current turtle to a file.
.LINK
    Save-Turtle
#>
param(
[string]
$FilePath,

[string]
$Property
)

return $this | Save-Turtle $FilePath -Property $Property
