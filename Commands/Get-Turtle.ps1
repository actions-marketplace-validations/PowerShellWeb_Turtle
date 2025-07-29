function Get-Turtle {
    <#
    .EXAMPLE
        turtle square 50
    .EXAMPLE
        turtle circle 10
    .EXAMPLE
        turtle polygon 10 6
    .EXAMPLE
        turtle ('forward', 10, 'rotate', 120 * 3)
    #>
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('turtle')]
    param(
    # The arguments to pass to turtle.
    [ArgumentCompleter({
        param ( $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters )
        if (-not $script:TurtleTypeData) {
            $script:TurtleTypeData = Get-TypeData -TypeName Turtle
        } 
        $methodNames = @(foreach ($memberName in $script:TurtleTypeData.Members.Keys) {
            if ($script:TurtleTypeData.Members[$memberName] -is
                [Management.Automation.Runspaces.ScriptMethodData]) {
                $memberName
            }
        })
                
        if ($wordToComplete) {
            return $methodNames -like "$wordToComplete*"
        } else {
            return $methodNames
        }
    })]
    [Parameter(ValueFromRemainingArguments)]
    [PSObject[]]
    $ArgumentList,

    # Any input object to process.
    # If this is already a turtle object, the arguments will be applied to this object.
    # If the input object is not a turtle object, it will be ignored and a new turtle object will be created.
    [Parameter(ValueFromPipeline)]
    [PSObject]
    $InputObject
    )

    begin {        
        $turtleType = Get-TypeData -TypeName Turtle                
        $memberNames = @(foreach ($memberName in $turtleType.Members.Keys) {
            if (
                ($turtleType.Members[$memberName] -is [Management.Automation.Runspaces.ScriptMethodData]) -or
                (
                    $turtleType.Members[$memberName] -is 
                        [Management.Automation.Runspaces.AliasPropertyData] -and
                        $turtleType.Members[
                            $turtleType.Members[$memberName].ReferencedMemberName
                        ] -is [Management.Automation.Runspaces.ScriptMethodData]
                )
            ) {
                $memberName
            }
        })

        $memberNames = $memberNames | Sort-Object @{Expression={ $_.Length };Descending=$true}, Name                
        $currentTurtle = [PSCustomObject]@{PSTypeName='Turtle'}
    }

    process {
        
        if ($PSBoundParameters.InputObject -and 
            $PSBoundParameters.InputObject.pstypenames -eq 'Turtle') {
            $currentTurtle = $PSBoundParameters.InputObject
        }

        $currentMethod = $null

        $wordsAndArguments = foreach ($arg in $ArgumentList) {
            if ($arg -is [string]) {
                $arg -split '\s{1,}'
            }  else {
                $arg
            }
        }

        :findCommand for ($argIndex =0; $argIndex -lt $wordsAndArguments.Length; $argIndex++) {            
            $arg = $wordsAndArguments[$argIndex]
            if ($arg -in $memberNames) {
                $currentMethod = $arg
                for (
                    $methodArgIndex = $argIndex + 1; 
                    $methodArgIndex -lt $wordsAndArguments.Length -and 
                    $wordsAndArguments[$methodArgIndex] -notin $memberNames; 
                    $methodArgIndex++) {
                }
                # Command without parameters
                if ($methodArgIndex -eq $argIndex) {
                    $argList = @()
                    $currentTurtle = $currentTurtle.$currentMethod.Invoke()
                }
                else {
                    $argList = $wordsAndArguments[($argIndex + 1)..($methodArgIndex - 1)]
                    $currentTurtle = $currentTurtle.$currentMethod.Invoke($argList)
                    # "$($currentMethod) $($argList -join ' ')"
                    $argIndex = $methodArgIndex - 1
                }
            }
        }
                
        return $currentTurtle
    }
}
