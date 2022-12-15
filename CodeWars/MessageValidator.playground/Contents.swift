/**
 In this kata, you have an input string and you should check whether it is a valid message. To decide that, you need to split the string by the numbers, and then compare the numbers with the number of characters in the following substring.
 
 For example "3hey5hello2hi" should be split into 3, hey, 5, hello, 2, hi and the function should return true, because "hey" is 3 characters, "hello" is 5, and "hi" is 2; as the numbers and the character counts match, the result is true.
 
 Notes:
 
 - Messages are composed of only letters and digits
 - Numbers may have multiple digits: e.g. "4code13hellocodewars" is a valid message
 - Every number must match the number of character in the following substring, otherwise the message is invalid: e.g. "hello5" and "2hi2" are invalid
 - If the message is an empty string, you should return true
 
 */

import UIKit
import PlaygroundHelpers

let splitRegex = /\d+\D+/
let regex = #/(?<count> \d+)(?<word> \D+)/#

/// fastest
func isAValidMessage(_ message: String) -> Bool {
    guard !message.isEmpty else { return true }
    guard message.split(separator: splitRegex).isEmpty else { return false }
    return !message
        .matches(of: regex)
        .allSatisfy { String($0.output.word).count == Int($0.output.count) }
}

let valuesRegex = try! NSRegularExpression(pattern: "\\d+\\D+")
let digitsRegex = try! NSRegularExpression(pattern: "\\d+")
let wordsRegex = try! NSRegularExpression(pattern: "\\D+")

func isAValidMessageNS(_ message: String) -> Bool {
    guard !message.isEmpty else { return true }
    
    let valuesString = valuesRegex
        .matches(in: message, range: NSMakeRange(0, message.count))
        .map { String(message[Range($0.range, in: message)!]) }
        .joined()
    
    guard valuesString == message else { return false }
    
    let digits = digitsRegex
        .matches(in: valuesString, range: NSMakeRange(0, valuesString.count))
        .map { String(valuesString[Range($0.range, in: valuesString)!]) }
    let words = wordsRegex
        .matches(in: valuesString, range: NSMakeRange(0, valuesString.count))
        .map { String(valuesString[Range($0.range, in: valuesString)!]) }
    
    return zip(digits, words)
        .allSatisfy { (digit, word) in
            Int(digit) == word.count
        }
}

func isAValidMessageComponents(_ message: String) -> Bool {
    guard !message.isEmpty else { return true }
    
    let characters = message.components(separatedBy: .decimalDigits).filter { !$0.isEmpty }
    let numbers = message.components(separatedBy: .letters).filter { !$0.isEmpty }
    
    let zips = zip(characters, numbers)
    guard zips.map({ $1 + $0 }).joined() == message else { return false }
    return zips.allSatisfy { c, i in
        c.count == Int(i)
    }
}

print(duration {
    isAValidMessage("3hey5hello2hi")
    isAValidMessage("4code13hellocodewars")
    isAValidMessage("3hey5hello2hi5")
    isAValidMessage("code4hello5")
    isAValidMessage("1a2bb3ccc4dddd5eeeee")
    isAValidMessage("")
})
print(duration {
    isAValidMessageNS("3hey5hello2hi")
    isAValidMessageNS("4code13hellocodewars")
    isAValidMessageNS("3hey5hello2hi5")
    isAValidMessageNS("code4hello5")
    isAValidMessageNS("1a2bb3ccc4dddd5eeeee")
    isAValidMessageNS("")
})

print(duration {
    isAValidMessageComponents("3hey5hello2hi")
    isAValidMessageComponents("4code13hellocodewars")
    isAValidMessageComponents("3hey5hello2hi5")
    isAValidMessageComponents("code4hello5")
    isAValidMessageComponents("1a2bb3ccc4dddd5eeeee")
    isAValidMessageComponents("")
})

import XCTest

class SolutionTest: XCTestCase {
    
    func testExample() {
        XCTAssertEqual(isAValidMessageComponents("3hey5hello2hi"), true)
        XCTAssertEqual(isAValidMessageComponents("4code13hellocodewars"), true)
        XCTAssertEqual(isAValidMessageComponents("3hey5hello2hi5"), false)
        XCTAssertEqual(isAValidMessageComponents("code4hello5"), false)
        XCTAssertEqual(isAValidMessageComponents("1a2bb3ccc4dddd5eeeee"), true)
        XCTAssertEqual(isAValidMessageComponents(""), true)
    }
    
}

print(duration {
    SolutionTest.defaultTestSuite.run()
})
