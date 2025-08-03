## Turtle 0.1.2:

* `Get-Turtle/Turtle` can now get or set properties or methods
* New Methods:
  * `Turtle.Distance()` determines the distance to a point
  * `Turtle.Towards()` determines the angle to a point
  * `Turtle.Home()` sends the turtle to 0,0
  * `Turtle.lt/rt` aliases help original Logo compatibility
  * `Turtle.Save()` calls Save-Turtle
* Explicitly exporting commands from module

## Turtle 0.1.1:

* Updates:
  * `Turtle.get/set_ID` allows for turtle identifiers
  * `Turtle.ToString()` stringifies the SVG  
* Fixes:
  * Fixing GoTo/Teleport (#90)
  * Fixing Position default (#85) (thanks @ninmonkey !)
  * Fixing Turtle Action ID (#89)
* New:
  * `Turtle.Push()` pushes position/heading to a stack (#91)
  * `Turtle.Pop()` pops position/heading from a stack (#92)
  * `Turtle.get_Stack` gets the position stack (#93)
* New Fractals:
  * `BinaryTree()` (#94)
  * `FractalPlant()` (#95)

---

## Turtle 0.1:

* Initial Release
* Builds a Turtle Graphics engine in PowerShell
* Core commands
  * `Get-Turtle` (alias `turtle`) runs multiple moves
  * `New-Turtle` create a turtle
  * `Move-Turtle` performas a single move
  * `Set-Turtle` changes a turtle
  * `Save-Turtle` saves a turtle

~~~PowerShell
turtle Forward 10 Rotate 120 Forward 10 Roate 120 Forward 10 Rotate 120 |
    Set-Turtle Stroke '#4488ff' |
    Save-Turtle ./Triangle.svg
~~~

* Core Object
  * `.Heading` controls the turtle heading
  * `.Steps` stores a list of moves as an SVG path
  * `.IsPenDown` controls the pen
  * `.Forward()` moves forward at heading
  * `.Rotate()` rotates the heading
  * `.Square()` draws a square
  * `.Polygon()` draws a polygon
  * `.Circle()` draws a circle (or partial circle)
* LSystems
  * Turtle can draw a L system.  Several are included:
    * `BoxFractal`
    * `GosperCurve`
    * `HilbertCurve`
    * `KochCurve`
    * `KochIsland`
    * `KochSnowflake`
    * `MooreCurve`
    * `PeanoCurve`
    * `SierpinskiTriangle`
    * `SierpinskiCurve`
    * `SierpinskiSquareCurve`
    * `SierpinskiArrowheadCurve`
    * `TerdragonCurve`
    * `TwinDragonCurve`
       
~~~PowerShell
turtle SierpinskiTriangle 10 4 |
    Set-Turtle Stroke '#4488ff' |
    Save-Turtle ./SierpinskiTriangle.svg    
~~~

