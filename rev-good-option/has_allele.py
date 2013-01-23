# Prints 1 if any sequence (given as stdin) has the given allele;
# otherwise, prints 0


import sys


def main():
  try:
    pos = int(sys.argv[1]) - 1
    allele = sys.argv[2]
  except IndexError:
    print 'Arguments: pos allele'
    exit(1)

  for seq in sys.stdin:
    if has_allele(seq, pos, allele):
      print 1
      break
  else:
    print 0


def has_allele(seq, pos, allele):
  return seq[pos] == allele


main()
