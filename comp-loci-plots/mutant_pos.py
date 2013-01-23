import sys


try:
  ancestor = sys.argv[1]
  mutant = sys.argv[2]
except IndexError:
  print 'Arguments: ancestor mutant'
  exit(1)

for pos in range(len(ancestor)):
  if mutant[pos] != ancestor[pos]:
    print pos + 1
