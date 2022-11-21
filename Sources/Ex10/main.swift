import func Functions.map

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
  print(map(x, y))
}
