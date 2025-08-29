param(
[uri]
$RepositoryUrl = "https://github.com/PowerShellWeb/Turtle"
)
if ($PSScriptRoot) { Push-Location $PSScriptRoot}
(Get-ChildItem -Path ../CHANGELOG.md | 
    ConvertFrom-Markdown |
    Select-Object -ExpandProperty HTML) -replace '(?<=[\(\,)]\s{0,})\#\d+', {
        $match = $_                
        if ($RepositoryUrl) {            
            "<a href='$RepositoryUrl/issues/$($match -replace '\#')>"
            "$match"
            "</a>"
        } else {
            "$match"
        }        
    }
if ($PSScriptRoot) { Pop-Location}
