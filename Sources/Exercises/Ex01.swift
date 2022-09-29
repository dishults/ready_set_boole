public func multiplier(_ a: UInt32, _ b: UInt32) -> UInt32 {
  var a = a
  var b = b
  var res: UInt32 = 0
  while b != 0 {
    // If b is an odd number
    if (b & 1) != 0 {
      res = adder(res, a)
    }
    a = a << 1
    b = b >> 1
  }
  return res
}
