import Utils

public class PowerSet: CustomStringConvertible {
  var powerSet: [[Int32]]

  public init(_ set: UnsafePointer<[Int32]>) throws {
    powerSet = []
    let set = set.pointee
    guard set.count <= 31 else {
      throw FormulaError.tooManyValues
    }

    let powerSetSize = UInt32(2).pow(UInt32(set.count)) - 1
    let zerosPadding = powerSetSize.binary.count
    for n in 0...powerSetSize {
      var subset = [Int32]()
      n.binary.addPadding(with: "0", maxCount: zerosPadding).allIndexes(of: "1").forEach { i in
        subset.append(set[i])
      }
      powerSet.append(subset)
    }
  }

  public var description: String {
    return "\(powerSet)"
  }
}

public func powerset(_ set: UnsafePointer<[Int32]>) throws -> [[Int32]] {
  let ps = try PowerSet(set)
  return ps.powerSet
}
