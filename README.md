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

#### Drawing Simple Shapes

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

Or we could use a loop:

~~~PowerShell
$turtle = New-Turtle
foreach ($n in 1..4) {
    $turtle = $turtle.Forward(10).Rotate(90)
}
$turtle | Save-Turtle ./Square.svg
~~~

This just demonstrates how we can construct shapes out of these two simple primitive steps.

We can also just say, make a square directly:

~~~PowerShell
New-Turtle | Move-Turtle Square 10 | Save-Turtle ./Square.svg
~~~

We can use the same techniques to construct other shapes.

For example, this builds us a hexagon:

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
Turtle is often used to draw fractals.

Many fractals can be described in something called a [L-System](https://en.wikipedia.org/wiki/L-system) (short for Lindenmayer system)

L-Systems describe: 

* An initial state (called an Axiom)
* A series of rewriting rules
* The way each variable should be interpreted.

For example, let's show how we contruct the [Box Fractal](https://en.wikipedia.org/wiki/Vicsek_fractal)

Our Axiom is F-F-F-F.

This should look familiar:  it's a shorthand for the squares we drew earlier.

It basically reads "go forward, then left, four times"

Our Rule is F = 'F-F+F+F-F'.

This means every time we encounter F, we want to replace it with F-F+F+F-F.

This will turn our one box into 6 new boxes.  If we repeat it again, we'll get 36 boxes.  Once more and we're at 216 boxes.

Lets show the first three generations of the box fractal:

~~~PowerShell

    Turtle BoxFractal 5 1 |
    Set-Turtle Stroke '#4488ff' |
    Save-Turtle ./Examples/BoxFractal1.svg



    Turtle BoxFractal 5 2 |
    Set-Turtle Stroke '#4488ff' |
    Save-Turtle ./Examples/BoxFractal2.svg



    Turtle BoxFractal 5 3 |
    Set-Turtle Stroke '#4488ff' |
    Save-Turtle ./Examples/BoxFractal3.svg

~~~


<div align='center'>
<img src='./Examples/BoxFractal1.svg' alt='Box Fractal 1' width='50%' />
<img src='./Examples/BoxFractal2.svg' alt='Box Fractal 2' width='50%' />
<img src='./Examples/BoxFractal3.svg' alt='Box Fractal 3' width='50%' />
</div>
This implementation of Turtle has quite a few built-in fractals.

For example, here is an example of a pattern comprised of Koch Snowflakes:

~~~PowerShell

    turtle KochSnowflake 2.5 4 |     
        Set-Turtle -Property StrokeWidth '0.1%' | 
        Set-Turtle -Property Stroke '#4488ff' | 
        Set-Turtle -Property PatternTransform -Value @{scale = 0.5 } |
        Save-Turtle -Path ./Examples/KochSnowflakePattern.svg -Property Pattern

~~~
<div align='center'>
<img src='./Examples/KochSnowflakePattern.svg' alt='Snowflake Pattern' width='50%' />
</div>
We can also animate the pattern, for endless variety:

~~~PowerShell
$turtle = turtle KochSnowflake 10 4 | 
    Set-Turtle -Property PatternTransform -Value @{scale=0.33} |
    set-turtle -property Fill -value '#4488ff' |
    Set-Turtle -Property PatternAnimation -Value "

    <animateTransform attributeName='patternTransform' attributeType='XML' type='scale' values='0.66;0.33;0.66' dur='23s' repeatCount='indefinite' additive='sum' />

    <animateTransform attributeName='patternTransform' attributeType='XML' type='rotate' from='0' to='360' dur='41s' repeatCount='indefinite' additive='sum' />

    <animateTransform attributeName='patternTransform' attributeType='XML' type='skewX' values='30;-30;30' dur='83s' repeatCount='indefinite' additive='sum' />

    <animateTransform attributeName='patternTransform' attributeType='XML' type='skewY' values='30;-30;30' dur='103s' repeatCount='indefinite' additive='sum' />

    <animateTransform attributeName='patternTransform' attributeType='XML' type='translate' values='0 0;42 42;0 0' dur='117s' repeatCount='indefinite' additive='sum' />

    "
    


    
$turtle | save-turtle -Path ./EndlessSnowflake.svg -Property Pattern
Pop-Location
~~~
<div align='center'>
<img src='./Examples/EndlessSnowflake.svg' alt='Endless Snowflake Pattern' width='100%' />
</div>

### Turtles in a PowerShell Workflow

Turtle has a GitHub action, and can be run in a workflow.

To use the turtle action, simply refer to this repository:

~~~yaml
- name: UseTurtle
  uses: StartAutomating/Turtle@main
~~~

This will run any *.turtle.ps1 files found in your repository, and check in any files that have changed.

