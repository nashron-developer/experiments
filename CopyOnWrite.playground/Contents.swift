import Foundation
import PlaygroundHelpers

/**
 Модель передается по ссылке
 */

class CarClass {
   var company: String!
   var model: String!
init(company: String, model: String) {
    self.company = company;
    self.model = model;
  }
}

var audiA4Class = CarClass(company: "Audi", model: "A4")
audiA4Class.model//A4
var newAudiClass: CarClass!
duration {
    newAudiClass = audiA4Class // записываем ссылку на данные в новую переменную
}
newAudiClass.model = "Q5" // меняем значение в модели
audiA4Class.model           //Q5
newAudiClass.model          //Q5

/**
 Модель передается копией
 */

struct CarStruct {
   var company: String!
   var model: String!
  init(company: String, model: String) {
    self.company = company;
    self.model = model;
  }
}

var audiA4Struct = CarStruct(company: "Audi", model: "A4")
audiA4Struct.model               //A4

var newAudiStruct: CarStruct!
duration {
    newAudiStruct = audiA4Struct // Тут создается копия структуры
}
newAudiStruct.model = "Q5" // изменяем новую структуру (копию)
audiA4Struct.model               //A4
newAudiStruct.model              //Q5


final class ExampleClass {
  let exampleString = "Ex value"
    var test = "test"
}

struct ExampleStruct {
  let ref1 = ExampleClass()
  let ref2 = ExampleClass()
  let ref3 = ExampleClass()
  let ref4 = ExampleClass()
}

struct ExampleStruct2 {
    var ref: ExampleClass!
}

var example = ExampleStruct()

var example2: ExampleStruct!
duration {
    example2 = example
}

example.ref1.test = "test2"
example.ref1.test
example2.ref1.test
example2.ref2.test

let exampleClass = ExampleClass()

var example3: ExampleStruct2!
var example4: ExampleStruct2!
duration {
    example3 = ExampleStruct2(ref: ExampleClass())
}
duration {
    example4 = example3
}
example3.ref.test = "test3"
example3.ref.test
example4.ref.test
exampleClass.test

func changeValue(in struct: ExampleStruct2) {
    `struct`.ref.test = "test5"
}

changeValue(in: example4)
example3.ref.test
example4.ref.test
exampleClass.test

print("\n------ Test Manual Implementation COW -----")

final class Ref<T> {
  var val : T
  init(_ v : T) {val = v}
}
struct Box<T> {
    var ref : Ref<T>
    init(_ x : T) { ref = Ref(x) }
    var value: T {
        get { return ref.val }
        set {
          if (!isKnownUniquelyReferenced(&ref)) {
            ref = Ref(newValue)
            return
          }
          ref.val = newValue
        }
    }
}

let testValue = 1

var testBox = Box(testValue)
//print("ref")
//print(address: &testBox.ref)
//print("ref.val")
print(address: &testBox.ref.val)
var testBox2 = testBox
//print("ref")
//print(address: &testBox2.ref)
//print("ref.val")
print(address: &testBox2.ref.val)
testBox2.value += 4
//print("ref")
//print(address: &testBox2.ref)
//print("ref.val")
print(address: &testBox2.ref.val)

print("\n------ Test Default COW -----")

let testArray = [1,2,3,4,5]
print(address: testArray)
var testArray2 = testArray
print(address: testArray2)

testArray2.append(1)
print(address: testArray2)
print()
let array = [1,2,3] //address A
print(address: array)
var notACopy = array //still address A
    print(address: notACopy)
notACopy += [4,5,6] //now address B
print(address: notACopy)

class Cat {
    var name: String?
}
struct Dog {
    var name: String?
}
struct Host {
    var cat: Cat? {
        didSet {
            print ("set a cat")
        }
    }
    var dog: Dog? {
        didSet {
            print ("set a dog")
        }
    }
}
print()
var host = Host() //
duration {
    host.cat = Cat() //
}
duration {
    host.dog = Dog() //
}
print(address: &host.dog!)
duration {
    host.cat?.name = "Cat" //
}
print(address: &host.dog!)
duration {
    host.dog?.name = "Dog" //
}
print(address: &host.dog!)

class A: NSObject {
    var delegate: B?
}

class B: NSObject {
   var delegate: A?
}

weak var a: A?
weak var b: B?

func configure() {

    let tempA = A()
    let tempB = B()
    a = tempA
    b = tempB
    
//    a = A()
    //    b = B()
    
    
    a?.delegate = b
    b?.delegate = a
}

configure()

print(a ?? "nil") //
print(b  ?? "nil") //
print(a?.delegate ?? "nil") //
print(b?.delegate ?? "nil") //

a = nil
b = nil

print(a ?? "nil") //
print(b  ?? "nil") //
print(a?.delegate ?? "nil") //
print(b?.delegate ?? "nil") //


//struct C {
//    var c: [C]?
//}
//
//class D {
//    var d: D?
//}
//
//struct E {
//    var e: E?
//}

class UIViewController {
    
    func viewDidLoad() {
        print(6)
        
        let serialQueue = DispatchQueue(label: "CustomQueue", qos: .userInteractive)
        serialQueue.async {
            print(7)
            
            serialQueue.async {
                print(8)
            }
            
            print(9)
        }
        
        print(10)
    }
}

let vc = UIViewController()
print(16)
vc.viewDidLoad()
print(17)
print()
class UIViewController2 {
    
    func viewDidLoad() {
        print(11)
        
        DispatchQueue.global().async {
            print(12)
            
            DispatchQueue.global().sync {
                print(13)
            }
            
            print(14)
            print()
        }
        print(15)
    }
}

let vc2 = UIViewController2()
print(16)
vc2.viewDidLoad()
print(17)


var count = 0
let group = DispatchGroup()
let lock = NSLock()

group.enter()
let thread1 = Thread {
    duration {
        for _ in 0...999 {
            lock.lock()
            count += 1
            lock.unlock()
        }
    }
    group.leave()
}

group.enter()
let thread2 = Thread {
    duration {
        for _ in 0...999 {
            lock.lock()
            count += 1
            lock.unlock()
        }
    }
    group.leave()
}

duration {
    
    thread1.start()
    thread2.start()
    
    group.notify(queue: DispatchQueue.global()) {
        print(count)
    }
}
