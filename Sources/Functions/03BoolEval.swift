extension Bool {
  static func ^ (left: Bool, right: Bool) -> Bool {
    return (left || right) && !(left && right)
  }

  static func > (left: Bool, right: Bool) -> Bool {
    return !left || right
  }
}

enum FormulaError: Error {
  case notEnoughValues
  case tooManyValues
  case incorrectValue(_ c: Character)
}

public func eval_formula(_ formula: UnsafePointer<String>) throws -> Bool {
  var booleans = [Bool]()

  for c in formula.pointee {
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
        booleans.append(one ^ two)
      case ">":
        booleans.append(one > two)
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
