import Foundation
import PlaygroundHelpers

func func1() {
    print(2)

    DispatchQueue.global().async {
        print(3)

        DispatchQueue.global().sync {
            print(4)
        }

        print(5)
        print()
    }

    print(6)
}
print("\n----- func1 -----")
print(1)
func1()
print(7)
sleep(1)

func func3() {
    print(2)

    DispatchQueue.global().async {
        print(3)

        DispatchQueue.global().async {
            print(4)
        }

        print(5)
    }

    print(6)
}
print("\n----- func3 -----")
print(1)
func3()
print(7)
sleep(3)

func func4() {
    print(2)
    let queue = DispatchQueue(label: "MyDispatchQueue")
    let cqueue = DispatchQueue(label: "MyConcurrentDispatchQueue", attributes: .concurrent)
    queue.sync {
        print(3)

        cqueue.async {
            print(4)
            print(8)
            print(9)
        }

        print(5)
    }

    print(6)
}
print("\n----- func4 -----")
print(1)
func4()
print(7)
sleep(3)

func func2() {
    print(2)

    DispatchQueue.global().async {
        print(3)

        DispatchQueue.main.sync {
            print(4)
        }

        print(5)
    }

    print(6)
}
print("\n----- func2 -----")
print(1)
func2()
print(7)



var array = [Int]()
let lock = NSLock()
let sem = DispatchSemaphore(value: 1)
duration {
    DispatchQueue.concurrentPerform(iterations: 100) { index in
                    lock.lock()
        
//        sem.wait()
        let last = (array.last ?? 0) + 1
        array.append(last)
                    lock.unlock()
//        sem.signal()
    }
}
print(array)
