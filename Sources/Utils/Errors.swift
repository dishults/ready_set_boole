public enum FormulaError: Error {
  case notEnoughValues
  case tooManyValues
  case incorrectValue(_ c: Any)
}
