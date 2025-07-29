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
    <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" transform-origin="50% 50%"><symbol id="turtle-symbol" viewBox="0 0 10 10" transform-origin="50% 50%"><path id="turtle-path" d="m 0 0  l 10 0 l 0 10 l -10 0 l -0 -10" stroke="#4488ff" stroke-width="0.5%" fill="transparent" class="foreground-stroke" /></symbol><use href="#turtle-symbol" width="100%" height="100%" transform-origin="50% 50%" /></svg>
</div>
![Turtle Square]()

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
![Turtle Hexagon](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHRyYW5zZm9ybS1vcmlnaW49IjUwJSA1MCUiPjxzeW1ib2wgaWQ9InR1cnRsZS1zeW1ib2wiIHZpZXdCb3g9IjAgMCAyMCAxNy4zMjA1MDgwNzU2ODg4IiB0cmFuc2Zvcm0tb3JpZ2luPSI1MCUgNTAlIj48cGF0aCBpZD0idHVydGxlLXBhdGgiIGQ9Im0gNSAwICBsIDEwIDAgbCA1IDguNjYwMjU0MDM3ODQ0MzkgbCAtNSA4LjY2MDI1NDAzNzg0NDM5IGwgLTEwIDAgbCAtNSAtOC42NjAyNTQwMzc4NDQzOCBsIDUgLTguNjYwMjU0MDM3ODQ0MzkiIHN0cm9rZT0iIzQ0ODhmZiIgc3Ryb2tlLXdpZHRoPSIwLjUlIiBmaWxsPSJ0cmFuc3BhcmVudCIgY2xhc3M9ImZvcmVncm91bmQtc3Ryb2tlIiAvPjwvc3ltYm9sPjx1c2UgaHJlZj0iI3R1cnRsZS1zeW1ib2wiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHRyYW5zZm9ybS1vcmlnaW49IjUwJSA1MCUiIC8+PC9zdmc+)
![SierpinskiTriangle](./Examples/EndlessSierpinskiTrianglePattern.svg)

