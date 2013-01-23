import sys
import random


INST_SET = list('abcdefghijklmnopqrstuvwxyz')


def main():
  try:
    genotype = sys.argv[1]
  except IndexError:
    print 'Arguments: genotype'
    exit(1)

  for pos in range(len(genotype)):
    for inst in INST_SET:
      if genotype[pos] != inst:
        print create_single_mutant(genotype, pos, inst)


def create_single_mutant(genotype, pos, inst):
  return genotype[:pos] + inst + genotype[pos + 1:]


main()
