param()
@(

$viewX = $this.Maximum.X + ($this.Minimum.X * -1)
$viewY = $this.Maximum.Y + ($this.Minimum.Y * -1)

"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 $viewX $viewY' transform-origin='50% 50%' width='100%' height='100%'>"
    "<path id='turtle-path' transform-origin='50% 50%' d='$($this.PathData)' stroke='$(
        if ($this.Stroke) { $this.Stroke } else { '#4488ff' }
    )' stroke-width='$(
        if ($this.StrokeWidth) { $this.StrokeWidth } else { '0.1%' }
    )' fill='transparent'/>"
"</svg>"
) -join '' -as [xml]