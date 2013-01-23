# Replaces the given locus in the population (from stdin) with the given allele

import sys

def main():
  try:
    pos = int(sys.argv[1]) - 1
    allele = sys.argv[2]
  except IndexError:
    print 'Arguments: pos allele'
    exit(1)

  pop = [genotype.strip() for genotype in sys.stdin]

  for genotype in pop:
    print replace_allele(genotype, pos, allele)


def replace_allele(genotype, pos, allele):
  return genotype[:pos] + allele + genotype[pos + 1:]


main()
