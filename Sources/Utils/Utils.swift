extension Array {
  public var cellsLine: String {
    var line = ""
    for cell in self {
      line.append("| \(cell) ")
    }
    line.append("|")
    return line
  }

  public func addPadding(with element: Element, maxCount: Int) -> [Element] {
    var padding = maxCount - count
    padding = padding >= 0 ? padding : 0
    return Array(repeating: element, count: padding) + self
  }

  public mutating func popRange(_ bounds: Range<Int>) -> [Element] {
    let slice = self[bounds]
    self.removeSubrange(bounds)
    return Array(slice)
  }
}

extension Character {
  public var isASCIIUpperLetter: Bool {
    let asciiValue = self.asciiValue ?? 0
    return asciiValue > 64 && asciiValue < 91
  }
}

extension Collection where Element: Equatable {
  public func allIndexes(of target: Element) -> [Int] {
    var indexes = [Int]()
    for (n, element) in enumerated() {
      if element == target {
        indexes.append(n)
      }
    }
    return indexes
  }
}

extension UInt32 {
  public var binary: [Character] {
    var remainders = [Character]()
    var decimal = self
    while decimal > 0 {
      let remainder: Character = ((decimal % 2) == 0) ? "0" : "1"
      remainders.append(remainder)
      decimal = decimal / 2
    }
    return remainders.reversed()
  }

  public var info: String {
    "\(self) (\(String(self.binary)))"
  }

  public func pow(_ right: UInt32) -> UInt32 {
    if right == 0 {
      return 1
    }

    var res: UInt32 = self
    for _ in 1..<right {
      res *= self
    }
    return res
  }
}

public func printInfixDescription(_ description: String, terminator: String = "\n") {
  var description = description
  description.removeFirst()
  description.removeLast()
  print(description, terminator: terminator)
}
