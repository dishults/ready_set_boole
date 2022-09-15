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
