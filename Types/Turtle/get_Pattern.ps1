param()
$segments = @(
$viewBox = $this.ViewBox
$null, $null, $viewX, $viewY = $viewBox
"<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%'>"
"<defs>"
    "<pattern id='turtle-pattern' patternUnits='userSpaceOnUse' width='$viewX' height='$viewY' transform-origin='50% 50%'$(
        if ($this.PatternTransform) {
            " patternTransform='" + (
                @(foreach ($key in $this.PatternTransform.Keys) {
                    "$key($($this.PatternTransform[$key]))"
                }) -join ' '
            ) + "'"
        }
    )>"
        $(if ($this.PatternAnimation) { $this.PatternAnimation })
        $this.PathElement.OuterXml        
    "</pattern>"
"</defs>"
$(
    if ($this.BackgroundColor) {
        "<rect width='10000%' height='10000%' x='-5000%' y='-5000%' fill='$($this.BackgroundColor)' transform-origin='50% 50%' />"
    }
)
"<rect width='10000%' height='10000%' x='-5000%' y='-5000%' fill='url(#turtle-pattern)' transform-origin='50% 50%' />"
"</svg>") 

$segments -join '' -as [xml]