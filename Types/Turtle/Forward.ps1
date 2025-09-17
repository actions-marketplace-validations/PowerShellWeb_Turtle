<#
.SYNOPSIS
    Moves the turtle forward
.DESCRIPTION
    Moves the turtle forward along the current heading
.EXAMPLE
    turtle forward rotate 90 forward rotate 90 forward rotate 90 forward rotate 90
#>
param(
# The distance to move forward
[double]
$Distance = 10
)

$precision = if ($this.Precision -ge 0) { $this.Precision } else { 4 }

$x = $Distance * ([Math]::Round([math]::cos($this.Heading * [Math]::PI / 180), $precision))
$y = $Distance * ([Math]::Round([math]::sin($this.Heading * [Math]::PI / 180), $precision))

return $this.Step($x, $y)
