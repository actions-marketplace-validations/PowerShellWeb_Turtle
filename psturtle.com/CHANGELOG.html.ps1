param(
[uri]
$RepositoryUrl = "https://github.com/PowerShellWeb/Turtle",

[string]
$ChangeLogPath = '../CHANGELOG.md'
)
if ($PSScriptRoot) { Push-Location $PSScriptRoot}
"<style>"
".viewSource {float: right;}" 
"</style>"
"<details class='viewSource'>"
"<summary>View Source</summary>"
"<pre><code class='language-PowerShell'>"
[Web.HttpUtility]::HtmlEncode($MyInvocation.MyCommand.ScriptBlock)
"</code></pre>"
"</details>"
(Get-ChildItem -Path $ChangeLogPath | 
    ConvertFrom-Markdown |
    Select-Object -ExpandProperty HTML) -replace '(?<=[\(\,)]\s{0,})\#\d+', {
        $match = $_                
        if ($RepositoryUrl) {
            $issueNumber = $($match -replace '\#' -as [int])
            "<a href='$RepositoryUrl/issues/$issueNumber'>" + "#$issueNumber" + "</a>"
        } else {
            "$match"
        }        
    }
if ($PSScriptRoot) { Pop-Location}
