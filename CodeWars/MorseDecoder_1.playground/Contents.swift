import UIKit
 
/**
 # Description
 
 In this kata you have to write a simple Morse code decoder. While the Morse code is now mostly superseded by voice and digital data communication channels, it still has its use in some applications around the world.
 
 The Morse code encodes every character as a sequence of "dots" and "dashes". For example, the letter A is coded as ·−, letter Q is coded as −−·−, and digit 1 is coded as ·−−−−. The Morse code is case-insensitive, traditionally capital letters are used. When the message is written in Morse code, a single space is used to separate the character codes and 3 spaces are used to separate words. For example, the message HEY JUDE in Morse code is ···· · −·−−   ·−−− ··− −·· ·.

 NOTE: Extra spaces before or after the code have no meaning and should be ignored.

 In addition to letters, digits and some punctuation, there are some special service codes, the most notorious of those is the international distress signal SOS (that was first issued by Titanic), that is coded as ···−−−···. These special codes are treated as single special characters, and usually are transmitted as separate words.

 Your task is to implement a function that would take the morse code as input and return a decoded human-readable string.

 For example:
 
 ```
    decodeMorse('.... . -.--   .--- ..- -.. .')
    //should return "HEY JUDE"
 ```
 
 NOTE: For coding purposes you have to use ASCII characters . and -, not Unicode characters.

 The Morse code table is preloaded for you as a dictionary, feel free to use it:
 
 Swift: MorseCode[".--"] ?? "" or MorseCode[".--", default: ""]

 All the test strings would contain valid Morse code, so you may skip checking for errors and exceptions. In C#, tests will fail if the solution code throws an exception, please keep that in mind. This is mostly because otherwise the engine would simply ignore the tests, resulting in a "valid" solution.

 */

//MARK: - Alphabet
var morseDictionary: [String: String] {[
    ".-": "a",
    "-...": "b",
    "-.-.": "c",
    ".": "e",
    "-..": "d",
    "..-.": "f",
    "--.": "g",
    "....": "h",
    "..": "i",
    ".---": "j",
    "-.-": "k",
    ".-..": "l",
    "--": "m",
    "-.": "n",
    "---": "o",
    ".--.": "p",
    "--.-": "q",
    ".-.": "r",
    "...": "s",
    "-": "t",
    "..-": "u",
    "...-": "v",
    ".--": "w",
    "-..-": "x",
    "-.--": "y",
    "--..": "z",
    "...---...": "SOS",
    "-.-.--": "!",
    ".-.-.-": ".",
]}

//MARK: - Solution

func decodeMorse(_ morseCode: String) -> String {
    morseCode
        .replacingOccurrences(of: "   ", with: " | ")
        .split(separator: " ")
        .map { $0 == "|" ? String($0) : morseDictionary[String($0), default: ""].uppercased() }
        .joined()
        .replacingOccurrences(of: "|", with: " ")
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

//MARK: - Tests
import XCTest

class SolutionTest: XCTestCase {

    func testExample() {
        XCTAssertEqual(decodeMorse(".... . -.--   .--- ..- -.. ."), "HEY JUDE")
    }

    func testBasic() {
        XCTAssertEqual(decodeMorse(".-"), "A")
        XCTAssertEqual(decodeMorse(".."), "I")
        XCTAssertEqual(decodeMorse(". ."), "EE")
        XCTAssertEqual(decodeMorse(".   ."), "E E")
        XCTAssertEqual(decodeMorse("...---..."), "SOS")
        XCTAssertEqual(decodeMorse("... --- ..."), "SOS")
        XCTAssertEqual(decodeMorse("...   ---   ..."), "S O S")
    }

    func testComplex() {
        XCTAssertEqual(decodeMorse(" . "), "E")
        XCTAssertEqual(decodeMorse("   .   . "), "E E")
        XCTAssertEqual(decodeMorse("      ...---... -.-.--   - .... .   --.- ..- .. -.-. -.-   -... .-. --- .-- -.   ..-. --- -..-   .--- ..- -- .--. ...   --- ...- . .-.   - .... .   .-.. .- --.. -.--   -.. --- --. .-.-.-  "), "SOS! THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG.")
    }
}

SolutionTest.defaultTestSuite.run()

