import func Functions.reverse_map

do {
  print(try reverse_map(0.0))
  print(try reverse_map(0.9999694828875292))
  print(try reverse_map(0.9999847414437646))
  print(try reverse_map(1.0))
  print()
  print(try reverse_map(1.1641532185403987e-09))
  print(try reverse_map(0.24999999982537702))
  print(try reverse_map(0.5820883672177066))
} catch {
  print("Number error: \(error)")
}
