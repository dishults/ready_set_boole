import func Functions.eval_formula

var formula: String = "10|1&"

print(
  """
  \(formula)
   =
  \(eval_formula(&formula))
  """
)
