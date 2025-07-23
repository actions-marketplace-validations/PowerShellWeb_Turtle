param(
[double]
$Heading
)

$this |  Add-Member -MemberType NoteProperty -Force -Name '.TurtleHeading' -Value $Heading
