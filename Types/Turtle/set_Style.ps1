<#
.SYNOPSIS
    Sets a Turtle's Style
.DESCRIPTION
    Sets any CSS styles associated with the Turtle.

    These styles will be declared in a `<style>` element, just beneath a Turtle's `<svg>`
.EXAMPLE
    turtle style '.myClass { color: #4488ff}' style
#>
param(
[PSObject]
$Style
)

$styleList = $this.Style
$styleList += $style
$this | Add-Member NoteProperty '.style' $styleList -Force 
