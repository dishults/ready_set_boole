public class CNF: CustomStringConvertible {
  var value: Combo

  public init(_ formula: UnsafePointer<String>) throws {
    let nnf = try NNF(formula)
    value = nnf.value
  }

  public var description: String {
    return "\(value)"
  }
}

public func conjunctive_normal_form(_ formula: UnsafePointer<String>) throws -> String {
  let cnf = try CNF(formula)
  return String(describing: cnf)
}
