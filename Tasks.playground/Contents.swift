import Foundation
import PlaygroundHelpers

indirect enum A {
    case a(A)
    case b
}

protocol test {}

 
struct Person: test {
    var name: String
    let age: Int
}

var person1 = Person(name: "Sasha", age: 15)
person1.name = "Dima"

let person2 = Person(name: "Masha", age: 20)
//person2.name = ""

var array1: [Int]!
var array2: [Int]!
duration {
 array1 = [0,1,2,3]
}
duration {
 array2 = array1
}
print(address: array1)
print(address: array2)
duration {
array2.append(4)
}
print(address: array1)
print(address: array2)

var a: [String:Int?] = ["one":1, "two": nil, "three":nil]
a.count
a["two"] = nil
a["three"] = nil
a.count
print(a)
a.updateValue(nil, forKey: "two")
a.count
print(a)

var thing = "cars"

let closure = { [thing] in
    print("I love \(thing)")
}

thing = "airplanes"

closure()


protocol Drawing: AnyObject {
//    func circle()
    func render()
}

extension Drawing {
    func circle() { print("protocol") }
    func render() { circle() }
}

class SVG: Drawing {
    func circle() { print("class") }
}

SVG().render()

let q = DispatchQueue(label: "", attributes: .concurrent)
q.async(flags: .barrier) {
    
}


class A1 {
    var b: B
    init(b: B) {
        self.b = b
    }
    deinit {
        print("A1")
    }
}

class B {
    weak var a: A1?
    deinit {
        print("B")
    }
}

var b: B? = B()
var a1: A1? = A1(b: b!)
b?.a = a1
b = nil
//a1 = nil

print()
print("------ Test Array -----")
var testArray = [Int]()
print(address: testArray)
testArray.append(1)
print(address: testArray)
testArray.append(2)
print(address: testArray)
testArray.remove(at: 0)
print(address: testArray)


protocol SomeProtocol {
    var someProperty: Int { get set }
}

class SomeClass: SomeProtocol {
    var someProperty: Int = 0
}

struct SomeStruct: SomeProtocol {
    var someProperty: Int = 0
}

func foo(someArgument: inout SomeProtocol) {
    someArgument.someProperty = 10
}

let a22 = Optional<Optional<Int>>(1)

