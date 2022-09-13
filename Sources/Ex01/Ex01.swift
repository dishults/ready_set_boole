public func multiplier(a: UInt32, b: UInt32) -> UInt32 {
    //  TODO: implement binary multiplier
    return a * b
}

// MARK: - Main
let a: UInt32 = 1, b: UInt32 = 2

@main
public struct Ex01 {

    public static func main() {
        print(multiplier(a: a, b: b))
    }
}
