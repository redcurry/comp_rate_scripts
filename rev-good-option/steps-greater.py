# Given a list of fitness pairs (as stdin),
# prints out the step in which the second fitness (i.e., revertant)
# is greater than the first fitness

import sys


def main():
  step = 0
  for fit_pair_str in sys.stdin:
    mut_fit, rev_fit = to_pair(fit_pair_str)
    if rev_fit > mut_fit:
      step += 1
    else:
      print step
      break
  else:
    print step


def to_pair(arg):
  return arg.strip().split()


main()
