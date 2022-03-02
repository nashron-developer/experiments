import Foundation



/**
 Write a function that takes in a string of one or more words, and returns the same string, but with all five or more letter words reversed (like the name of this kata).

 — Strings passed in will consist of only letters and spaces.
 — Spaces will be included only when more than one word is present.
 */

let wordLength = 5

func spinWords(in sentence: String) -> String {
    sentence
        .components(separatedBy: " ")
        .map { $0.count >= wordLength ? String($0.reversed()) : String($0) }
        .joined(separator: " ")
}

import XCTest
class SolutionTest: XCTestCase {
    
    func testSingleWords() {
        let testCases = [
          ("Welcome", "emocleW"),
          ("to", "to"),
          ("CodeWars", "sraWedoC"),
        ]
      assertTest(testCases)
    }

    func testMultipleWords() {
        let testCases = [
          ("Hey fellow warriors", "Hey wollef sroirraw"),
          ("This sentence is a sentence", "This ecnetnes is a ecnetnes"),
        ]
      assertTest(testCases)
    }
  
  private func assertTest(_ testCase: [(String, String)]) {
    testCase.forEach {
      XCTAssertEqual(spinWords(in: $0.0), $0.1)
    }
  }
}

SolutionTest.defaultTestSuite.run()
