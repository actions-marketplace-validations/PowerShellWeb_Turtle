param(
[double]
$Distance = 10
)

$x = $Distance * [math]::round([math]::cos($this.Heading * [Math]::PI / 180),15)
$y = $Distance * [math]::round([math]::sin($this.Heading * [Math]::PI / 180),15)
$this.Position = $x, $y
$this.Steps += "l $x $y"
