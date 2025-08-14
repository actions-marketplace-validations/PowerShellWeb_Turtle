<#
.SYNOPSIS
    Arcs the turtle to the right
.DESCRIPTION
    Arcs the turtle to the right (clockwise) a number of degrees.

    For each degree, the turtle will move forward and rotate.
.NOTES
    The amount moved forward will be the portion of the circumference.
#>
param(
# The radius of a the circle, were it to complete the arc.
[double]
$Radius = 10,

# The angle of the arc
[double]
$Angle = 60
)


# Determine the absolute angle, for this
$absAngle = [Math]::Abs($angle)
$circumferenceStep = ([Math]::PI * 2 * $Radius) / $absAngle

$iteration = $angle / [Math]::Floor($absAngle)
$angleDelta = 0 
$null = while ([Math]::Abs($angleDelta) -lt $absAngle) {
    $this.Forward($circumferenceStep)
    $this.Rotate($iteration)
    $angleDelta+=$iteration
}

return $this