let a: UInt32 = 2
let b: UInt32 = 4

print(
  [
    a.info, " *", b.info, " =", multiplier(a, b).info,
  ].joined(separator: "\n"))
