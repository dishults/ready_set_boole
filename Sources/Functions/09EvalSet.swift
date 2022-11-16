public class SetElement: Sequence {
  private var _value: [Int32]
  var positive: Bool

  public init(_ value: [Int32], positive: Bool = true) {
    self._value = value
    self.positive = positive
  }

  public var value: [Int32] {
    positive ? _value : []
  }

  public var count: Int {
    _value.count
  }

  public var sorted: SetElement {
    SetElement(_value.sorted(by: <), positive: positive)
  }

  public func toggle() {
    positive.toggle()
  }

  public func contains(_ element: Int32) -> Bool {
    _value.contains(element)
  }

  public func makeIterator() -> IndexingIterator<[Int32]> {
    value.makeIterator()
  }

  // Conjunction
  static func && (A: SetElement, B: SetElement) -> SetElement {
    var result = [Int32]()
    for a in A {
      if B.contains(a) && !result.contains(a) {
        result.append(a)
      }
    }
    for b in B {
      if A.contains(b) && !result.contains(b) {
        result.append(b)
      }
    }
    return SetElement(result)
  }

  // Disjunction
  static func || (A: SetElement, B: SetElement) -> SetElement {
    var result = [Int32]()
    for x in A.value + B.value {
      if !result.contains(x) {
        result.append(x)
      }
    }
    return SetElement(result)
  }

  // Exclusive disjunction
  static func ^ (A: SetElement, B: SetElement) -> SetElement {
    var result = [Int32]()
    for a in A {
      if !B.contains(a) && !result.contains(a) {
        result.append(a)
      }
    }
    for b in B {
      if !A.contains(b) && !result.contains(b) {
        result.append(b)
      }
    }
    return SetElement(result)
  }

  // Material condition
  static func > (A: SetElement, B: SetElement) -> SetElement {
    A.toggle()
    return A || B
  }

  // Logical equivalence
  static func == (A: SetElement, B: SetElement) -> SetElement {
    if A.count != B.count {
      return SetElement([])
    }
    return A.sorted.value == B.sorted.value ? A : SetElement([])
  }

}

public class EvalSet {
  var _value: SetElement

  public var value: [Int32] {
    _value.value
  }

  public init(_ formula: UnsafePointer<String>, _ set: UnsafePointer<[[Int32]]>) throws {
    _value = SetElement([])
    // Test formula for correctness
    let truthTable = TruthTable(formula)
    _ = try truthTable.runTest()

    // Test set for correctness
    let set = set.pointee
    guard truthTable.sortedKeys.count == set.count else {
      if truthTable.sortedKeys.count > set.count {
        throw FormulaError.tooManyValues
      } else {
        throw FormulaError.notEnoughValues
      }
    }

    // Evaluate
    var values = [SetElement]()
    let indexedVariables = truthTable.indexedVariables
    for c in formula.pointee {
      // MARK: - Variables
      if c.isASCIIUpperLetter {
        let i = indexedVariables[c]!
        values.append(SetElement(set[i]))

        // MARK: - Negation
      } else if c == "!" {
        guard values.count > 0 else {
          throw FormulaError.notEnoughValues
        }
        values[values.count - 1].toggle()

        // MARK: - Operators
      } else {
        guard values.count > 0 else {
          throw FormulaError.notEnoughValues
        }
        let B = values.removeLast()
        guard values.count > 0 else {
          throw FormulaError.notEnoughValues
        }
        let A = values.removeLast()

        switch c {
        case "&":
          values.append(A && B)
        case "|":
          values.append(A || B)
        case "^":
          values.append(A ^ B)
        case ">":
          values.append(A > B)
        case "=":
          values.append(A == B)
        default:
          break
        }

      }
    }

    guard values.count > 0 else {
      throw FormulaError.notEnoughValues
    }
    guard values.count == 1 else {
      throw FormulaError.tooManyValues
    }
    _value = values.last!
  }

}

public func eval_set(_ formula: UnsafePointer<String>, _ set: UnsafePointer<[[Int32]]>) throws
  -> [Int32]
{
  let evalSet = try EvalSet(formula, set)
  return evalSet.value
}
