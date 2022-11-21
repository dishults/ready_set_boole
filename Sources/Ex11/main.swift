import func Functions.map
import func Functions.reverse_map

let tests: [(UInt16, UInt16)] = [
  (0, 0),
  (0, UInt16.max),
  (UInt16.max, 0),
  (UInt16.max, UInt16.max),
  (1, 2),
  (42, 4200),
  (UInt16.max / 2, UInt16.max / 2),
  (50000, 500),
]

for (x, y) in tests {
  let n = map(x, y)
  do {
    let (x1, x2): (UInt16, UInt16) = try reverse_map(n)
    print("\((x, y)) -> \(n) -> \((x1, x2))")
  } catch {
    print("Number error: \(error)")
  }
}
