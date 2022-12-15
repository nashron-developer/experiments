/**
 Implement a function which convert the given boolean value into its string representation.

 Note: Only valid inputs will be given.
 */

import UIKit

func booleanToString(_ b: Bool) -> String {
  return String(describing: b)
}

import XCTest

class SolutionTest: XCTestCase {
    
    func testExample() {
        XCTAssertEqual(booleanToString(true), "true")
        XCTAssertEqual(booleanToString(false), "false")
    }
    
}

SolutionTest.defaultTestSuite.run()
