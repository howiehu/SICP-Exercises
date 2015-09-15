import Cocoa

// Exercise 1.28
// One variant of the Fermat test that cannot be fooled is the Miller-Rabin test. This starts from an alternate form of Fermat's Little Theorem which states that

// if n is a prime number and a is any positive integer less than n then a raised to the (n - 1)st power is congruent to 1 modulo n

// To test the primality of a number n by the Miller-Rabin test, we 
// - pick random number a<n
// - raise a^(n - 1) % n
// However whenever we perform the squaring step in expmod we check to see if we have discovered a "nontrivial square root of 1 modulo n". That is a number not egual to 1 or n - 1 whose square is equal to 1 modulo n. If such a number exists then n is not prime. Also if n is an odd number that is not prime then at least half the numbers a<n computing a^n-1 this way will reveal a notrivial square root of 1 modulo n.


func isEven(n: Int) -> Bool {
    return (n % 2) == 0
}
func square(x: Int) -> Int {
    return x * x
}
func dividesWithNoRemainder(a: Int, b: Int) -> Bool {
    return  a % b == 0
}

func next(n: Int) -> Int {
    if n == 2 {
        return 3
    } else {
        return n + 2
    }
}

func findDivisor(n: Int, testDivisor: Int) -> Int {
    switch true {
    case square(testDivisor) > n:
        return n
    case dividesWithNoRemainder(n, b: testDivisor):
        return testDivisor
    default:
        return findDivisor(n, testDivisor: next(testDivisor))
    }
}

func smallestDivisor(n: Int) -> Int {
    return findDivisor(n, testDivisor: 2)
}

func isPrime(n:Int) -> Bool {
    return n == smallestDivisor(n)
}


func expMod(base: Int, exp: Int, m: Int) -> Int {
    switch true {
    case exp == 0:
        return 1
    case isEven(exp):
        if isNonTrivialSQRT(expMod(base, exp: exp / 2, m: m), m: m) {
            return 0
        } else {
            return square(expMod(base, exp: exp / 2, m: m)) % m
        }
    default:
        return (base * expMod(base, exp: exp - 1, m: m)) % m
    }
}

func isNonTrivialSQRT(n: Int, m: Int) -> Bool {
    switch true {
    case n == 1:
        return false
    case n == (m - 1):
        return false
    default:
        return 1 == (square(n) % m)
    }
}

func millerRabinTest(n: Int) -> Bool {
    func tryIt(a: Int) -> Bool {
        return expMod(a, exp: n, m: n) == a
    }
    let randomA:Int = Int(arc4random_uniform(UInt32(n - 1)) + 1)
    return tryIt(randomA)
}

func isFastPrime(n: Int, times: Int) -> Bool {
    switch true {
    case times == 0:
        return true
    case millerRabinTest(n):
        return isFastPrime(n, times: times - 1)
    default:
        return false
    }
}

//isFastPrime(13, 10)
//isFastPrime(561, 10)

//isFastPrime(561 10)
//isFastPrime(1105, 10)
//isFastPrime(1729, 10)
//isFastPrime(2465, 10)
//isFastPrime(2821, 10)
//isFastPrime(6601, 10)
isFastPrime(6603, times: 10)


