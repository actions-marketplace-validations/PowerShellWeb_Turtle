param([string]$value)

$this | Add-Member -MemberType NoteProperty -Force -Name '.StrokeThickness' -Value $value