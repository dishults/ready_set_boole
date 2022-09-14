import Utils

public func multiplier(_ a: UInt32, _ b: UInt32) -> UInt32 {
    //  TODO: implement binary multiplier
    return a * b
}

// MARK: - Main
let a: UInt32 = 2, b: UInt32 = 4

@main
public struct Ex01 {

    public static func main() {
        print([
            a.info, " *", b.info, " =", multiplier(a, b).info,
        ].joined(separator: "\n"))
    }
}
