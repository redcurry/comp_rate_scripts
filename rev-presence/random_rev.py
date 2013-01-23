# Given the population, prints a random revertant if there is one

import sys
import random

def main():
  try:
    pos = int(sys.argv[1]) - 1
    allele = sys.argv[2]
  except IndexError:
    print 'Arguments: pos allele'
    exit(1)

  pop = read_population(sys.stdin)
  revertants = get_revertants(pop, pos, allele)
  if len(revertants) > 0:
    print random.choice(revertants)
  else:
    print


def read_population(in_stream):
  return [genotype.strip() for genotype in in_stream]


def get_revertants(pop, pos, allele):
  return [genotype for genotype in pop if has_allele(genotype, pos, allele)]


def has_allele(genotype, pos, allele):
  return genotype[pos] == allele


main()
