import Foundation
import PlaygroundHelpers
/**
 Write a function, persistence, that takes in a positive parameter num and returns its multiplicative persistence, which is the number of times you must multiply the digits in num until you reach a single digit.

 For example:

  persistence(for: 39) === 3 // because 3*9 = 27, 2*7 = 14, 1*4=4
                        // and 4 has only one digit
                  
  persistence(for: 999) === 4 // because 9*9*9 = 729, 7*2*9 = 126,
                         // 1*2*6 = 12, and finally 1*2 = 2
                   
  persistence(for: 4) === 0 // because 4 is already a one-digit number
 */

//MARK: - Solution

func persistence(for num: Int) -> Int {
    var numbers = String(num)
    var count = 0
    while numbers.count > 1 {
        count += 1
        numbers = String(numbers.reduce(1) { $0 * (Int(String($1)) ?? 1) })
    }
    return count
}

//MARK: - Just compare with other solutions

func persistence2(for num: Int) -> Int {
    let digits: [Int] = String(num).compactMap { Int(String($0)) }
    return digits.count == 1 ? 0 : 1 + persistence(for: digits.reduce(1, *))
}

func persistence3(for num: Int) -> Int {
    let stringNumber = String(num)
    guard stringNumber.count > 1 else { return 0 }
    let nextNumberToCheck = stringNumber.reduce(1) { $0 * Int(String($1))! }
    return 1 + persistence(for: nextNumberToCheck)
}

duration { // 0.0048
    persistence(for: 999999999999999999)
}

duration { // 0.2042
    persistence2(for: 999999999999999999)
}

duration { // 0.2030
    persistence3(for: 999999999999999999)
}

//MARK: - Tests

import XCTest

class SolutionTest: XCTestCase {

    func testPersistence() {
        XCTAssertEqual(persistence(for: 18), 1)
    }

    func testPersistenceAgain() {
        XCTAssertEqual(persistence(for: 28), 2)
    }
    
    func testPersistence1() {
        XCTAssertEqual(persistence(for: 39), 3)
    }
    
    func testPersistence2() {
        XCTAssertEqual(persistence(for: 999), 4)
    }
    
    func testPersistence3() {
        XCTAssertEqual(persistence(for: 4), 0)
    }
    
}

SolutionTest.defaultTestSuite.run()
