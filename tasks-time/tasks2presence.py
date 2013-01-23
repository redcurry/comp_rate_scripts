# Prints presence (1) or absence (0) of each task

import sys


TASKS = ['not', 'nand', 'and', 'orn', 'or', 'andn', 'nor', 'xor', 'equ']


def main():
  for line in sys.stdin:
    tasks = line.split()
    for task in TASKS:
      print 1 if task in tasks else 0,
    print


main()
