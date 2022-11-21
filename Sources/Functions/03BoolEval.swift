import Utils

public func eval_formula(_ formula: inout String) throws -> Bool {
  var booleans = [Bool]()

  for c in formula {
    // MARK: - Boolean
    if "01".contains(c) {
      booleans.append(c == "1")

      // MARK: - Negation
    } else if c == "!" {
      guard booleans.count > 0 else {
        throw FormulaError.notEnoughValues
      }
      booleans[booleans.count - 1].toggle()

      // MARK: - Operators
    } else if "&|^>=".contains(c) {
      guard booleans.count > 0 else {
        throw FormulaError.notEnoughValues
      }
      let two = booleans.removeLast()
      guard booleans.count > 0 else {
        throw FormulaError.notEnoughValues
      }
      let one = booleans.removeLast()

      switch c {
      case "&":
        booleans.append(one && two)
      case "|":
        booleans.append(one || two)
      case "^":
        booleans.append(one ^ two)  // Utils.Extentions
      case ">":
        booleans.append(one > two)  // Utils.Extentions
      case "=":
        booleans.append(one == two)
      default:
        break
      }

      // MARK: - Error
    } else {
      throw FormulaError.incorrectValue(c)
    }
  }

  guard booleans.count > 0 else {
    throw FormulaError.notEnoughValues
  }
  guard booleans.count == 1 else {
    throw FormulaError.tooManyValues
  }
  return booleans.last!
}

// 1011||=   ->   true == (false || (true || true))   -> true
// 10|1&     ->   (true || false) && true             -> true
