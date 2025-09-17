<#
.SYNOPSIS
    Sets a Turtle's class
.DESCRIPTION
    Sets any CSS classes associated with the turtle
.EXAMPLE
    turtle class foo bar baz bing class
#>
param(
$Class
)

$this.SVGAttribute['class'] = $Class -join ' '
