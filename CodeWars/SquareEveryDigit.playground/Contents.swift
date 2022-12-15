/**
 Welcome. In this kata, you are asked to square every digit of a number and concatenate them.
 
 For example, if we run 9119 through the function, 811181 will come out, because 92 is 81 and 12 is 1.
 
 Note: The function accepts an integer and returns an integer
 */

import UIKit

func squareDigits(_ num: Int) -> Int {
    let resultString: String = String(num)
        .map { digitString in
            let digit = NSDecimalNumber(string: String(digitString)).doubleValue
            return digit.isNormal ? String(Int(pow(digit, 2))) : ""
        }.joined()
    guard let result = Int(resultString) else { return 0 }
    return result
}

import XCTest

class SolutionTest: XCTestCase {
    
    func testExample() {
        XCTAssertEqual(squareDigits(9119), 811181)
        XCTAssertEqual(squareDigits(0), 0)
    }
    
}

SolutionTest.defaultTestSuite.run()
