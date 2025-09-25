<#
.SYNOPSIS
    Gets a Turtle's Style
.DESCRIPTION
    Gets any CSS styles associated with the Turtle.

    These styles will be declared in a `<style>` element, just beneath a Turtle's `<svg>`
.EXAMPLE
    turtle style '.myClass { color: #4488ff}' style
#>
param()

if (-not $this.'.style') {
    $this | Add-Member NoteProperty '.style' @() -Force
}

return $this.'.style'