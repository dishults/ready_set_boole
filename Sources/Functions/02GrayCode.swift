public func gray_code(_ n: UInt32) -> UInt32 {
  return n ^ (n >> 1)
}

