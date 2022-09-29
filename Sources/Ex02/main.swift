import Utils

import func Functions.gray_code

let n: UInt32 = 2

print(
  """
  \(n.info)
   =
  \(gray_code(n).info)
  """
)
