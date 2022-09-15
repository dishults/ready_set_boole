let a: UInt32 = 11
let b: UInt32 = 22

print(
  [
    a.info, " +", b.info, " =", adder(a, b).info,
  ].joined(separator: "\n"))
