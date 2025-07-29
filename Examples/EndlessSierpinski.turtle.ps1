#requires -Module Turtle

$turtle = turtle SierpinskiTriangle 25 5 
$turtle.PatternTransform = @{    
    scale = 0.8
}
$turtle.PatternAnimation += "
<animateTransform attributeName='patternTransform' attributeType='XML' type='scale' values='0.66;0.33;0.66' dur='19s' repeatCount='indefinite' additive='sum' />
"

$turtle.PatternAnimation += "
<animateTransform attributeName='patternTransform' attributeType='XML' type='rotate' from='0' to='360' dur='29s' repeatCount='indefinite' additive='sum' />
"

$turtle.PatternAnimation += "
"

$turtle.PatternAnimation += "
<animateTransform attributeName='patternTransform' attributeType='XML' type='skewY' values='45;-45;45' dur='67s' repeatCount='indefinite' additive='sum' />
"

$turtle.PatternAnimation += "
<animateTransform attributeName='patternTransform' attributeType='XML' type='translate' values='0 0;42 42;0 0' dur='89s' repeatCount='indefinite' additive='sum' />
"

$turtle | 
    Save-Turtle -Path "$pwd/EndlessSierpinskiTrianglePattern.svg" -Property Pattern

