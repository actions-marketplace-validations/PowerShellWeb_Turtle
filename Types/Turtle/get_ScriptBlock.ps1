<#
.SYNOPSIS
    Get the Turtle's ScriptBlock
.DESCRIPTION
    Gets the ScriptBlock used to create the turtle.

    All steps will become a fluent pipeline.
.EXAMPLE
    turtle SierpinskiTriangle 42 4 | 
        Select-Object -ExpandProperty ScriptBlock
#>
[ScriptBlock]::Create(
    $this.Commands.Extent -join (' |' + [Environment]::NewLine + '    ')
)
