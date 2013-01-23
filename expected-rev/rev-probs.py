# Calculate the probability of a revertant mutation appearing
# within 100 updates, given the "rev-updates" file


import sys
import random


def main():
  try:
    rev_updates_path = sys.argv[1]
  except:
    print 'Arguments: rev_updates_path'
    exit(1)

  rev_probs = calc_rev_probs(rev_updates_path)
  print_list(rev_probs)


def calc_rev_probs(rev_updates_path):
  return probs(counts(read_updates_binned(rev_updates_path)))


def probs(list):
  return [float(a) / 100 for a in list]


def counts(list):
  return [count(a, list) for a in set(list)]


def count(a, list):
  return len([1 for i in list if i == a])


def read_updates_binned(rev_updates_path):
  return [int(update) / 100 for update in open(rev_updates_path)]


def print_list(list):
  for a in list:
    print a


main()
