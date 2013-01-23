# Outputs the frequency of the specified allele
# Input (stdin): list of sequences


import sys


def main():
  try:
    pos = int(sys.argv[1]) - 1
    allele = sys.argv[2]
  except IndexError:
    print 'Arguments: pos allele'
    exit(1)

  allele_count = 0
  seq_count = 0

  for seq in sys.stdin:
    if seq_has_allele(seq, pos, allele):
      allele_count += 1
    seq_count += 1

  print float(allele_count) / seq_count


def seq_has_allele(seq, pos, allele):
  return seq[pos] == allele


main()
