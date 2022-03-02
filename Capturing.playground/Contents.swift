import Foundation

class A{
    weak var b: B?
    init(b: B) {
        self.b = b
    }
    deinit {
        print("A")
    }
}

class B {
    weak var a: A?
    deinit {
        print("B")
    }
}


weak var b: B?
weak var a: A?

func config() {
    let tb = B()
    let ta = A(b: tb)
    
    b = tb
    a = ta
    b?.a = a
}

config()
//b = nil
//a1 = nil

print(a)
print(b)


class Sample {
    var test = 1
}

func m(_ s: Sample) {
    s.test += 1
}

var s = Sample()
print(s.test)
m(s)
print(s.test)

let arr =  [("a", 1), ("a", 2), ("a", 2), ("b", 3)]
var dic = [String:[Int]]()

arr.compactMap { dic[$0.0, default: []].append($0.1) }

print(dic)
