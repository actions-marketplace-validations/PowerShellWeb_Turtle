param(
    [double]$Size = 200,
    [int]$Order = 2,
    [double]$Angle = 120
)        
$this.L('F-G-G',  [Ordered]@{
    F = 'F-G+F+G-F'
    G = 'GG'
}, $Order, [Ordered]@{
    '\+'    = { $this.Rotate($Angle) }
    '-'     = { $this.Rotate($Angle * -1) }
    '[FG]'  = { $this.Forward($Size) }
})
