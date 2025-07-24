param()

@(    
    "<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%'>"
        "<symbol id='turtle-symbol' viewBox='$($this.ViewBox)' transform-origin='50% 50%'>"
            "<path id='turtle-path' transform-origin='50% 50%' d='$($this.PathData)' stroke='$(
                if ($this.Stroke) { $this.Stroke } else { 'black' }
            )' stroke-width='$(
                if ($this.StrokeWidth) { $this.StrokeWidth } else { '0.1%' }
            )' fill='transparent'/>"
        "</symbol>"
        "<use href='#turtle-symbol' width='100%' height='100%' />"
    "</svg>"
) -join '' -as [xml]