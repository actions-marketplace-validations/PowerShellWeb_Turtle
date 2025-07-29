@{    
    # Version number of this module.
    ModuleVersion = '0.1'
    # Description of the module
    Description = "Turtles in a PowerShell"
    # Script module or binary module file associated with this manifest.
    RootModule = 'Turtle.psm1'
    # ID used to uniquely identify this module
    GUID = '71b29fe9-fc00-4531-82ca-db5d2630d72c'
    # Author of this module
    Author = 'James Brundage'    

    # Company or vendor of this module
    CompanyName = 'Start-Automating'
    # Copyright statement for this module
    Copyright = '2025 Start-Automating'
    # Type files (.ps1xml) to be loaded when importing this module
    TypesToProcess = @('Turtle.types.ps1xml')
    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()
    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    VariablesToExport = '*'
    AliasesToExport = '*'
    PrivateData = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = 'PowerShell', 'Turtle', 'SVG', 'Graphics', 'Drawing', 'L-System', 'Fractal'
            # A URL to the main website for this project.
            ProjectURI = 'https://github.com/PowerShellWeb/Turtle'
            # A URL to the license for this module.
            LicenseURI = 'https://github.com/PowerShellWeb/Turtle/blob/main/LICENSE'
            ReleaseNotes = @'
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

'@        
        }
    }

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}

