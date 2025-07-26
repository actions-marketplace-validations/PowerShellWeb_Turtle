function New-Turtle
{
    <#
    .SYNOPSIS
        Creates a new turtle object.
    .DESCRIPTION
        This function initializes a new turtle object with default properties.    
    #>
    param()

    return [PSCustomObject]@{PSTypeName='Turtle'}
}
