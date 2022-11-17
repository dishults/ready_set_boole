import func Functions.map

print(map(0, 0))
print(map(0, UInt16.max))
print(map(UInt16.max, 0))
print(map(UInt16.max, UInt16.max))
print()
print(map(1, 2))
print(map(42, 4200))
print(map(UInt16.max / 2, UInt16.max / 2))
print(map(50000, 500))
