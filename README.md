# Turtle

<div align='center'>
    <img src='./Examples/SierpinskiTriangle.svg' alt='SierpinskiTriangle' width='50%' />
</div>



## Turtles in a PowerShell

[Turtle Graphics](https://en.wikipedia.org/wiki/Turtle_graphics) are a great way to learn programming and describe shapes.

Turtle graphics start really simple.

Imagine we are a turtle dragging a pen.  

We can draw almost any shape by moving.

We can only really move in two ways:

We can turn, and we can take a step forward.

Turtle graphics starts with these two operations:

* Rotate() rotates the turtle
* Forward() moves forward

We can easily represent these steps in memory, and draw them within a webpage using SVG.

We can implement Turtle in any language.

This module implements Turtle in PowerShell.
### Installing and Importing

We can install Turtle from the PowerShell Gallery:

~~~PowerShell
Install-Module Turtle -Scope CurrentUser -Force
~~~

Then we can import it like any other module

~~~PowerShell
Import-Module Turtle -Force -PassThru
~~~

#### Cloning and Importing

You can also clone the repository and import the module

~~~PowerShell

git clone https://github.com/PowerShellWeb/Turtle
cd ./Turtle
Import-Module ./ -Force -PassThru

~~~
### Getting Started

Once we've imported Turtle, we can create any number of turtles, and control them with commands and methods.

#### Drawing Squares

<div align='center'>
    
    <img src='./Examples/Square.svg' alt='Square' width='50%' />
</div>


Let's start simple, by drawing a square.

~~~PowerShell

New-Turtle | 
    Move-Turtle Forward 10 |
    Move-Turtle Rotate 90 |
    Move-Turtle Forward 10 |
    Move-Turtle Rotate 90 |
    Move-Turtle Forward 10 |
    Move-Turtle Rotate 90 |
    Move-Turtle Forward 10 |
    Move-Turtle Rotate 90 |
    Save-Turtle "./Square.svg"

~~~

We can also write this using a method chain:

~~~PowerShell
$turtle = New-Turtle
$turtle.
    Forward(10).Rotate(90).
    Forward(10).Rotate(90).
    Forward(10).Rotate(90).
    Forward(10).Rotate(90).
    Symbol.Save("$pwd/Square.svg")
~~~

This just demonstrates how we can construct shapes out of these two simple primitive steps.
We can also just say, make a square directly:

~~~PowerShell
New-Turtle | Move-Turtle Square 10 | Save-Turtle ./Square.svg
~~~
We can use loops:

~~~PowerShell
$turtle = New-Turtle

foreach ($n in 1..6) {
    $turtle = $turtle.Forward(10).Rotate(60)
}

$turtle | 
    Save-Turtle "./Hexagon.svg" 
~~~
<div align='center'>

<img src='./Examples/Hexagon.svg' alt='Hexagon' width='50%' />
</div>
Because this Turtle generates SVG, we can also use it to create patterns.

~~~PowerShell

    turtle ('Forward', 10, 'Rotate', 60  * 6) | 
        Set-Turtle -Property Stroke '#4488ff' |
        Save-Turtle -Path ./Examples/HexagonPattern.svg -Property Pattern

~~~
<div align='center'>
<img src='./Examples/HexagonPattern.svg' alt='Hexagon Pattern' width='50%' />
</div>
![SierpinskiTriangle](./Examples/EndlessSierpinskiTrianglePattern.svg)

