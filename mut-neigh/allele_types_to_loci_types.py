# Takes a "types" file (as stdin), which contains the recovery type
# for every possible allele, and converts it into one where
# it shows the loci where a compensatory recovery type occured

import sys


def main():
  pos = 1
  compensated_flag = False
  type_i = 0
  for type in sys.stdin:
    type = type.strip()
    if not compensated_flag:
      if type == 'PC' or type == 'FC':
        print pos
        compensated_flag = True
    type_i += 1
    if type_i == 25:
      pos += 1
      compensated_flag = False
      type_i = 0


main()
