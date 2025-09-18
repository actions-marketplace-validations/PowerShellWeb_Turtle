
<#
.SYNOPSIS
    Draws a Cubic Bezier Curve
.DESCRIPTION
    Draws a Cubic Bezier curve.

    Cubic Bezier curves take three points:

    * A Start Control Point
    * An End Control Point
    * An End Point

    A line will be drawn from the current position to the end point,
    curved towards both the start and control point.
.EXAMPLE
    turtle @(
        'CubicBezierCurve',
            200,0,  # Start Control Point 
            0,200,  # End Control Point
            200,200 # End Point        
    ) save ./cubic.svg
.EXAMPLE
    turtle width 200 height 200 morph @(
        turtle 'CubicBezierCurve',
            200,0,  # Start Control Point 
            0,200,  # End Control Point
            200,200 # End Point
            
        turtle 'CubicBezierCurve',
            0,200,  # Start Control Point 
            200,0,  # End Control Point
            200,200 # End Point
        turtle 'CubicBezierCurve',
            200,0,  # Start Control Point 
            0,200,  # End Control Point
            200,200 # End Point
    ) save ./CubicMorph.svg
.EXAMPLE
    turtle width 200 height 200 morph @(
        turtle 'CubicBezierCurve',
            200,0,    # Start Control Point 
            0,200,    # End Control Point
            200,200   # End Point
            
        turtle 'CubicBezierCurve',
            0,200,    # Start Control Point 
            200,0,    # End Control Point
            200,200   # End Point

        turtle 'CubicBezierCurve',
            200,200,  # Start Control Point 
            200,0,    # End Control Point
            200,200   # End Point
        
        turtle 'CubicBezierCurve',
            0,200,    # Start Control Point 
            0,200,    # End Control Point
            200,200   # End Point

        turtle 'CubicBezierCurve',
            400,0,    # Start Control Point 
            0,200,    # End Control Point
            200,200   # End Point

        turtle 'CubicBezierCurve',
            0,200,      # Start Control Point 
            200,0,      # End Control Point
            200,200   # End Point

        turtle 'CubicBezierCurve',
            400,0,    # Start Control Point 
            0,400,    # End Control Point
            200,200   # End Point

        turtle 'CubicBezierCurve',
            0,200,      # Start Control Point 
            200,0,      # End Control Point
            200,200   # End Point        

        turtle 'CubicBezierCurve',
            200,0,   # Start Control Point 
            0,200,   # End Control Point
            200,200  # End Point
    ) save ./MoreCubicMorphs.svg   
.NOTES
    This corresponds to the `c` element in an SVG Path
.LINK
    https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorials/SVG_from_scratch/Paths#b%C3%A9zier_curves
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

