<#
.SYNOPSIS
    Gets the Turtle's viewbox
.DESCRIPTION
    Gets the Turtle's current viewBox.

    If this has not been set, it will be automatically calculated by the minimum and maximum
.NOTES
    turtle square 42 viewbox
#>

param()

# If we have set a viewbox, return it.
if ($this.'.ViewBox') { return $this.'.ViewBox' }

# Otherwise, subtract max from minimum to get a bounding box
$viewBox = ($this.Maximum - $this.Minimum)

$precision = $this.Precision
filter roundToPrecision { [Math]::Round($_, $precision)}

# and return the viewbox
if ($precision) {
    return 0, 0, $viewBox.X, $viewBox.Y | roundToPrecision
} else {
    return 0, 0, $viewBox.X, $viewBox.Y
}



