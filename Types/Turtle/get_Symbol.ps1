param()

@(
    $viewX = [Math]::Max($this.Maximum.X, $this.Minimum.X * -1)
    $viewY = [Math]::Max($this.Maximum.Y, $this.Minimum.Y * -1)
    "<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%'>"
        "<symbol id='turtle-symbol' viewBox='0 0 $viewX $viewY' transform-origin='50% 50%'>"
            "<path id='turtle-path' transform-origin='50% 50%' d='$($this.PathData)' stroke='$(
                if ($this.Stroke) { $this.Stroke } else { 'black' }
            )' fill='transparent'/>"
        "</symbol>"
        "<use href='#turtle-symbol' width='100%' height='100%' />"
    "</svg>"
) -join '' -as [xml]