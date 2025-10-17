function polygon(size, sides = 6) {    
    for (let side = 0; side < sides; side++) {
        turtle.forward(size).rotate(360/sides)
    }
}