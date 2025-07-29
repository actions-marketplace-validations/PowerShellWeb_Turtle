function New-Turtle
{
    <#
    .SYNOPSIS
        Creates a new turtle object.
    .DESCRIPTION
        This function initializes a new turtle object with default properties.
    .EXAMPLE
        $turtle = New-Turtle 
        $turtle.Square(100).Pattern.Save("$pwd/SquarePattern.svg")
    #>
    param()
    [PSCustomObject]@{PSTypeName='Turtle'}
}
