import func Functions.powerset

var set: [Int32] = [1, 2, 3]

do {
  for subset in try powerset(&set) {
    print(subset)
  }
} catch {
  print("Set error: \(error)")
}
