param(
    [double]$Size = 10,
    [double]$Rotation = 90,
    [int]$Order = 4
)    
return $this.LSystem('F',  @{
    F = 'F+F-F-F+F'
}, $Order, [Ordered]@{
    '\+' = { $this.Rotate($Rotation) }
    'F' =  { $this.Forward($Size) }    
    '\-' = { $this.Rotate($Rotation * -1) }
})