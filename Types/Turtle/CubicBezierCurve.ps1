
<#
.SYNOPSIS
    Draws a Bezier Curve
.DESCRIPTION
    Draws a simple Bezier curve.  
.EXAMPLE
    turtle @(
        'CubicBezierCurve',
            200,0,  # Start Control Point 
            0,200,  # End Control Point
            200,200 # End Point        
    ) save ./cubic.svg
.LINK
    https://en.wikipedia.org/wiki/B%C3%A9zier_curve
#>
param(
# The X control point
[double]
$ControlStartX,

# The Y control point
[double]
$ControlStartY,

# The X control point
[double]
$ControlEndX,

# The Y control point
[double]
$ControlEndY,

# The delta X
[double]
$DeltaX,

# The delta Y
[double]
$DeltaY
)



if ($DeltaX -or $DeltaY) {
    $this.Position = $DeltaX, $DeltaY
    # If the pen is down
    if ($this.IsPenDown) {
        # draw the curve
        $this.Steps.Add("c $ControlStartX $ControlStartY $ControlEndX $ControlEndY $DeltaX $DeltaY")
    } else {        
        # otherwise, move to the deltaX/deltaY
        $this.Steps.Add("m $DeltaX $DeltaY")
    }
}

return $this

