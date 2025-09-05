<#
.SYNOPSIS
    Attack and Evade
.DESCRIPTION
    Simple behavior modelling with Turtle.
.NOTES
    Imagine we have four carnivorous turtles and four turtles that don't want to be eaten.

    Each carnivorous turtle starts in a corner of a square.

    Each evader starts in the center.

    Each attacker will chase the evader.

    Each evader will run away at an angle (by default 90 degrees).
#>
param(
[double]
$SquareSize = 420,
[double]
$EvaderSpeed = (Get-Random -Min 1 -Max 5),
[double]
$AttackerSpeedRatio = ((1 + [Math]::Sqrt(5))/2),
[double]
$EvadeAngle = 90
)

if ($PSScriptRoot) { Push-Location $PSScriptRoot}

$midpoint = ($squareSize/2), ($squareSize/2)
$attackerSpeed = $evaderSpeed * $AttackerSpeedRatio # (1 + (Get-Random -Min 10 -Max 50)/50) # (Get-Random -Min 1 -Max 5)
$stepCount = $squareSize/2 * (1 + ([Math]::Abs($attackerSpeed - $evaderSpeed)))

$attackAndEvade = turtle square $squareSize turtles ([Ordered]@{
    a1 = turtle teleport 0 0 # stroke 'red' pathclass 'red-stroke' fill red
    a2 = turtle teleport $squareSize 0 # stroke 'yellow' pathclass 'yellow-stroke' fill yellow
    a3 = turtle teleport $squareSize $squareSize # stroke 'green' pathclass 'green-stroke' fill green
    a4 = turtle teleport 0 $squareSize # stroke 'blue' PathClass 'blue-stroke' fill blue
    e1 = turtle teleport $midpoint # stroke 'red' fill 'red'
    e2 = turtle teleport $midpoint # stroke 'yellow' fill 'yellow'
    e3 = turtle teleport $midpoint # stroke 'green' fill 'green'
    e4 = turtle teleport $midpoint # stroke 'blue' fill 'blue'
})



# Since all attackers and evaders start with equal distances, 
# when we have caught one we have caught them all.
:caughtEm foreach ($n in 1..$stepCount) {

    # Get the attacker turtles
    $attackers = $attackAndEvade.Turtles[@($attackAndEvade.Turtles.Keys -match '^a')]
    # Get the evading turtles
    $evaders = $attackAndEvade.Turtles[@($attackAndEvade.Turtles.Keys -match '^e')]

    for ($evaderNumber = 0; $evaderNumber -lt $evaders.Length; $evaderNumber++) {
        $thisTurtle = $evaders[$evaderNumber]
        $runningAwayFrom = $attackers[$evaderNumber % $attackers.Length]
        $null = $thisTurtle.Rotate(
            $thisTurtle.Towards($runningAwayFrom) + $evadeAngle # (Get-Random -Minimum 80 -Maximum 100)
        ).Forward($evaderSpeed)
    }
    
    for ($attackerNumber = 0; $attackerNumber -lt $attackers.Length; $attackerNumber++) {
        $thisTurtle = $attackers[$attackerNumber]
        $runningTowards = $evaders[$attackerNumber % $evaders.Length]
        $null = $thisTurtle.Rotate(
            $thisTurtle.Towards($runningTowards) # + (Get-Random -Minimum -10 -Maximum 10)
        ).Forward($attackerSpeed)
    }

    for ($attackerNumber = 0; $attackerNumber -lt $attackers.Length; $attackerNumber++) {
        $thisTurtle = $attackers[$attackerNumber]
        $runningTowards = $evaders[$attackerNumber]
        if ($thisTurtle.Distance($runningTowards) -le 1) {
            break caughtEm
        }
    }
}


$attackAndEvade | turtle save ./AttackAndEvade.svg
$attackAndEvade.Stroke = 'transparent'
$attackAndEvade | Save-Turtle ./AttackAndEvadePattern.svg Pattern

if ($PSScriptRoot) { Pop-Location}