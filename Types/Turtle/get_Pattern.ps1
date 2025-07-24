param()
$segments = @(
$viewX = $this.Maximum.X + ($this.Minimum.X * -1)
$viewY = $this.Maximum.Y + ($this.Minimum.Y * -1)
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
        "<path id='turtle-path' d='$($this.PathData)' stroke='$(
            if ($this.Stroke) { $this.Stroke } else { 'black' }
        )' stroke-width='$(
            if ($this.StrokeWidth) { $this.StrokeWidth } else { '0.1%' }
        )' fill='transparent'/>"
    "</pattern>"
"</defs>"
"<rect width='10000%' height='10000%' x='-5000%' y='-5000%' fill='url(#turtle-pattern)' />"
"</svg>") 

$segments -join '' -as [xml]