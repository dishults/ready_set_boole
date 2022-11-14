import func Functions.eval_set

var formula: String = "AB|"

var sets: [[Int32]] = [
  [0, 1, 2],
  [3, 4, 5],
]

do {
  print(try eval_set(&formula, &sets))
} catch {
  print("Formula error: \(error)")
}
