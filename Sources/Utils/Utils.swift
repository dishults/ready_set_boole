//class Utils {
//    public func printNum(_ num: UInt32) {
//        print("\(num) \(String(num, radix: 2))")
//    }
//}

public extension UInt32 {
    var info: String {
        "\(self) (\(String(self, radix: 2)))"
    }
}
