public extension UInt32 {
    var info: String {
        "\(self) (\(String(self, radix: 2)))"
    }
}
