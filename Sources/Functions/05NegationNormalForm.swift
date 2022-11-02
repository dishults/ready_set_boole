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
    var n2 = 0
    func getVar() -> [Character] {
      if nnf[n2].isASCIIUpperLetter {
        n2 -= 1
        return [nnf[n2 + 1]]
      } else if nnf[n2] == "!" && nnf[n2 - 1].isASCIIUpperLetter {
        n2 -= 2
        return [nnf[n2 + 1], "!"]
      } else if nnf[n2 + 1] == "!" && "&|".contains(nnf[n2]) {
        return []  // TODO
      } else {
        return []
      }
    }

    var n = 0
    for c in formula {
      if c == ">" {
        n2 = n - 1
        let B = getVar()
        if nnf[n - B.count - 1] == "!" {
          nnf.remove(at: n - B.count - 1)
          n -= 1
        } else {
          nnf.insert("!", at: n - B.count)
          n += 1
        }
        nnf.append("|")

      } else if c == "!" && nnf[n - 1] == "!" {
        nnf.removeLast()
        n -= 2

      } else if c == "=" {
        n2 = n - 1
        let B1 = getVar()
        let B2 = B1.count == 1 ? B1 + ["!"] : [B1[0]]
        let A1 = getVar()
        let A2 = A1.count == 1 ? A1 + ["!"] : [A1[0]]
        nnf.append(contentsOf: ["&"] + A2 + B2 + ["&", "|"])

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
