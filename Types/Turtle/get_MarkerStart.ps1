<#
.SYNOPSIS
    Gets a Turtle's start marker
.DESCRIPTION
    Gets the start marker used on the line drawn by the turtle
.EXAMPLE
    turtle viewbox 200 teleport 0 100 forward 100 markerStart (
        turtle rotate -90 turtleMonotile -42 fill context-fill stroke context-stroke
    ) fill 'currentColor' strokewidth '3%' save ./marker.svg
#>
return $this.PathAttribute['marker-start']
