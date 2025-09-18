<#
.SYNOPSIS
    Draws a pie graph using turtle graphics.
.DESCRIPTION
    This script uses turtle graphics to draw a pie graph based on the provided data.
.EXAMPLE
    turtle PieGraph 400 400 80 20 save ./80-20.svg
.EXAMPLE
    turtle PieGraph 400 400 5 10 15 20 15 10 5 | Save-Turtle ./PieGraph.svg
.EXAMPLE
    turtle width 400 height 400 PieGraph 400 400 @{value=20;fill='red'} @{value=40;fill='blue'} save ./PieGraphColor.svg   
.EXAMPLE
    turtle PieGraph 400 400 @(
        5,10,15,20,15,10,5 | Sort-Object -Descending
    ) | Save-Turtle ./PieGraphDescending.svg
.EXAMPLE
    turtle rotate (Get-Random -Max 360) PieGraph 400 400 @(
        5,10,15,20,15,10,5 | Sort-Object -Descending
    ) | Save-Turtle ./PieGraphDescendingRotated.svg
.EXAMPLE
    turtle PieGraph 200 200 (
        @(1..50) | 
            Get-Random -Count (Get-Random -Minimum 5 -Maximum 20)
    ) save ./RandomPieGraph.svg
.EXAMPLE
    $n = Get-Random -Min 5 -Max 10
    turtle width 200 height 200 morph @(
        turtle PieGraph 200 200 @(1..50 | Get-Random -Count $n)
        turtle PieGraph 200 200 @(1..50 | Get-Random -Count $n)
        turtle PieGraph 200 200 @(1..50 | Get-Random -Count $n)
    ) save ./RandomPieGraphMorph.svg
.EXAMPLE
    turtle PieGraph 200 200 (
        @(1..50;-1..-50) | 
            Get-Random -Count (Get-Random -Minimum 5 -Maximum 20)
    ) save ./RandomPieGraphWithNegative.svg
.EXAMPLE
    $randomNegativePie = turtle PieGraph 200 200 (
            @(1..50;-1..-50) | 
                Get-Random -Count 10
        )
    turtle width 200 height 200 morph @(
        $randomNegativePie
        turtle PieGraph 200 200 (
            @(1..50;-1..-50) | 
                Get-Random -Count 10
        )
        $randomNegativePie
    ) save ./RandomPieGraphWithNegativeMorph.svg
.EXAMPLE
    # Multiple pie graphs
    turtle PieGraph 400 (1,2,4,8,4,2,1) jump 800 rotate 180 PieGraph 400 (1,2,4,8,4,2,1) save ./pg.svg
#>
param(
# The radius of the bar graph
[double]$Radius,

# The points in the bar graph.  
# Each point will be turned into a relative number and turned into an equal-width bar.
[Parameter(ValueFromRemainingArguments)]
[PSObject[]]
$GraphData
)


# If there were no points, we are drawing nothing, so return ourself.
if (-not $GraphData) { return $this}

filter IsPrimitive {$_.GetType -and $_.GetType().IsPrimitive}

# To make a pie graph we need to know the total, and thus we need to make a couple of passes
[double]$Total = 0.0

$sliceObjects = [Ordered]@{}
$richSlices = $false
$Slices = @(
    $dataPointIndex = 0
    foreach ($dataPoint in $GraphData)
    {
        $sliceObjects["slice$($sliceObjects.Count)"] = $dataPoint
        # If the data point is a number (or other primitive data)
        if ($dataPoint | IsPrimitive)
        {
            $Total += $dataPoint # add it to the total
            $dataPoint -as [double] # and output it
        }
        # Otherwise, if the data point has a value that is a number
        elseif ($dataPoint.value | IsPrimitive)
        {            
            $Total += $dataPoint.value # add it to the total
            $dataPoint.value -as [double] # and output that
            $richSlices = $true
        }
        elseif ($dataPoint -is [Collections.IDictionary]) {
            foreach ($key in $dataPoint.Keys) {
                if ($dataPoint[$key] | IsPrimitive) {
                    $Total += $dataPoint[$key] # add it to the total
                    $dataPoint[$key] -as [double] # and output that
                }
            }
            $richSlices = $true
        }
        elseif ($DataPoint -is 'Microsoft.PowerShell.Commands.GroupInfo') {
            $total += $dataPoint.Count
            $dataPoint.Count
            $richSlices = $true
        }
    }
)

# Turn each numeric slice into a ratio
$relativeSlices =
    foreach ($slice in $Slices) { $slice/ $total }

# If we have no ratios, we have nothing to graph, and we are done here.
if (-not $relativeSlices) { return $this }

# Next let's figure out the maximum delta x and delta y
$dx = $this.X + $Radius
$dy = $this.Y + $Radius
# and resize our viewbox with respect to our radius
$null = $this.ResizeViewBox($Radius)

# If we are not rendering "rich" slices, we can draw the arcs as one path
if (-not $richSlices) {
    # and we do not need to teleport
    for ($sliceNumber =0 ; $sliceNumber -lt $Slices.Length; $sliceNumber++) {
        # Turn each ratio into an angle        
        $Angle = $relativeSlices[$sliceNumber] * 360        
        $this = $this. 
                # Draw an arc of that angle,
                CircleArc($Radius, $Angle).
                # then rotate by the angle.
                Rotate($angle)
    }
}
else {
    # Otherwise, we are making multiple turtles    
    $nestedTurtles = [Ordered]@{}
    # The idea is the same, but the implementation is more complicated
    $heading = $this.Heading
    if (-not $heading) { $heading = 0.0 }    
    # Calulate the midpoint of the circle
    $midX = $this.X + ($dx - $this.X)/2
    $midY = $this.Y + ($dy - $this.Y)/2
    for ($sliceNumber =0 ; $sliceNumber -lt $Slices.Length; $sliceNumber++) {
        $Angle = $relativeSlices[$sliceNumber] * 360
        $sliceName = "slice$sliceNumber"        
        # created a nested turtle at the midpoint
        $nestedTurtles["slice$sliceNumber"] = turtle teleport $this.X $this.Y 
        # with the current heading
        $nestedTurtles["slice$sliceNumber"].Heading = $this.Heading
        # and arc by the angle
        $null = $nestedTurtles["slice$sliceNumber"].CircleArc($Radius, $Angle)

        # If the slice was of a dictionary
        if ($sliceObjects[$sliceName] -is [Collections.IDictionary])
        {
            # set any settable properties on the turtle
            foreach ($key in $sliceObjects[$sliceName].Keys) {
                # that exist in both the turtle and the dictionary
                if ($nestedTurtles[$sliceName].psobject.properties[$key].SetterScript) {
                    $nestedTurtles[$sliceName].$key = $sliceObjects[$sliceName][$key]
                }
            }
        }
        # If the slice was not a string
        elseif ($sliceObjects[$sliceName] -isnot [string])
        {
            # Set any settable properties on the turlte
            foreach ($property in $sliceObjects[$sliceName].Keys) {
                # that exist in both the turtle and the slice object.
                if ($nestedTurtles[$sliceName].psobject.properties[$key].SetterScript) {
                    $nestedTurtles[$sliceName].$key = $sliceObjects[$sliceName][$key]
                }
            }
        }
        
        # Now rotate our own heading, even though we are not drawing anything.
        $null = $this.Rotate($angle)
    }
    # and set our nested turtles.
    $this.Turtles = $nestedTurtles
}
 
return $this