import Cocoa

// Exercise 1.46
// Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as iterative improvement. Iterative improvement says that to compute something we start with an initial guess for the answer, test if the guess is good enough, and otherwiseimprove the guess and continue the process using the improved guess as the new guess.

// Write a procedure iterativeImprovement that takes two procedures as arguments: a method for telling whether a guess is good enough and a method for improving a guess. IterativeImprovement should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough. 

func iterativeImprovement(isGoodEnough: (Double) -> Bool, improve: (Double) -> Double) -> (Double) -> Double {
    var iter: (Double) -> Double = { _ in return 0.0 }
    iter = { (guess: Double) -> Double in
        if isGoodEnough(guess) {
            return guess
        } else {
            return iter(improve(guess))
        }
    }
    return iter
}

// Rewrite the sqrt procedure from section 1.1.7 

func sqrt(x: Double) -> Double {
    func average(x: Double, y: Double) -> Double {
        return (x + y) / 2.0
    }
    func isGoodEnough(guess: Double) -> Bool {
        return abs(pow(guess, 2) - x) < 0.00001
    }
    
    func improve(guess: Double) -> Double {
        return average(guess, (x / guess))
    }
    let solver = iterativeImprovement(isGoodEnough, improve)
    return solver(x)
}
sqrt(2.0)
sqrt(64.0)


// Rewrite the fixedPoint procedure of section 1.3.3 in terms of iterativeImprovement.

func fixedPoint(f: (Double) -> Double, guess: Double) -> Double {
    func isGoodEnough(guess: Double) -> Bool {
        return abs(guess - f(guess)) < 0.00001
    }
    func improve(guess: Double) -> Double {
        return f(guess)
    }
    let solver = iterativeImprovement(isGoodEnough, improve)
    return solver(guess)
}
fixedPoint(cos, 1.0)
let aFixedPoint = fixedPoint({ (y:Double) -> Double in return sin(y) + cos(y) }, 1.0)
aFixedPoint


