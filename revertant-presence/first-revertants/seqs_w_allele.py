# Outputs the frequency of the specified allele


import sys
import os


UPDATES = [1] + range(100, 10100, 100)  # 1, 100, 200, ..., 10000


def main():
  try:
    loc_file = sys.argv[1]
    pos = int(sys.argv[2]) - 1
    allele = sys.argv[3]
    prepend = sys.argv[4]
  except IndexError:
    print 'Arguments: loc_file pos allele prepend'
    exit(1)

  for update in UPDATES:
    seqs = get_sequences(loc_file, update)
    revs = get_seqs_w_allele(seqs, pos, allele)
    if len(revs) > 0:
      print_seqs(revs, update, prepend)
      break


def get_sequences(loc_file, update):
  return [line.strip() for line in get_seqs_stream(loc_file, update)]


def get_seqs_stream(loc_file, update):
  return os.popen(get_shell_cmd(loc_file, update))


def get_shell_cmd(loc_file, update):
  return 'cat %s | loc_at_update.sh %d | loc2seqs.sh' % (loc_file, update)


def get_seqs_w_allele(seqs, pos, allele):
  return [seq for seq in seqs if seq_has_allele(seq, pos, allele)]


def seq_has_allele(seq, pos, allele):
  return seq[pos] == allele


def print_seqs(seqs, update, prepend):
  for seq in seqs:
    print prepend, update, seq


main()
