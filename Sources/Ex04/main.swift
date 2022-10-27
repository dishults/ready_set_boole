import func Functions.print_truth_table

var formula: String = "AB&C|"

do {
  try print_truth_table(&formula)
} catch {
  print("Formula error: \(error)")
}
