import Foundation
//MARK: - Task Description
/**
 Write a function that takes a string of braces, and determines if the order of the braces is valid. It should return true if the string is valid, and false if it's invalid.
 
 This Kata is similar to the Valid Parentheses Kata, but introduces new characters: brackets [], and curly braces {}. Thanks to @arnedag for the idea!
 
 All input strings will be nonempty, and will only consist of parentheses, brackets and curly braces: ()[]{}.
 
 What is considered Valid?
 
 A string of braces is considered valid if all braces are matched with the correct brace.
 */

//MARK: - Solution 1

var characterPairs: [(Character, Character)] = [
    ("(",")"),
    ("[","]"),
    ("{","}"),
]

func validBraces(_ string: String) -> Bool {
    var stack = [Character]()
    for char in string {
        for pair in characterPairs {
            guard char != pair.0 else { stack.append(char); break }
            if char == pair.1 {
                guard stack.last == pair.0 else { return false }
                stack.removeLast()
            }
        }
    }
    return stack.isEmpty
}
//MARK: - Solution 2

let patternsMatches = [
    "{}",
    "()",
    "[]",
]

func validBraces2(_ string: String) -> Bool {
    var tempString = string
    while let pattern = patternsMatches.first(where: { tempString.contains($0) }) {
        tempString = tempString.replacingOccurrences(of: pattern, with: "")
    }
    return tempString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}
//MARK: - Tests

import XCTest
class SolutionTest: XCTestCase {
    
    func testNonNested() {
        XCTAssertTrue(validBraces("()"))
        XCTAssertTrue(validBraces("[]"))
        XCTAssertTrue(validBraces("{}"))
        XCTAssertTrue(validBraces("(){}[]"))
    }
    
    func testNested() {
        XCTAssertTrue(validBraces("([{}])"))
        XCTAssertFalse(validBraces("(}"))
        XCTAssertFalse(validBraces("[(])"))
        XCTAssertTrue(validBraces("({})[({})]"))
        XCTAssertFalse(validBraces("(})"))
        XCTAssertTrue(validBraces("(({{[[]]}}))"))
        XCTAssertTrue(validBraces("{}({})[]"))
        XCTAssertFalse(validBraces(")(}{]["))
        XCTAssertFalse(validBraces("())({}}{()][]["))
        XCTAssertFalse(validBraces("(((({{"))
        XCTAssertFalse(validBraces("}}]]))}])"))
    }
    
    func testNonNested2() {
        XCTAssertTrue(validBraces2("()"))
        XCTAssertTrue(validBraces2("[]"))
        XCTAssertTrue(validBraces2("{}"))
        XCTAssertTrue(validBraces2("(){}[]"))
    }
    
    func testNested2() {
        XCTAssertTrue(validBraces2("([{}])"))
        XCTAssertFalse(validBraces2("(}"))
        XCTAssertFalse(validBraces2("[(])"))
        XCTAssertTrue(validBraces2("({})[({})]"))
        XCTAssertFalse(validBraces2("(})"))
        XCTAssertTrue(validBraces2("(({{[[]]}}))"))
        XCTAssertTrue(validBraces2("{}({})[]"))
        XCTAssertFalse(validBraces2(")(}{]["))
        XCTAssertFalse(validBraces2("())({}}{()][]["))
        XCTAssertFalse(validBraces2("(((({{"))
        XCTAssertFalse(validBraces2("}}]]))}])"))
    }
}

SolutionTest.defaultTestSuite.run()



