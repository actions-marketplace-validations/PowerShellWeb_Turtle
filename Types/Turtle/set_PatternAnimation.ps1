param(
[string]
$PatternAnimation
)

$this | Add-Member -MemberType NoteProperty -Force -Name '.PatternAnimation' -Value $PatternAnimation
