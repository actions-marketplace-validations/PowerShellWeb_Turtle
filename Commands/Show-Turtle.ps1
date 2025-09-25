function Show-Turtle
{
    <#
    .SYNOPSIS
        Shows a Turtle
    .DESCRIPTION
        Shows a Turtle by opening it with the default file association.
    .NOTES
        It is highly recommended that you show turtles in a browser;
        not all drawing programs support the full capabilities of SVG.        
    #>
    [CmdletBinding(PositionalBinding=$false)]
    param(
    # The input object to show.
    # This should be a turtle, or a file a .svg,
    [Parameter(ValueFromPipeline)]
    [PSObject]
    $InputObject
    )

    begin {
        $validExtensions = @(
            '.svg',
            '.png',
            '.webp',
            '.jpe?g',
            '.html?'
        )
        $extensionPattern = "(?>$($validExtensions -replace '\.','\.' -join '|'))$"
    }
    process {
        if ($InputObject -is [IO.FileInfo] -and $InputObject.Extension -match $extensionPattern) {
            Invoke-Item $InputObject.Fullname
        } elseif ($InputObject.pstypenames -contains 'Turtle') {            
            New-Item -ItemType File -Path "./$($InputObject.id).svg" -Value "$InputObject" -Force |
                Invoke-Item
        } 
        elseif ($InputObject -is [string] -and $InputObject -match $extensionPattern) {
            $gotItem = Get-Item -Path $InputObject
            if ($gotItem) {
                Invoke-Item $gotItem.FullName
            }
        }
        else {
            Write-Error "Nothing to see here"
        }     
    }
}
