<#
.SYNOPSIS
    Sets the Turtle Path Animation
.DESCRIPTION
    Sets an animation for the Turtle path.
#>
param(
# The definition object.
# This may be a string, XML, a dictionary containing defines, or an element
[PSObject]
$Defines
)

$newDefinition = @(foreach ($definition in $Defines) {
    if ($ -is [Collections.IDictionary]) {
        $definitionCopy = [Ordered]@{} + $definition                
        "<$elementName $(
            @(foreach ($key in $definitionCopy.Keys) {
                if ($key -eq 'Children') { continue }
                " $key='$([Web.HttpUtility]::HtmlAttributeEncode($definitionCopy[$key]))'"
            }) -join ''
        )$()>"
    }
    elseif ($definition -is [string]) {
        $definition
    }    
    elseif ($definition.OuterXml) {
        $definition.OuterXml
    }
    else {
        "$definition"
    }
})

$this | Add-Member -MemberType NoteProperty -Force -Name '.Defines' -Value $newDefinition
