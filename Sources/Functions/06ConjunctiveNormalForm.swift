extension Combo {
  public func distribute() {
    // E.g. A | (B & C)  ->  (A | B) & (A | C)
    if type(of: B) == Combo.self {
      let a = A.copy()
      let b = B as! Combo
      A = Combo(A: a, op: op.copy() as! Char, B: b.A)
      B = Combo(A: a.copy(), op: op.copy() as! Char, B: b.B)
    } else if type(of: A) == Combo.self {
      let a = A as! Combo
      let b = B.copy()
      A = Combo(A: a.A, op: op.copy() as! Char, B: b.copy())
      B = Combo(A: a.B, op: op.copy() as! Char, B: b)
    } else {
      return
    }

    op.toggleOperator()
  }

  public func changeComboStructure() {
    // E.g. (A | B) | C  ->  A | (B | C)
    guard type(of: A) == Combo.self else {
      return
    }
    let a = A as! Combo
    let newA = a.A
    B = Combo(A: a.B, op: a.op, B: B)
    A = newA
  }

  public func convertToCNF() {
    if type(of: A) == Combo.self {
      let a = (A as! Combo)
      a.convertToCNF()
      if a.op.value == op.value && type(of: B) == Char.self {
        changeComboStructure()
        convertToCNF()
      } else if op.value == "|" && a.op.value == "&" {
        distribute()
        convertToCNF()
      }
    }

    if type(of: B) == Combo.self {
      let b = B as! Combo
      b.convertToCNF()
      if op.value == "|" && b.op.value == "&" {
        distribute()
        convertToCNF()
      }
    }
  }

}

public class CNF: CustomStringConvertible {
  var value: Combo

  public init(_ formula: UnsafePointer<String>) throws {
    // Test formula for correctness
    let nnf = try NNF(formula)
    // Init value
    value = nnf.value
    // Convert value to CNF
    value.convertToCNF()
  }

  public var description: String {
    return "\(value)"
  }
}

public func conjunctive_normal_form(_ formula: UnsafePointer<String>) throws -> String {
  let cnf = try CNF(formula)
  return String(describing: cnf)
}
