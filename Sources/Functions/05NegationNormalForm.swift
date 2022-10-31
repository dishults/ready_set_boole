import Utils

public class NNF {
  var formula: String
  var nnf: [Character]

  public init(_ formula: UnsafePointer<String>) {
    self.formula = formula.pointee.uppercased()
    nnf = []
  }

  public func getConvertedFormula() -> String {
    return String(nnf)
  }

  /// Test formula for correctness
  func runBasicChecks() throws {
    let truthTable = TruthTable(&formula)
    _ = try truthTable.runTest()
  }

  func runBasicConversion() throws {
    var n = 0
    for c in formula {
      if c == ">" {
        nnf.insert("!", at: n - 1)
        n += 1
        nnf.append("|")

      } else if c == "!" && nnf[n - 1] == "!" {
        nnf.removeLast()
        n -= 2

      } else if c == "=" {
        let A = nnf[n - 2]
        let B = nnf[n - 1]
        nnf.append(contentsOf: ["&", A, "!", B, "!", "&", "|"])

      } else {
        nnf.append(c)
      }

      n += 1
    }
  }

  func runDeMorganConversion() throws {
    var n = 0
    for c in nnf {
      if c == "!" {
        let c2 = nnf[n - 1]
        if c2 == "!" {
          nnf.removeSubrange(n - 1..<n)
          n -= 2
        } else if "&|".contains(c2) {
          nnf.remove(at: n)
          n -= 1
          try convert(n)
          try runDeMorganConversion()
          break
        }
      }
      n += 1
    }
  }

  func convert(_ n: Int) throws {
    var n = n
    while n > 0 {
      if "&|".contains(nnf[n]) {
        nnf[n] = nnf[n] == "&" ? "|" : "&"
        n -= 1
        if nnf[n].isASCIIUpperLetter {
          nnf.insert("!", at: n + 1)
          n -= 1
          if "&|".contains(nnf[n]) || nnf[n].isASCIIUpperLetter {
            nnf.insert("!", at: n + 1)
          } else if nnf[n] == "!" {
            nnf.remove(at: n)
          }
          break
        }
      }
      n -= 1
    }
  }

}

public func negation_normal_form(_ formula: UnsafePointer<String>) throws -> String {
  let nnf = NNF(formula)
  try nnf.runBasicChecks()
  try nnf.runBasicConversion()
  try nnf.runDeMorganConversion()
  return nnf.getConvertedFormula()
}
