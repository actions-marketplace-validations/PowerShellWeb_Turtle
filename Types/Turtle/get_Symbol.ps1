param()

@(    
    "<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%'>"
        "<symbol id='turtle-symbol' viewBox='$($this.ViewBox)' transform-origin='50% 50%'>"
            $this.PathElement.OuterXml
        "</symbol>"
        "<use href='#turtle-symbol' width='100%' height='100%' />"
    "</svg>"
) -join '' -as [xml]