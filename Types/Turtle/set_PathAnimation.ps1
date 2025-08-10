param(
[PSObject]
$PathAnimation
)

$newAnimation = @(foreach ($animation in $PathAnimation) {
    if ($animation -is [Collections.IDictionary]) {
        $animationCopy = [Ordered]@{} + $animation
        if (-not $animationCopy['attributeType']) {
            $animationCopy['attributeType'] = 'XML'
        }
        if (-not $animationCopy['attributeName']) {
            $animationCopy['attributeName'] = 'transform'
        }
        if ($animationCopy.values -is [object[]]) {
            $animationCopy['values'] = $animationCopy['values'] -join ';'
        }

        $elementName = 'animate'
        if ($animationCopy['attributeName'] -eq 'transform') {
            $elementName = 'animateTransform'
        }
        
        "<$elementName $(
            @(foreach ($key in $animationCopy.Keys) {
                " $key='$([Web.HttpUtility]::HtmlAttributeEncode($animationCopy[$key]))'"
            }) -join ''
        )/>"
    }
    if ($animation -is [string]) {
        $animation
    }
})

$this | Add-Member -MemberType NoteProperty -Force -Name '.PathAnimation' -Value $newAnimation
