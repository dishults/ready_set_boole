extension Bool {
  static func ^ (left: Bool, right: Bool) -> Bool {
    return (left || right) && left != right
  }

  static func > (left: Bool, right: Bool) -> Bool {
    return !(left == true && right == false)
  }
}

public func eval_formula(_ formula: UnsafePointer<String>) -> Bool {
  var res = [Bool]()

  for c in formula.pointee {
    // MARK: - Boolean
    if "01".contains(c) {
      res.append(c == "1")

      // MARK: - Negation
    } else if c == "!" {
      // TODO: check for index error
      let one = res.removeLast()
      res.append(!one)

      // MARK: - Operators
    } else if "&|^>=".contains(c) {
      // TODO: check for index error
      let two = res.removeLast()
      let one = res.removeLast()

      switch c {
      case "&":
        res.append(one && two)
      case "|":
        res.append(one || two)
      case "^":
        res.append(one ^ two)
      case ">":
        res.append(one > two)
      case "=":
        res.append(one == two)
      default:
        break
      }

      // MARK: - Error
    } else {
      // TODO: raise error
    }
  }

  // TODO: check if len == 1 else raise error
  return res.last!
}

// 1011||=   ->   true == (false || (true || true))   -> true
// 10|1&     ->   (true || false) && true             -> true
