# Count the number of revertant mutations in given population

import sys

def main():
  try:
    pos = int(sys.argv[1]) - 1
    allele = sys.argv[2]
  except IndexError:
    print 'Arguments: pos allele'
    exit(1)

  pop = read_population(sys.stdin)
  print count_rev(pop, pos, allele)


def read_population(in_stream):
  return [genotype.strip() for genotype in in_stream]


def count_rev(pop, pos, allele):
  return len([1 for genotype in pop if has_allele(genotype, pos, allele)])


def has_allele(genotype, pos, allele):
  return genotype[pos] == allele


main()
