import os
import os.path

#ancestors = ['1', '2']
#mutants = ['1', '2']
#treatments = ['0.1', '0.3', '0.5', '0.7', '0.9']

ancestors = ['1']
mutants = ['1']
treatments = ['0.9']

updates = [1] + range(100, 10100, 100)
replicates = range(1, 101)

data_path = "/mnt/home/carlosja/experiments/comp_rate/data"

print 'Ancestor Treatment Mutant Replicate Update'

def main():
  for ancestor in ancestors:
    anc_seq = read_sequence(anc_path(ancestor))
    for treatment in treatments:
      for mutant in mutants:
        mut_seq = read_sequence(mut_path(ancestor, treatment, mutant))
        pos, inst = mut_pos(anc_seq, mut_seq)
        for rep in rev_replicates(ancestor, treatment, mutant):
          pop_path = loc_path(ancestor, treatment, mutant, rep)
          print ancestor, treatment, mutant, rep, \
            update_at_reversion(pop_path, pos, inst)



def anc_path(ancestor):
  return os.path.join(data_path, "ancestors/default", ancestor)


def mut_path(ancestor, treatment, mutant):
  return os.path.join(data_path, "mutants/default", ancestor, treatment, mutant)


def read_sequence(path):
  return [line.strip() for line in open(path)][0]


def mut_pos(anc_seq, mut_seq):
  mut_diff = get_stdout(os.popen("python diff_genotypes.py %s %s" % \
    (anc_seq, mut_seq)))
  mut_pos = int(mut_diff.split()[0])
  anc_inst = mut_diff.split()[1]
  return (mut_pos, anc_inst)


def loc_path(ancestor, treatment, mutant, rep):
  return os.path.join(data_path, 'raw', 'W-' + str(treatment), \
    ancestor, mutant, 'data', rep, 'location.dat')


def rev_replicates(ancestor, treatment, mutant):
  return get_stdout(os.popen('python reps-rev.py %s %s %s' % \
    (ancestor, treatment, mutant))).split()


def update_at_reversion(path, pos, inst):
  for update in updates:
    rev_freq = allele_freq(path, pos, inst, update)
    if rev_freq > 0.1:
      return update


def allele_freq(path, pos, inst, update):
  return float(get_stdout(os.popen('cat %s | loc_at_update.sh %d | '
    'loc2seqs.sh | python allele_freq.py %d %s' % (path, update, pos, inst))))


def get_stdout(open_pipe):
  return open_pipe.read().strip()


main()
