<#
.SYNOPSIS
    Draws a L-system pattern.
.DESCRIPTION
    Generates a pattern using a L-system.

    The initial string (Axiom) is transformed according to the rules provided for a specified number of iterations.    
.LINK
    https://en.wikipedia.org/wiki/L-system
.EXAMPLE        
    # Box Fractal L-System
    $Box = 'F-F-F-F'
    $Fractal = 'F-F+F+F-F'
    
    $turtle.Clear().LSystem(
            $Box, 
            [Ordered]@{ F = $Fractal },
            3, 
            @{
                F = { $this.Forward(10) }
                J = { $this.Jump(10) }
                '\+' = { $this.Rotate(90) }            
                '-' = { $this.Rotate(-90) }
            }
    ).Pattern.Save("$pwd/BoxFractalLSystem.svg")
.EXAMPLE
    # Fractal L-System
    $Box = 'FFFF-FFFF-FFFF-FFFF' 
    $Fractal = 'F-F+F+F-F'
        
    $turtle.Clear().LSystem(
            $Box, 
            [Ordered]@{ F = $Fractal },
            4, 
            @{
                F = { $this.Forward(10) }
                J = { $this.Jump(10) }
                '\+' = { $this.Rotate(90) }            
                '-' = { $this.Rotate(-90) }
            }
    ).Symbol.Save("$pwd/FractalLSystem.svg")
.EXAMPLE
    # Arrowhead Fractal L-System
    $Box = 'FF-FF-FF' 
    $Fractal = 'F-F+F+F-F'
    
    
    $turtle.Clear().LSystem(
            $Box, 
            [Ordered]@{ F = $Fractal },
            4, 
            @{
                F = { $this.Forward(10) }
                J = { $this.Jump(10) }
                '\+' = { $this.Rotate(90) }            
                '-' = { $this.Rotate(-90) }
            }
    ).Pattern.Save("$pwd/ArrowheadFractalLSystem.svg")
.EXAMPLE
    # Tetroid LSystem
    $turtle.Clear().LSystem(
            'F', 
            [Ordered]@{ F = 'F+F+F+F' + 
                '+JJJJ+' + 
                'F+F+F+F' + 
                '++JJJJ' +
                'F+F+F+F' +
                '++JJJJ' +
                'F+F+F+F' +
                '++JJJJ' + 
                '-JJJJ'
            },                
            3, 
            @{
                F = { $this.Forward(10) }
                J = { $this.Jump(10) }
                '\+' = { $this.Rotate(90) }            
                '-' = { $this.Rotate(-90) }
            }
    ).Pattern.Save("$pwd/TetroidLSystem.svg")

.EXAMPLE
    $turtle.Clear().LSystem(
        'F', 
        [Ordered]@{ F = '
F+F+F+F +JJJJ+ F+F+F+F ++ JJJJ' },
        3, 
        @{
            F = { $this.Forward(10) }
            J = { $this.Jump(10) }
            '\+' = { $this.Rotate(90) }            
            '-' = { $this.Rotate(-90) }
        }
    ).Pattern.Save("$pwd/LSystemCool1.svg")
.EXAMPLE
    Move-Turtle LSystem F-F-F-F ([Ordered]@{F='F-F+F+F-F'}) 3 (
        [Ordered]@{
            F = { $this.Forward(10) }
            J = { $this.Jump(10) }
            '\+' = { $this.Rotate(90) }            
            '-' = { $this.Rotate(-90) }
        }
    )
    
#>
param(
[Alias('Start', 'StartString', 'Initiator')]
[string]
$Axiom,

[Alias('Rules', 'ProductionRules')]
[Collections.IDictionary]
$Rule = [Ordered]@{},

[Alias('Iterations', 'IterationCount', 'N', 'Steps','StepCount')]
[int]
$Order = 2,

[Collections.IDictionary]
$Variable = @{}
)

$currentState = "$Axiom"
if ($Order -ge 1) {
    $combinedPattern = "(?>$($Rule.Keys -join '|'))"
    foreach ($iteration in 1..$Order) {
        $currentState = $currentState -replace $combinedPattern, {
            $match = $_
            $matchingRule = $rule["$match"]
            if ($matchingRule -is [ScriptBlock]) {
                return "$(. $matchingRule $match)"
            } else {
                return $matchingRule
            }
        }    
    }        
}

$localReplacement = [Ordered]@{}
foreach ($key in $variable.Keys) {
    $localReplacement[$key] = 
        if ($variable[$key] -is [ScriptBlock]) {
            [ScriptBlock]::Create($variable[$key])
        } else {
            $variable[$key]
        }
}

$finalState = $currentState

$this.PathAttribute = [Ordered]@{
    "data-l-order" = $Order
    "data-l-axiom" = $Axiom
    "data-l-rules" = ConvertTo-Json $Rule 
    "data-l-expanded" = $finalState
}

$MatchesAny = "(?>$($variable.Keys -join '|'))"
$allMatches = @([Regex]::Matches($finalState, $MatchesAny, 'IgnoreCase,IgnorePatternWhitespace'))
$matchCache = @{}
:nextMatch foreach ($match in $allMatches) {
    $m = "$match"
    if (-not $matchCache[$m]) {
        foreach ($key in $Variable.Keys) {
            if (-not ($match -match $key)) { continue }
            # if ($variable[$key] -isnot [ScriptBlock]) { continue }
            $matchCache[$m] = $localReplacement[$key]
            break
        }    
    }
    
    if ($matchCache[$m] -is [ScriptBlock]) {
        $Orderull =  . $matchCache[$m] $match
        continue nextMatch
    }
}

return $this
