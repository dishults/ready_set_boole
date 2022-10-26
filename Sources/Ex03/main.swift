import func Functions.eval_formula

var formula: String = "10|1&"

do {
  try print(
    """
    \(formula)
     =
    \(eval_formula(&formula))
    """
  )
} catch {
  print("Formula error: \(error)")
}
