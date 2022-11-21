public func printInfixDescription(_ description: String, terminator: String = "\n") {
  var description = description
  if description.count > 2 {
    description.removeFirst()
    description.removeLast()
  }
  print(description, terminator: terminator)
}
