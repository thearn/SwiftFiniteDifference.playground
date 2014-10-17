// Finite difference experiments

import UIKit

var x : Double

func f(x: Double) -> Double {
    return 2*pow(x, 2) + x
    // derivative: 4x + 1
}

func g(x: Double) -> Double {
    return pow(x, 3)*sin(x)
    // derivative: x^3cos(x) + 3x^2 sin(x)
}

//------------------------

func derivative(f: Double -> Double) -> (Double -> Double) {
    let h: Double = 0.0001
    
    func _finite_difference(x:Double)->Double {
        return (f(x + h) - f(x - h)) / (2*h)
    }
    
    return _finite_difference
}

//------------------------

postfix operator ^ {}

postfix func ^(f : Double->Double) -> (Double -> Double) {
    return derivative(f)
}

//------------------------

func root(f : Double -> Double,
          rhs : Double = 0.0,
          guess : Double = 1.0) -> Double {
        
    var x0 : Double = guess
    var xn : Double = 0
    var diff : Double = 10

    while abs(diff) > 0.000000001 {
        // take a Newton step
        xn = x0 - (f(x0) - rhs) / f^ (x0)
    
        // difference between steps for stopping criteria
        diff = xn - x0
    
        // update our guess
        x0 = xn
    }
    return x0
}

//------------------------

// some quick tests

// derivatives of f and g
f^ (3.5)
g^ (5)

// derivative of cos(x) = - sin(x)
cos^ (4.0)
-sin(4.0)

// derivative of e^x is itself
exp^ (10.0)
exp(10.0)

// derivative of log(x) is 1/x
log^ (25.0)
1/25.0


// some equation solving for x

// g(x) = 3
var solution = root(g, rhs : 3)
g(solution)

// f(x) = 10
solution = root(f, rhs : 10)
f(solution)

// e^x = 2014
solution = root(exp, rhs : 2014, guess : 3)
exp(solution)

// log(x) = 1
solution = root(log, rhs : 1) // answer is e
log(solution)

// sin(x) = 0, in the neighborhood of x = 3
solution = root(sin, rhs : 0, guess : 3) // answer is pi
sin(solution)






