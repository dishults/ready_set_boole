import Utils

public func powerset(_ set: inout [Int32]) throws -> [[Int32]] {
  // Check the set contains only unique values
  var uniqueValues = [Int32]()
  for n in set {
    guard !uniqueValues.contains(n) else {
      throw SetError.duplicateValue(n)
    }
    uniqueValues.append(n)
  }

  // Build power set
  var powerSet = [[Int32]]()
  let powerSetSize = try UInt32(2).pow(UInt32(set.count)) - 1
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
