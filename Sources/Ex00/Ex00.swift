public func adder(a: UInt32, b: UInt32) -> UInt32 {
    //  TODO: implement binary add
    return a + b
}

// MARK: - Main
let a: UInt32 = 1, b: UInt32 = 2

@main
public struct Ex00 {

    public static func main() {
        print(adder(a: a, b: b))
    }
}
