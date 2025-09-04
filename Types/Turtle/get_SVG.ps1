param()
@(
"<svg xmlns='http://www.w3.org/2000/svg' viewBox='$($this.ViewBox)' transform-origin='50% 50%' width='100%' height='100%'>"
    # Output our own path
    $this.PathElement.OuterXml
    # Followed by any text elements
    $this.TextElement.OuterXml

    # If the turtle has children
    $children = @(foreach ($turtleName in $this.Turtles.Keys) {
        # make sure they're actually turtles
        if ($this.Turtles[$turtleName].pstypenames -notcontains 'Turtle') { continue }
        # and then set their IDs
        $childTurtle = $this.Turtles[$turtleName]
        $childTurtle.ID = "$($this.ID)-$turtleName"
        $childTurtle
    })
    # If we have any children
    if ($children) {
        # put them in a group containing their children
        "<g id='$($this.ID)-children'>"            
            foreach ($child in $children) {
                # and ask for this child's inner XML
                # (which would contain any of its children) 
                # (and their children's children)
                # and so on.
                $child.SVG.SVG.InnerXML                
            }
        "</g>"
    }
"</svg>"
) -join '' -as [xml]