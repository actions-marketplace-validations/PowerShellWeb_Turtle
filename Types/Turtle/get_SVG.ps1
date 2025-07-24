param()
@(
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='$($this.ViewBox)' transform-origin='50% 50%' width='100%' height='100%'>"
    "<path id='turtle-path' transform-origin='50% 50%' d='$($this.PathData)' stroke='$(
        if ($this.Stroke) { $this.Stroke } else { '#4488ff' }
    )' stroke-width='$(
        if ($this.StrokeWidth) { $this.StrokeWidth } else { '0.1%' }
    )' fill='transparent'/>"
"</svg>"
) -join '' -as [xml]