<#
.SYNOPSIS
    Gets a Turtle's text element
.DESCRIPTION
    Gets a Turtle's text as a SVG Text element.

    If the Turtle does not have any text, this will return nothing.

    If the Turtle has text, but no path, the text will be centered in the Turtle's viewbox.
.LINK
    https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Element/text
.EXAMPLE
    turtle text "hello world" textElement
#>
[OutputType([xml])]
param()

if (-not $this.Text) { return }

$textAttributes = [Ordered]@{}

if (-not $this.Steps) {
    $textAttributes['dominant-baseline'] = 'middle'
    $textAttributes['text-anchor'] = 'middle'
    $textAttributes['x'] = '50%'
    $textAttributes['y'] = '50%'
}

foreach ($collection in 'SVGAttribute','Attribute') {
    foreach ($key in $this.$collection.Keys) {
        if ($key -match '^text/') {
            $textAttributes[$key -replace '^text/'] = $this.$collection[$key]
        }
    }
}

foreach ($key in $this.TextAttribute.Keys) {
    $textAttributes[$key] = $this.TextAttribute[$key]
}

return [xml]@(
"<text id='$($this.ID)-text' $(
    foreach ($TextAttributeName in $TextAttributes.Keys) {
        " $TextAttributeName='$($TextAttributes[$TextAttributeName])'"
    }
)>"
if ($this.TextAnimation) {$this.TextAnimation}
if ($this.Steps) {
    "<textPath href='#$($this.id)-path'>$([Security.SecurityElement]::Escape($this.Text))</textPath>"
} else {
    $([Security.SecurityElement]::Escape($this.Text))
}
"</text>"
)


