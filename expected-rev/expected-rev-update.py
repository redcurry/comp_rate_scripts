import sys
import random


def main():
  try:
    rev_effects_path = sys.argv[1]
  except:
    print 'Arguments: rev_effects_path'
    exit(1)

  rev_effects = read_rev_effects(rev_effects_path)

  for rep in range(100):
    probs = []
    prob_no_rev = 1.0
    for rev_effect in rev_effects:
      fixation_prob = calc_fixation_prob(rev_effect)
      prob = pick_rev_prob() * fixation_prob * prob_no_rev
      probs.append(prob)
      prob_no_rev *= 1 - prob
    print expected_update(probs)


def read_rev_effects(rev_effects_path):
  return [float(effect) for effect in open(rev_effects_path)]


def expected_update(probs):
  update = 100
  for i in range(len(probs)):
    if random.random() < probs[i]:
      return update
    update += 100
  else:
    return 10000


def calc_fixation_prob(s):
  if s < 0:
    return 0.0
  elif s < 0.28:
    return random.normalvariate(1.813 * s, 0.09584)
  else:
    return random.normalvariate(0.43823 + 0.24137 * s, 0.06425)


def pick_rev_prob():
  return random.normalvariate(0.1915, 0.04427588)


main()
