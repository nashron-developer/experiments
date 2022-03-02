import Foundation
import PlaygroundHelpers

let array = [1, 1, 2, 3, 1, 4, 2, 3, 3, 3]

let set = Set(array)


var result = [Int:Int]()
let d = duration {
    array.forEach { (element) in
        result[element] = (result[element] ?? 0) + 1
    }
}
print("#1: \(result.sorted { $0 < $1 })\n#1: \(d)")

var result2 = [Int:Int]()
let d2 = duration {
    array.forEach { (element) in
        if result2[element] != nil {
            result2[element]! += 1
        } else {
            result2[element] = 1
        }
    }
}
print("#2: \(result2.sorted { $0 < $1 })\n#2: \(d2)")

var result3 = [Int:Int]()
var set2 = Set<Int>()
let d3 = duration {
    array.forEach { element in
        result3[element] = set2.insert(element).inserted ? 1 : result3[element]! &+ 1
    }
}
set2
print("#3: \(result3.sorted { $0 < $1 })\n#3: \(d3)")

var result35 = [Int:Int]()
var set25 = Set<Int>()
let d35 = duration {
    array.forEach { element in
        result35[element] = set25.insert(element).inserted ? 1 : result35[element]! &+ 1
    }
}
set25
print("#3.5: \(result35.sorted { $0 < $1 })\n#3.5: \(d35)")


var result4 = [Int:Int]()
let d4 = duration {
    for element in array {
        guard result4[element] == nil else { continue }
        result4[element] = array.filter { $0 == element }.count
    }
}
print("#4: \(result4.sorted { $0 < $1 })\n#4: \(d4)")

   
var result5 = [Int:Int]()
let d5 = duration {
    for element in array {
        guard result5[element] == nil else { continue }
        result5[element] = array.reduce(0, { $0 + ($1 == element ? 1 : 0) })
    }
}
print("#5: \(result5.sorted { $0 < $1 })\n#5: \(d5)")

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

var result6 = [Int:Int]()
let d6 = duration {
    var incrementers = [Int:()->Int]()
    array.forEach { element in
        if incrementers[element] == nil {
            incrementers[element] = makeIncrementer(forIncrement: 1)
        }
        result6[element] = incrementers[element]!()
    }
}
print("#6: \(result6.sorted { $0 < $1 })\n#6: \(d6)")
print()

final class Solution {
    func countCouples(array: [Int]) -> Int {
//        var set = Set<Int>()
//        var result = [Int:Int]()
//        array.forEach { result[$0] = set.insert($0).inserted ? 1 : result[$0]! + 1 }
//        return result.values.map { Int((Double($0) / 2).rounded(.down)) }.reduce(0) { $0 + $1 }
        
//        var temp = Set<Int>()
//        var couples = 0
//        array.forEach { element in
//            if !temp.insert(element).inserted {
//                couples += 1
//                temp.remove(element)
//            }
//        }
//        return couples
    
        var temp = [Int]()
        var couples = 0
        array.forEach { element in
            if temp.contains(element) {
                couples += 1
                temp.remove(at: temp.firstIndex(of: element)!)
            } else {
                temp.append(element)
            }
        }
        return couples
    }
}

final class TestCases {
    private let solution = Solution()
    
    func test1() -> Bool {
        return solution.countCouples(array: [10,20,20,10,10,30,50,10,20]) == 3
    }
    
    func test2() -> Bool {
        return solution.countCouples(array: [0,1,2,1,2,1,1,2]) == 3
    }
    
    func test3() -> Bool {
        return solution.countCouples(array: [0,0,0,1,1,1,1,2,2,2]) == 4
    }
}

let testCases = TestCases()
duration {
    print (testCases.test1())
}
duration {
    print (testCases.test2())
}
duration {
    print (testCases.test3())
}
