<#
.SYNOPSIS
    `Turtle.js` definition
.DESCRIPTION
    Our JavaScipt turtle is actually contained in a PowerShell object first.

    This object has a number of properties ending with `.js`.
    
    These are portions of the class.

    To create our class, we simply join these properties together, and output a javascript object.
#>
param()



@(

# Since we are building a javascript object, we need to wrap everything in curly braces
"{
"
# Indentation does not matter to most machines, but people tend to appreciate it.
"  "
@(foreach ($javaScriptProperty in $this.psobject.properties | Sort-Object Name) {
    # We only want the .js properties
    if ($javaScriptProperty.Name -notmatch '\.js$') { continue }
    # If the property is a function, we need to handle it differently
    if ($javaScriptProperty.value -match '^function.+?\(') {
        # specificically, we need to remove the "function " prefix from the name
        $predicate, $extra = $javaScriptProperty.value -split '\(', 2
        # and then we need to reassemble it as a javascript method
        $functionName = $predicate -replace 'function\s{1,}'
        "${functionName}:function ($extra"
    }
    else {
        # Otherwise, include it inline.
        $javaScriptProperty.value
    }
    
}) -join (',' + [Environment]::Newline + '  ')
"}") -join ''