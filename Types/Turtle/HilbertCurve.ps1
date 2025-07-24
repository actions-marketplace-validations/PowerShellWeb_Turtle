param(
    [double]$Size = 10,
    [int]$Order = 5,
    [double]$Angle = 90
)        
$this.L('A',  @{
    A = '+BF-AFA-FB+'
    B = '-AF+BFB+FA-'
}, $Order, @{
    'F'     = { $this.Forward($Size) }
    '\+'    = { $this.Rotate($Angle) }
    '\-'    = { $this.Rotate($Angle * -1) }
})
return $this