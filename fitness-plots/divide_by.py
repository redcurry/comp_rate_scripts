import sys

try:
  divisor = float(sys.argv[1])
except IndexError:
  print 'Arguments: divisor'
  exit(1)

for numerator in sys.stdin:
  print float(numerator) / divisor
