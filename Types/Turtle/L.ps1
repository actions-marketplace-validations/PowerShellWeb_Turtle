param(
[Alias('Start', 'StartString', 'Initiator')]
[string]
$Axiom,

[Alias('Rules', 'ProductionRules')]
[Collections.IDictionary]
$Rule = [Ordered]@{},

[Alias('Iterations', 'Steps', 'IterationCount','StepCount')]
[int]
$N = 2,

[Collections.IDictionary]
$Variable = @{}
)

if ($n -le 1) { return $Axiom}

$currentState = "$Axiom"
$combinedPattern = "(?>$($Rule.Keys -join '|'))"    
foreach ($iteration in 1..$n) {
    $currentState = $currentState -replace $combinedPattern, {
        $match = $_
        $matchingRule = $rule["$match"]
        if ($matchingRule -is [ScriptBlock]) {
            return "$(& $matchingRule $match)"
        } else {
            return $matchingRule
        }
    }    
}

$finalState = $currentState
foreach ($character in $finalState.ToCharArray()) {
    foreach ($key in $Variable.Keys) {
        if ($character -match $key) {
            $action = $Variable[$key]
            if ($action -is [ScriptBlock]) {
                . $action $character
            } else {
                $action
            } 
        }
    }
}
return $this
