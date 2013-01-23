# Prints 1 if population (given as stdin) has allele frequency of > 0.95


import sys


def main():
  try:
    pos = int(sys.argv[1]) - 1
    allele = sys.argv[2]
  except IndexError:
    print 'Arguments: pos allele'
    exit(1)

  pop = get_seqs(sys.stdin)
  if (allele_freq(pop, pos, allele) > 0.95):
    print 1
  else:
    print 0


def get_seqs(stream):
  return [line.strip() for line in stream]


def allele_freq(pop, pos, allele):
  return float(allele_count(pop, pos, allele)) / len(pop)


def allele_count(pop, pos, allele):
  return len([1 for seq in pop if has_allele(seq, pos, allele)])


def has_allele(seq, pos, allele):
  return seq[pos] == allele


main()
