import Foundation
import PlaygroundHelpers

let input = 42145
var output: Int!
duration {
    output = Int(String(String(input).sorted { $0 > $1 }))
}
print(output!)

var outputArray = [Int]()
var outputValue: Int!
func getNum(from value: Int, digits: inout [Int]) {
    if(value / 10 > 0) {
        getNum(from: value / 10, digits: &digits);
    }
    digits.append(value % 10);
}
duration {
    getNum(from: input, digits: &outputArray)
    let sortedArray = outputArray.sorted { $0 < $1 }
    outputValue = sortedArray.enumerated().reduce(0) { result, element in
        return result + (element.element * Int(pow(10.0, Double(element.offset))))
    }
}
print(outputValue!)
