import func Functions.conjunctive_normal_form

var formula: String = "ABCD&|&"

do {
  try print(conjunctive_normal_form(&formula))
} catch {
  print("Formula error: \(error)")
}
