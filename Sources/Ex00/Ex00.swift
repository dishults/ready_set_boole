import Utils

public func adder(_ a: UInt32, _ b: UInt32) -> UInt32 {
    var a = a
    var b = b
    var carry: UInt32

    while b != 0 {
        carry = a & b
        a = a ^ b
        b = carry << 1
    }
    return a
}

// MARK: - Main
let a: UInt32 = 11, b: UInt32 = 22

@main
public struct Ex00 {

    public static func main() {
        print([
            a.info, " +", b.info, " =", adder(a, b).info,
        ].joined(separator: "\n"))
    }
}
