import Cocoa

// Exercise 2.35
// The procedure accumulate-n is similar to accumulate except that it takes as its third argument a sequence of sequences, which are all assumed to have the same number of elements. It applies the designated accumulation procedure to combine all the first elements of the sequences, all the second elements of the sequences, and so on, and returns a sequence of the results. 
// For instance, if s is a sequence containing four sequences, ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), then the value of (accumulate-n + 0 s) should be the sequence (22 26 30). Fill in the missing expressions in the following definition of accumulate-n

func cons<A>(value: A, list: [A]) -> [A] {
    var newList = list
    newList.insert(value, atIndex: 0)
    return newList
}
func car<A>(list:[A]) -> A {
    return list[0]
}
func cdr<A>(list:[A]) -> [A] {
    return Array(list[1..<list.count])
}
func accumulate<A>(op: (A, A) -> A, initial: A, sequence: [A]) -> A {
    if sequence.isEmpty {
        return initial
    } else {
        return op(car(sequence), accumulate(op, initial: initial, sequence: cdr(sequence)))
    }
}

func accumulateN(op: (Int, Int) -> Int, initial: Int, sequence: [[Int]]) -> [Int] {
    if car(sequence).isEmpty {
        return []
    } else {
        return cons(accumulate(op, initial: initial, sequence: sequence.map(car)), list: accumulateN(op, initial: initial, sequence: sequence.map(cdr)))
    }
}

let 