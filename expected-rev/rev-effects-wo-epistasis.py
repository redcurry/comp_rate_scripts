import os
import sys
import random


def main():
  try:
    loc_path = sys.argv[1]
    anc_fitness = float(sys.argv[2])
  except:
    print 'Arguments: loc_path anc_fitness'
    exit(1)

  midpoints = midpoint_estimate(mean_rel_fitness_time(loc_path, anc_fitness))
  rev_effects = calc_effect(midpoints)
  for effect in rev_effects:
    print effect


def midpoint_estimate(nums):
  return [(nums[i] + nums[i - 1]) / 2.0 for i in range(1, len(nums))]


def mean_rel_fitness_time(loc_path, anc_fitness):
  return [mean_rel_fitness(loc_path, update, anc_fitness)
    for update in [1] + range(100, 10100, 100)]


def calc_effect(nums):
  return [1 - num for num in nums]


def mean_rel_fitness(loc_path, update, anc_fitness):
  return mean(rel_fitness(calc_fitnesses(loc_path, update), anc_fitness))


def mean(nums):
  return float(sum(nums)) / len(nums)


def rel_fitness(fitnesses, anc_fitness):
  return [fitness / anc_fitness for fitness in fitnesses]


def calc_fitnesses(path, update):
  return strings_to_floats(read_fitnesses(path, update))


def strings_to_floats(strings):
  return [float(string) for string in strings]


def read_fitnesses(path, update):
  return os.popen(calc_fitness_cmd(path, update)).readlines()


def calc_fitness_cmd(path, update):
  return "cat %s | loc_at_update.sh %d | loc2seqs.sh |" \
    "calc_fitness ~/avida-2.9.0/bin ~/config/comp_rate" % (path, update)


main()
