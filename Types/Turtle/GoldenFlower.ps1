<#
.SYNOPSIS
    Draws a golden rectangle flower pattern.
.DESCRIPTION
    Draws a flower made out of golden rectangles.

    This pattern consists of a series of rectangles and rotations to create a flower-like design.
.EXAMPLE
    Turtle GoldenFlower
.EXAMPLE
    Turtle StarFlower 42 20 10
.EXAMPLE
    Turtle StarFlower 42 40 13 9
.EXAMPLE
    Turtle StarFlower 84 40 6 9 | Save-Turtle ./StarFlowerPattern.svg Pattern
#>
param(
    # The width of each rectangle
    [double]$Size = 42,
    # The rotation after each rectangle
    [double]$Rotation = 20,
    # The number of steps.
    [int]$StepCount = 18
)

$null = foreach ($n in 1..([Math]::Abs($StepCount))) {    
    $this.Rectangle($Size)
    $this.Rotate($Rotation)
}

return $this