# Parses a lineage file and outputs the fitness of a sequence
# relative to its immediate parent (first sequence is 1.0)

import sys
import csv


COMMENT_CHAR = '#'
FITNESS_INDEX = 3


def main():
  try:
    lineage_path = sys.argv[1]
  except IndexError:
    print 'Arguments: lineage_path'
    exit(1)

  last_fitness = -1
  for line in csv.reader(open(lineage_path), delimiter = ' '):
    if comment_or_blank(line):
      continue

    fitness = float(line[FITNESS_INDEX])

    if last_fitness >= 0:
      print fitness / last_fitness

    last_fitness = fitness


def comment_or_blank(line):
  if len(line) == 0 or line[0].startswith('#'):
    return True
  else:
    return False


main()
