function Set-Turtle {
    <#
    .SYNOPSIS
        Sets a turtle.
    .DESCRIPTION
        Changes properties of a turtle, and returns the turtle.
    .EXAMPLE
        New-Turtle | 
            Move-Turtle SierpinskiTriangle 20 3 |
            Set-Turtle -Property Stroke -Value '#4488ff' |
            Save-Turtle "./SierpinskiTriangle.svg"
    #>
    param(
    # The property of the turtle to set.
    [Parameter(Mandatory)]
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        $myInv = $myInvocation
        $turtleType = Get-TypeData -TypeName Turtle
        $propertyNames = @(foreach ($memberName in $turtleType.Members.Keys) {
            if ($turtleType.Members[$memberName] -is [System.Management.Automation.Runspaces.ScriptPropertyData] -and
                $turtleType.Members[$memberName].SetScriptBlock) {
                $memberName
            }
        })
                
        if ($wordToComplete) {
            return $propertyNames -like "$wordToComplete*"            
        } else {
            return $propertyNames
        }
    })]
    [string]
    $Property = 'Stroke',
    
    # The value to set.
    [PSObject]
    $Value,

    # The turtle input object.
    [Parameter(ValueFromPipeline)]
    [Alias('Turtle')]
    [PSObject]
    $InputObject
    )

    process {
        if (-not $inputObject) { return }
        $propInfo = $inputObject.psobject.properties[$property]
        if (-not $propInfo.SetterScript) {
            Write-Error "Property '$property' can not be set."
            return
        }
        $inputObject.$property = $Value
        return $inputObject
    }
}
