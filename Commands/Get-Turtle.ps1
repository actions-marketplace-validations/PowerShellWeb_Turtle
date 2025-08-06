function Get-Turtle {
    <#
    .SYNOPSIS
        Gets Turtle in PowerShell
    .DESCRIPTION
        Gets, sets, and moves a turtle object in PowerShell.
    .NOTES
        Each argument can be the name of a member of the turtle object.

        After a member name is encountered, subsequent arguments will be passed to the member as parameters.        
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
        $memberNames = @($script:TurtleTypeData.Members.Keys)
                
        if ($wordToComplete) {
            return $memberNames -like "$wordToComplete*"
        } else {
            return $memberNames
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
        # Get information about our turtle pseudo-type.
        $turtleType = Get-TypeData -TypeName Turtle
        # any member name is a potential command
        $memberNames = $turtleType.Members.Keys

        # We want to sort the member names by length, in case we need them in a pattern or want to sort quickly.
        $memberNames = $memberNames | Sort-Object @{Expression={ $_.Length };Descending=$true}, name
        # Create a new turtle object in case we have no turtle input.
        $currentTurtle = [PSCustomObject]@{PSTypeName='Turtle'}
    }

    process {        
        if ($PSBoundParameters.InputObject -and 
            $PSBoundParameters.InputObject.pstypenames -eq 'Turtle') {
            $currentTurtle = $PSBoundParameters.InputObject
        } elseif ($PSBoundParameters.InputObject) {
            # If input was passed, and it was not a turtle, pass it through.
            return $PSBoundParameters.InputObject
        }


        # First we want to split each argument into words.
        # This way, it is roughly the same if you say:
        # * `turtle 'forward 10'`
        # * `turtle forward 10`
        # * `turtle 'forward', 10`
        $wordsAndArguments = @(foreach ($arg in $ArgumentList) {
            # If the argument is a string, split it by whitespace.
            if ($arg -is [string]) {
                $arg -split '\s{1,}'
            }  else {
                # otherwise, leave the argument alone.
                $arg
            }
        })

        # Now that we have a series of words, we can process them.
        # We want to keep track of the current member, 
        # and continue to the next word until we find a member name.        
        $currentMember = $null
        $outputTurtle = $false

        # To do this in one pass, we will iterate through the words and arguments.
        # We use an indexed loop so we can skip past claimed arguments.
        for ($argIndex =0; $argIndex -lt $wordsAndArguments.Length; $argIndex++) {            
            $arg = $wordsAndArguments[$argIndex]
            # If the argument is not in the member names list, we can complain about it.
            if ($arg -notin $memberNames) {                
                if (-not $currentMember -and $arg -is [string]) {
                    Write-Warning "Unknown command '$arg'."
                }
                continue
            }
                 
            
            # If we have a current member, we can invoke it or get it.
            $currentMember = $arg
            # We can also begin looking for arguments 
            for (
                # at the next index.
                $methodArgIndex = $argIndex + 1; 
                # We will continue until we reach the end of the words and arguments,
                $methodArgIndex -lt $wordsAndArguments.Length -and 
                $wordsAndArguments[$methodArgIndex] -notin $memberNames; 
                $methodArgIndex++) {
            }
            # Now we know how long it took to get to the next member name.

            # And we can determine if we have any parameters                
            $argList = 
                if ($methodArgIndex -eq ($argIndex + 1)) {
                    @()
                }
                else {
                    $wordsAndArguments[($argIndex + 1)..($methodArgIndex - 1)]
                    $argIndex = $methodArgIndex - 1
                }

            # Look up the member information for the current member.
            $memberInfo = $turtleType.Members[$currentMember]
            # If it's an alias
            if ($memberInfo.ReferencedMemberName) {
                # try to resolve it.
                $currentMember = $memberInfo.ReferencedMemberName
                $memberInfo = $turtleType.Members[$currentMember]
            }

            
            # Now we want to get the output from the step.
            $stepOutput =
                if (
                    # If the member is a method, let's invoke it.
                    $memberInfo -is [Management.Automation.Runspaces.ScriptMethodData] -or 
                    $memberInfo -is [Management.Automation.PSMethod]
                ) {                    
                    # If we have arguments,
                    if ($argList) {
                        # pass them to the method.
                        $currentTurtle.$currentMember.Invoke($argList)
                    } else {
                        # otherwise, just invoke the method with no arguments.
                        $currentTurtle.$currentMember.Invoke()
                    }                    
                } else {
                    # If the member is a property, we can get it or set it.

                    # If we have any arguments,
                    if ($argList) {
                        # lets try to set it.        
                        $currentTurtle.$currentMember = $argList
                    } else {
                        # otherwise, lets get the property
                        $currentTurtle.$currentMember
                    }
                }

            # If the output is not a turtle object, we can output it.
            # NOTE: This may lead to multiple types of output in the pipeline.
            # Luckily, this should be one of the few cases where this does not annoy too much.
            # Properties being returned will largely be strings or numbers, and these will always output directly.
            if ($null -ne $stepOutput -and -not ($stepOutput.pstypenames -eq 'Turtle')) {
                # Output the step
                $stepOutput 
                # and set the output turtle to false.
                $outputTurtle = $false                
            } elseif ($null -ne $stepOutput) {
                # Set the current turtle to the step output.
                $currentTurtle = $stepOutput
                # and output it later (presumably).
                $outputTurtle = $true
            }
        }

        # If the last members returned a turtle object, we can output it.
        if ($outputTurtle) {
            return $currentTurtle
        }        
    }
}
