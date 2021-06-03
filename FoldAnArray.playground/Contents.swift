import Foundation
import PlaygroundHelpers

/**
 #Fold an array

 In this kata you have to write a method that folds a given array of integers by the middle x-times.

 An example says more than thousand words:

 Fold 1-times:
 [1,2,3,4,5] -> [6,6,3]

 A little visualization (NOT for the algorithm but for the idea of folding):

  Step 1         Step 2        Step 3       Step 4       Step5
                      5/           5|         5\
                     4/            4|          4\
 1 2 3 4 5      1 2 3/         1 2 3|       1 2 3\       6 6 3
 ----*----      ----*          ----*        ----*        ----*


 Fold 2-times:
 [1,2,3,4,5] -> [9,6]
 As you see, if the count of numbers is odd, the middle number will stay. Otherwise the fold-point is between the middle-numbers, so all numbers would be added in a way.

 The array will always contain numbers and will never be null. The parameter runs will always be a positive integer greater than 0 and says how many runs of folding your method has to do.

 If an array with one element is folded, it stays as the same array.

 The input array should not be modified!
 */

func foldArray(_ arr: [Int], times: Int) -> [Int] {
    guard times > 0, arr.count > 1 else { return arr }
    var array = arr
    var tempArray = [Int]()
    while array.count > 1 {
        tempArray.append(array.removeFirst() + array.removeLast())
    }
    return foldArray(tempArray + array, times: times - 1)
}

func foldArray2(_ arr: [Int], times: Int) -> [Int] {
    if times == 0 { return arr }
    let tail = arr.suffix(arr.count/2).reversed() + [0]
    let head = arr.prefix((arr.count+1)/2)
    let arrBack = zip(head, tail).flatMap { $0.0 + $0.1 }
    return foldArray(arrBack, times: times-1)
}

let arr = [1,2,3,4,56,7,8,1,2,3,44,32,32,24,54,25,3,48,56,4,412,45,89,67,45,43,56,4]
duration {
foldArray(arr, times: 4)
}
duration {
    
    foldArray2(arr, times: 4)
}
import XCTest

class SolutionTest: XCTestCase {
    static var allTests = [
        ("Basic Tests", testBasic),
    ]

    func testBasic() {
        XCTAssertEqual(foldArray([1,2,3,4,5], times: 1), [6,6,3], "\(foldArray([1,2,3,4,5], times: 1)) != \([6,6,3])")
        XCTAssertEqual(foldArray([6,6,3], times: 1), [9,6], "\(foldArray([6,6,3], times: 1)) != \([9,6])")
        XCTAssertEqual(foldArray([9,6], times: 1), [15], "\(foldArray([9,6], times: 1)) != \([15])")
        XCTAssertEqual(foldArray([1,2,3,4,5], times: 3), [15], "\(foldArray([9,6], times: 1)) != \([15])")
        XCTAssertEqual(foldArray([-9,9,-8,8,66,23], times: 1), [14,75,0], "\(foldArray([1,2,3,4,5], times: 1)) != \([6,6,3])")
    }
}

SolutionTest.defaultTestSuite.run()
