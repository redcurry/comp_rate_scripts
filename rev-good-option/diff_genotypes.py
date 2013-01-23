# Prints the per locus differences between genotypes

import sys

def main():
  try:
    seq_1 = sys.argv[1]
    seq_2 = sys.argv[2]
  except IndexError:
    print 'Arguments: seq_1 seq_2'
    exit(1)

  for pos in range(len(seq_1)):
    if seq_1[pos] != seq_2[pos]:
      print pos + 1, seq_1[pos], '!=', seq_2[pos]


main()
