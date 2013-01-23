import os
import sys
import random


def main():
  try:
    input_path = sys.argv[1]
  except:
    print 'Arguments: input_path'
    exit(1)

  rev_effects = calc_effects(input_path)
  midpoints = midpoint_estimate(rev_effects)

  for effect in midpoints:
    print effect


def calc_effects(input_path):
  return [anc_fitness(line) - pop_fitness(line) for line in open(input_path)]


def anc_fitness(line):
  return float(line.split()[6])


def pop_fitness(line):
  return float(line.split()[5])


def midpoint_estimate(nums):
  return [mean([nums[i], nums[i - 1]]) for i in range(1, len(nums))]


def mean(nums):
  return float(sum(nums)) / len(nums)


main()
