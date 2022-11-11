import func Functions.sat

var formula: String = "AB|"

do {
  print(try sat(&formula))
} catch {
  print("Formula error: \(error)")
}
