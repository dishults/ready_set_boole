import Utils

public func powerset(_ set: UnsafePointer<[Int32]>) throws -> [[Int32]] {
  var powerSet = [[Int32]]()
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

  return powerSet
}
