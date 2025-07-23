param(
[string[]]
$Steps
)

$this |  Add-Member -MemberType NoteProperty -Force -Name '.Steps' -Value $Steps
