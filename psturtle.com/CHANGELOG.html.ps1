if ($PSScriptRoot) { Push-Location $PSScriptRoot}
Get-ChildItem -Path ../CHANGELOG.md | 
    ConvertFrom-Markdown |
    Select-Object -ExpandProperty HTML
if ($PSScriptRoot) { Pop-Location}
