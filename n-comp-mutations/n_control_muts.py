import sys
import csv


def main():
  try:
    control_seqs_path = sys.argv[1]
    ancestor = sys.argv[2]
  except IndexError:
    print 'Arguments: control_seqs_path ancestor'
    exit(1)

  for row in csv.reader(open(control_seqs_path), delimiter = ' '):
    replicate = get_replicate(row)
    sequence = get_sequence(row)
    print count_control_loci(sequence, ancestor)


def get_replicate(row):
  return int(row[0])


def get_sequence(row):
  return row[1]


def count_control_loci(sequence, ancestor):
  count = 0
  for pos in range(len(sequence)):
    if sequence[pos] != ancestor[pos]:
      count += 1
  return count


main()
