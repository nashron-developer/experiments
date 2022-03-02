import UIKit

// https://www.codewars.com/kata/write-number-in-expanded-form-part-2

func expandedForm2(_ num: Double) -> String {
    var multiplier = 1
    var divider = 10
    let parts = String(num).components(separatedBy: ".")
    let integerPart = parts.first?.reversed().compactMap { char -> String? in
        var result: String?
        if let number = Int(String(char)), number > 0 {
            result = String(number * multiplier)
        }
        multiplier *= 10
        return result
    } ?? []
    
    let floatingPart = parts.last?.compactMap { char -> String? in
        var result: String?
        if char != "0" {
            result = "\(char)/\(divider)"
        }
        divider *= 10
        return result
    } ?? []
    return (integerPart.reversed() + floatingPart).joined(separator: " + ")
}
