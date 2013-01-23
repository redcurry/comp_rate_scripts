import sys
import csv


def main():
  try:
    control_seqs_path = sys.argv[1]
    ancestor = sys.argv[2]
  except IndexError:
    print 'Arguments: control_seqs_path ancestor'
    exit(1)

  control_loci_counts = [0 for i in ancestor]

  for row in csv.reader(open(control_seqs_path), delimiter = ' '):
    replicate = get_replicate(row)
    sequence = get_sequence(row)
    count_control_loci(control_loci_counts, sequence, ancestor)

  for pos in range(len(control_loci_counts)):
    print pos + 1, control_loci_counts[pos]


def get_replicate(row):
  return int(row[0])


def get_sequence(row):
  return row[1]


def count_control_loci(control_loci_counts, sequence, ancestor):
  for pos in range(len(control_loci_counts)):
    if sequence[pos] != ancestor[pos]:
      control_loci_counts[pos] += 1


main()
