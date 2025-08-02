<#
.SYNOPSIS
    Determines the distance to a point
.DESCRIPTION
    Determines the distance from the turtle's current position to a point.
#>
param(
# The X-coordinate
[double]$X = 0,
# The Y-coordinate
[double]$Y = 0
)

# Determine the delta from the turtle's current position to the specified point
$deltaX = $this.Position.X - $X
$deltaY = $this.Position.Y - $Y
# Calculate the distance using the Pythagorean theorem
return [Math]::Sqrt($deltaX * $deltaX + $deltaY * $deltaY)
