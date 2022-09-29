import Utils

import func Exercises.adder

let a: UInt32 = 11
let b: UInt32 = 22

print(
  """
  \(a.info)
   +
  \(b.info)
   =
  \(adder(a, b).info)
  """
)
