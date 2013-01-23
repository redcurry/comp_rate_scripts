#!/usr/bin/python

# Creates all possible single compensatory (and substitution) mutants
# of a sequence (given as an argument) and makes some annotations

import sys

def main():
  try:
    seq = sys.argv[1]
    del_pos = int(sys.argv[2]) - 1
    anc_inst = sys.argv[3]
  except IndexError:
    print 'Arguments: seq del_pos anc_inst'
    exit(1)

  print_single_mutants(seq, del_pos, anc_inst)


def print_single_mutants(seq, del_pos, anc_inst):
  for pos in range(len(seq)):
    for inst in 'abcdefghijklmnopqrstuvwxyz':
      if seq[pos] != inst:
        print mutate(seq, pos, inst),
        if mutation_is_comp(pos, del_pos):
          print 'C'
        elif mutation_is_subs(pos, inst, del_pos, anc_inst):
          print 'S'
        elif mutation_is_rev(pos, inst, del_pos, anc_inst):
          print 'R'
        else:
          print 'Impossible'


def mutate(seq, pos, inst):
  return seq[:pos] + inst + seq[pos + 1:]


def mutation_is_comp(pos, del_pos):
  return pos != del_pos


def mutation_is_subs(pos, inst, del_pos, anc_inst):
  return (pos == del_pos) and (inst != anc_inst)


def mutation_is_rev(pos, inst, del_pos, anc_inst):
  return (pos == del_pos) and (inst == anc_inst)


main()
