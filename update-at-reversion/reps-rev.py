# Output replicates that reverted

import sys
import pandas


REV_COMP_SUB_PATH = '/mnt/home/carlosja/experiments/comp_rate/analysis/rev_comp_sub/results/W'


def main():
  try:
    anc = int(sys.argv[1])
    treat = float(sys.argv[2])
    mut = int(sys.argv[3])
  except IndexError:
    print 'Arguments: anc treat mut'
    exit(1)

  for row_index, row in relevant_data(read_data(), anc, treat, mut).iterrows():
    if reverted(row):
      print row['Replicate']


def read_data():
  return pandas.read_csv(REV_COMP_SUB_PATH, sep = ' ')


def relevant_data(data, anc, treat, mut):
  return data[(data.Ancestor == anc) & (data.Value == treat) \
    & (data.MutReplicate == mut)]


def reverted(row):
  return row['Type'] == 'R'


main()
