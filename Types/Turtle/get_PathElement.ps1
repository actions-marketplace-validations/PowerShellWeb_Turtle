@(
"<path id='turtle-path' d='$($this.PathData)' stroke='$(
    if ($this.Stroke) { $this.Stroke } else { 'black' }
)' stroke-width='$(
    if ($this.StrokeWidth) { $this.StrokeWidth } else { '0.1%' }
)' fill='transparent' class='foreground-stroke' />"
) -as [xml]