@(
"<path id='turtle-path' d='$($this.PathData)' stroke='$(
    if ($this.Stroke) { $this.Stroke } else { 'currentColor' }
)' stroke-width='$(
    if ($this.StrokeWidth) { $this.StrokeWidth } else { '0.1%' }
)' fill='$($this.Fill)' class='$(
    $this.PathClass -join ' '
)' $(
    foreach ($pathAttributeName in $this.PathAttribute.Keys) {
        " $pathAttributeName='$($this.PathAttribute[$pathAttributeName])'"
    }
) />"
) -as [xml]