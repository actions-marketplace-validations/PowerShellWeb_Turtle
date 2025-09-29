<#
.SYNOPSIS
    Pops the Turtle Stack
.DESCRIPTION
    Pops the Turtle back to the last location and heading in the stack.    

    By pushing and popping, we can draw multiple branches.
.EXAMPLE
    # Draws a T shape by pushing and popping
    turtle rotate -90 forward 42 push rotate 90 forward 21 pop rotate -90 forward 21 show
#>
if ($this.'.Stack' -isnot [Collections.Stack]) { return }

if ($this.'.Stack'.Count -eq 0) { return }

$popped = $this.'.Stack'.Pop()
$null = $this.PenUp().Goto($popped.Position.X, $popped.Position.Y).PenDown()
$this.Heading = $popped.Heading
return $this