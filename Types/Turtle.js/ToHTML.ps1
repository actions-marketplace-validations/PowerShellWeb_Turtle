<#
.SYNOPSIS
    A Tiny Turtle
.DESCRIPTION
    A minimal implementation of Turtle graphics in PowerShell and JavaScript, with and a speed test.
.EXAMPLE
    ./TinyTurtle.html.ps1 > ./TinyTurtle.html
#>
"<div>"
"<turtle>"
"<svg width='100%' height='100%' id='stage'>"
"<path id='turtle-path' fill='transparent' stroke='currentColor' stroke-width='1%' stroke-linecap='round'></path>"
"<text id='counter' font-size='12px' x='50%' y='50%' text-anchor='middle' dominant-baseline='middle'></text>"
"</svg>"
"</turtle>"
"<script>"

@"
let counter = 0;
let time = new Date()
function draw() {
    requestAnimationFrame(draw)

    let turtle = $this

    turtle.rotate(Math.random() * 360).polygon(100, 8)
    let turtleElement = document.querySelector('turtle')
    let svg = turtleElement.querySelector('#stage')
    svg.setAttribute('viewBox', ``0 0 `${turtle.width} `${turtle.height}``)
    let path = turtleElement.querySelector('#turtle-path')
    path.setAttribute('d', turtle.pathData())
    counter++

    document.getElementById('counter').textContent =
        ```${Math.round(counter/((new Date() - time)/1000)*100)/100} fps``
}
draw()
"@
"</script>"
"</div>"
