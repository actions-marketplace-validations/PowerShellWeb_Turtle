<#
.SYNOPSIS
    Gets the turtle's heading.
.DESCRIPTION
    Gets the current heading of the turtle.
#>
param()
if ($null -ne $this.'.TurtleHeading') {
    return $this.'.TurtleHeading'
}
return 0

