<#
.SYNOPSIS
    Determines the angle towards a point
.DESCRIPTION
    Determines the angle from the turtle's current position towards a point.
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
# Calculate the angle in radians and convert to degrees
$angle = [Math]::Atan2($deltaY, $deltaX) * 180 / [Math]::PI
# Return the angle rotate by 90 to account for the turtle's coordinate system
return $angle + 90
