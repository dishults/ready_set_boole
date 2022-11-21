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

// MARK: -

extension Bool {
  public static func ^ (left: Bool, right: Bool) -> Bool {
    return (left || right) && !(left && right)
  }

  public static func > (left: Bool, right: Bool) -> Bool {
    return !left || right
  }
}

// MARK: -

extension Character {
  public var isASCIIUpperLetter: Bool {
    let asciiValue = self.asciiValue ?? 0
    return asciiValue > 64 && asciiValue < 91
  }
}

// MARK: -

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

// MARK: -

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

  public func pow(_ right: UInt32) throws -> UInt32 {
    if right == 0 {
      return 1
    }

    var res: UInt32 = self
    let maxValue = UInt32.max / 2
    for _ in 1..<right {
      guard res < maxValue else {
        throw FormulaError.tooManyValues
      }
      res *= self
    }
    return res
  }

  public var sqrt: UInt32 {
    if self == 0 || self == 1 {
      return self
    }
    var i: UInt64 = 2
    while i * i < self {
      i += 1
    }
    return i * i == self ? UInt32(i) : UInt32(i - 1)
  }
}
