import sys
import random


FULL_REVERSION = 'FR'
FULL_COMPENSATION = 'FC'
FULL_SUBSTITUTION = 'FS'
PARTIAL_COMPENSATION = 'PC'
PARTIAL_SUBSTITUTION = 'PS'
NO_RECOVERY = 'N'
DELETERIOUS = 'D'

FULL_FITNESS = 0.99
NEARLY_NEUTRAL = 0.01


def main():
  try:
    ancestor = sys.argv[1]
    ancestor_fitness = float(sys.argv[2])
    mutant = sys.argv[3]
    mutant_fitness = float(sys.argv[4])
  except IndexError:
    print 'Arguments: ancestor ancestor_fitness mutant mutant_fitness'
    exit(1)

  mutant_rel_fitness = calc_rel_fitness(mutant_fitness, ancestor_fitness)
  mut_pos = determine_mut_pos(mutant, ancestor)

  for line in sys.stdin:
    single_mutant = parse_genotype(line)
    single_mutant_fitness = parse_fitness(line)
    single_mutant_rel_fitness = calc_rel_fitness(single_mutant_fitness, \
      ancestor_fitness)
    type = determine_mutant_type(single_mutant, single_mutant_rel_fitness,
      mutant, mutant_rel_fitness, ancestor, mut_pos)
    print type


def determine_mut_pos(genotype, ancestor):
  for pos in range(len(genotype)):
    if genotype[pos] != ancestor[pos]:
      return pos
  raise Exception, 'Genotype and ancestor are identical'


def calc_rel_fitness(genotype_fitness, ancestor_fitness):
  return genotype_fitness / ancestor_fitness


def parse_genotype(line):
  return line.split()[0]


def parse_fitness(line):
  return float(line.split()[1])


def determine_mutant_type(genotype, genotype_rel_fitness,
    mutant, mutant_rel_fitness, ancestor, mut_pos):
  if full_reversion(genotype, genotype_rel_fitness, ancestor, mut_pos):
    return FULL_REVERSION
  elif full_compensation(genotype, genotype_rel_fitness, \
      mutant, mutant_rel_fitness, mut_pos):
    return FULL_COMPENSATION
  elif partial_compensation(genotype, genotype_rel_fitness, \
      mutant, mutant_rel_fitness, mut_pos):
    return PARTIAL_COMPENSATION
  elif full_substitution(genotype, genotype_rel_fitness, \
      mutant, ancestor, mut_pos):
    return FULL_SUBSTITUTION
  elif partial_substitution(genotype, genotype_rel_fitness, \
      mutant, mutant_rel_fitness, ancestor, mut_pos):
    return PARTIAL_SUBSTITUTION
  elif no_recovery(genotype_rel_fitness, mutant_rel_fitness):
    return NO_RECOVERY
  elif deleterious(genotype_rel_fitness, mutant_rel_fitness):
    return DELETERIOUS
  else:
    return NO_RECOVERY
#    raise Exception, 'Unknown mutant type ' + \
#      genotype[mut_pos] + ' ' + mutant[mut_pos] + ' ' + ancestor[mut_pos] + \
#      ' ' + str(genotype_rel_fitness) + ' ' + str(mutant_rel_fitness)


def full_reversion(genotype, genotype_rel_fitness, ancestor, mut_pos):
  return same_allele(genotype, ancestor, mut_pos) and \
    full_fitness(genotype_rel_fitness)


def full_compensation(genotype, genotype_rel_fitness, \
    mutant, mutant_rel_fitness, mut_pos):
  return same_allele(genotype, mutant, mut_pos) and \
    full_fitness(genotype_rel_fitness)


def partial_compensation(genotype, genotype_rel_fitness, \
    mutant, mutant_rel_fitness, mut_pos):
  return same_allele(genotype, mutant, mut_pos) and \
    partial_fitness(genotype_rel_fitness, mutant_rel_fitness)


def full_substitution(genotype, genotype_rel_fitness, \
    mutant, ancestor, mut_pos):
  return not same_allele(genotype, mutant, mut_pos) and \
    not same_allele(genotype, ancestor, mut_pos) and \
    full_fitness(genotype_rel_fitness)


def partial_substitution(genotype, genotype_rel_fitness, \
    mutant, mutant_rel_fitness, ancestor, mut_pos):
  return not same_allele(genotype, mutant, mut_pos) and \
    not same_allele(genotype, ancestor, mut_pos) and \
    partial_fitness(genotype_rel_fitness, mutant_rel_fitness)


def no_recovery(genotype_rel_fitness, mutant_rel_fitness):
  return no_fitness(genotype_rel_fitness, mutant_rel_fitness)


def same_allele(genotype_1, genotype_2, pos):
  return genotype_1[pos] == genotype_2[pos]


def full_fitness(genotype_rel_fitness):
  return genotype_rel_fitness > FULL_FITNESS


def partial_fitness(genotype_rel_fitness, mutant_rel_fitness):
  return mutant_rel_fitness < genotype_rel_fitness < FULL_FITNESS


def no_fitness(genotype_rel_fitness, mutant_rel_fitness):
  return abs(genotype_rel_fitness - mutant_rel_fitness) < NEARLY_NEUTRAL


def deleterious(genotype_rel_fitness, mutant_rel_fitness):
  return genotype_rel_fitness < mutant_rel_fitness


main()
