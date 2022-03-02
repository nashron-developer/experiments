import Foundation
import PlaygroundHelpers


var array = [2, 5, 6, 3, 4, 8, 9, 3, 7, 8, 1, 6, 10, 11, 13, 15, 14, 17, 16, 20, 19]

//MARK: - Quick Sort

func quickSort(array: [Int], by areInIncasingOrder: (Int, Int) -> Bool) -> [Int] {
    var tempArray = array
    guard let element = array.randomElement(),
          let index: Int = array.firstIndex(of: element)
    else { return [] }
    let pivot = tempArray.remove(at: index)
    var lArray = [Int]()
    var rArray = [Int]()
    tempArray.forEach {
        if areInIncasingOrder(pivot, $0) {
            rArray.append($0)
        } else {
            lArray.append($0)
        }
    }
    return quickSort(array: lArray, by: areInIncasingOrder) + [pivot] + quickSort(array: rArray, by: areInIncasingOrder)
}
var result: [Int]!
let qsd = duration {
    result = quickSort(array: array) { $0 > $1 }
}
print("QuickSort:\t\(result!) - \(qsd)")

var defaultResult: [Int]!
let ds = duration {
    defaultResult = array.sorted { $0 > $1 }
}
print("DefaultSort:\t\(defaultResult!) - \(ds)")
print()
