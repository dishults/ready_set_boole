import func Functions.negation_normal_form

var formula: String = "AB|C&!"

do {
  try print(negation_normal_form(&formula))
} catch {
  print("Formula error: \(error)")
}
