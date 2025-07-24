$this.Position = 0, 0
$this.Heading = 0
$this.Steps = @()
$this | Add-Member -MemberType NoteProperty -Force -Name '.Minimum' -Value ([pscustomobject]@{ X = 0; Y = 0 })
$this | Add-Member -MemberType NoteProperty -Force -Name '.Maximum' -Value ([pscustomobject]@{ X = 0; Y = 0 })
$this.ViewBox = 0
return $this