
param(
    [double]$Size = 20,
    [int]$Order = 4,
    [double]$Angle = 90
)
return $this.L('F-F-F-F',  [Ordered]@{
    F = 'F-F+F+F-F'
}, $Order, [Ordered]@{
    '\+'    = { $this.Rotate($Angle) }
    '-'     = { $this.Rotate($Angle * -1) }
    'F'     = { $this.Forward($Size) }
})

