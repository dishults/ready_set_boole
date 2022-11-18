import Utils

// Algorithm is based on Szudzik's Elegant Pairing Function
public func reverse_map(_ n: Float64) throws -> (UInt16, UInt16) {
  guard n >= 0.0 && n <= 1.0 else {
    throw FormulaError.incorrectValue(n)
  }
  let n = UInt32(n * Float64(UInt32.max))
  let y = n.sqrt
  let x = n - y * y
  return x < y ? (UInt16(x), UInt16(y)) : (UInt16(y), UInt16(x - y))
}
