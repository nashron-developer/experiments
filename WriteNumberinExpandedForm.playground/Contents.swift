import Foundation
import PlaygroundHelpers
/**
 Write Number in Expanded Form Part 1

 You will be given a number and you will need to return it as a string in Expanded Form. For example:

 expandedForm 12    -- Should return '10 + 2'
 expandedForm 42    -- Should return '40 + 2'
 expandedForm 70304 -- Should return '70000 + 300 + 4'
 
 NOTE: All numbers will be whole numbers greater than 0.
 */

//MARK: - Solution

func expandedForm(_ num: Int) -> String {
    var multiplier: Double = 1
    return String(num)
        .reversed()
        .compactMap { char -> String? in
            guard let number = Double(String(char)), number > 0 else {
                multiplier *= 10
                return nil
            }
            let result = String(format: "%.0f", number * multiplier)
            multiplier *= 10
            return result
        }
        .reversed()
        .joined(separator: " + ")
}

//MARK: - Just compare with other solution

func expandedFormOther(_ num: Int) -> String {
    String(num)
        .enumerated()
        .compactMap{ $0.element == "0" ? nil : String($0.element) + String(repeating: "0", count: String(num).count - $0.offset -  1) }
        .joined(separator: " + ")
}

duration { // 0.0061
    expandedForm(1234567899999999999)
}
duration { // 0.0003
    expandedFormOther(1234567899999999999)
}

// MARK: - Tests

import XCTest

class ExampleTest: XCTestCase {
    static let testValues = [
        (12, "10 + 2"),
        (42, "40 + 2"),
        (70304, "70000 + 300 + 4"),
        (1234567899999999999, "1000000000000000000 + 200000000000000000 + 30000000000000000 + 4000000000000000 + 500000000000000 + 60000000000000 + 7000000000000 + 800000000000 + 90000000000 + 9000000000 + 900000000 + 90000000 + 9000000 + 900000 + 90000 + 9000 + 900 + 90 + 9")
    ]
    
    static var allTests = [
        ("Simple Tests", tests),
    ]
    
    func tests() {
        for test in ExampleTest.testValues {
            XCTAssertEqual(expandedForm(test.0), test.1)
        }
    }
}

ExampleTest.defaultTestSuite.run()

