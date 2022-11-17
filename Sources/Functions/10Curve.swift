// Algorithm is based on Szudzik's Elegant Pairing Function
public func map(_ x: UInt16, _ y: UInt16) -> Float64 {
  let x = UInt32(x)
  let y = UInt32(y)
  let res = x >= y ? x * x + x + y : y * y + x
  return Float64(res) / Float64(UInt32.max)
}
