# Compares the given sequence (as an argument) against
# a list of sequences (from stdin) and prints 1 if they match; 0 otherwise
# If the sequences given are single mutants, then this script
# won't handle double-mutants properly

import sys

def main():
  try:
    seq = sys.argv[1]
  except IndexError:
    print 'Arguments: seq'
    exit(1)

  for candidate_seq in sys.stdin:
    print 1 if seq == candidate_seq.strip() else 0


main()
