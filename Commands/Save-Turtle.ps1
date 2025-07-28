function Save-Turtle {
    <#
    .SYNOPSIS
        Saves a turtle.
    .DESCRIPTION
        Saves a turtle graphics pattern to a file.
    .EXAMPLE
        New-Turtle | 
            Move-Turtle Si
    #>
    param(
    # The file path to save the turtle graphics pattern.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Path')]
    [string]
    $FilePath,

    # The property of the turtle to save.
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        $myInv = $myInvocation
        $turtleType = Get-TypeData -TypeName Turtle
        $propertyNames = @(foreach ($memberName in $turtleType.Members.Keys) {
            if ($turtleType.Members[$memberName] -is [System.Management.Automation.Runspaces.ScriptPropertyData]) {
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
    $Property = 'Symbol',

    # The turtle input object.
    [Parameter(ValueFromPipeline)]
    [Alias('Turtle')]
    [PSObject]
    $InputObject
    )

    process {
        if (-not $inputObject) { return }
        $toExport = $inputObject.$Property
        if (-not $toExport) { return }
        $unresolvedPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($FilePath)
        $null = New-Item -ItemType File -Force -Path $unresolvedPath
        if ($toExport -is [xml]) {
            $toExport.Save("$unresolvedPath")
        }
        elseif ($toExport -is [byte[]]) {
            Set-Content -Path $unresolvedPath -Value $toExport -AsByteStream
        } else {                        
            $toExport > $unresolvedPath
        }
        if ($?) {
            Get-Item -Path $unresolvedPath
        }
    }
}
