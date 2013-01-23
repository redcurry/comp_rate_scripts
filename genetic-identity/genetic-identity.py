# Calculates the genetic identity of the two given sequences

import sys

try:
  seq_1 = sys.argv[1]
  seq_2 = sys.argv[2]
except IndexError:
  print 'Arguments: seq_1 seq_2'
  exit(1)

assert len(seq_1) == len(seq_2)

genome_length = len(seq_1)

identity = 0
for i in range(genome_length):
  if seq_1[i] == seq_2[i]:
    identity += 1

print float(identity) / genome_length
