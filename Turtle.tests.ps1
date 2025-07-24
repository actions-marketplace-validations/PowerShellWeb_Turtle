describe Turtle {
    it "Draws things with simple commands" {
        $null = $turtle.Clear().Square()
        $turtleSquaredPoints = $turtle.Points       
        $turtleSquaredPoints.Length | Should -Be 8
        $turtleSquaredPoints | 
            Measure-Object -Sum | 
            Select-Object -ExpandProperty Sum | 
            Should -Be 0
    } 

    it 'Can draw an L-system, like a Sierpinski triangle' {
        $turtle.Clear().SierpinskiTriangle(200, 2, 120).points.Count |
            Should -Be 54
    }
}
