import Foundation

struct Object: Hashable {
    let id: Int
}

struct Stack {
    
    var array = [Object]()
    
    mutating func push(_ some: Object) {
        array.append(some)
    }
    
    mutating func pop() -> Object? {
        array.popLast()
    }
    
}

struct Queue {
    private var s1 = Stack()
    private var s2 = Stack()
    
    mutating func push(_ some: Object) {
        s1.push(some)
    }
    
    mutating func pop() -> Object? {
        while let popObj = s1.pop() {
            s2.push(popObj)
        }
        let result = s2.pop()
        while let popObj = s2.pop() {
            s1.push(popObj)
        }
        return result
    }
    
}

var queue = Queue()

let o1 = Object(id: 1)
let o2 = Object(id: 2)
let o4 = Object(id: 4)
let o3 = Object(id: 3)

queue.push(o1)
queue.push(o2)
queue.push(o3)

print(queue.pop() ?? "nil")
queue.push(o4)
print(queue.pop() ?? "nil")
print(queue.pop() ?? "nil")
print(queue.pop() ?? "nil")






