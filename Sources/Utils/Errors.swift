public enum FormulaError: Error {
  case notEnoughValues
  case tooManyValues
  case incorrectValue(_ c: Any)
}

public enum SetError: Error {
  case duplicateValue(_ c: Any)
}
