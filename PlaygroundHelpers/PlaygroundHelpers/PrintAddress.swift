import Foundation

public func print(address object: UnsafeRawPointer) {
    print(String(format: "%p", Int(bitPattern: object)))
}
