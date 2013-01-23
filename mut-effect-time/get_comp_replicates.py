import sys
import csv


STATUS_OTHER = 0
STATUS_COMPENSATED = 1


def main():
  try:
    comp_status_path = sys.argv[1]
    anc_id = sys.argv[2]
    treat_value = sys.argv[3]
    mut_id = sys.argv[4]
  except IndexError:
    print 'Arguments: comp_status_path anc_id treat_value mut_id'
    exit(1)

  comp_status = get_comp_status(comp_status_path, anc_id, treat_value, mut_id)

  for i in range(len(comp_status)):
    replicate = i + 1
    if replicate_is_compensated(comp_status, replicate):
      print replicate


def get_comp_status(comp_status_path, anc_id, value, mut_id):
  comp_status = []
  for row in csv.DictReader(open(comp_status_path), delimiter = ' '):
    if is_desired_row(row, anc_id, value, mut_id):
      if status_is_compensated(row):
        comp_status.append(STATUS_COMPENSATED)
      else:
        comp_status.append(STATUS_OTHER)
  return comp_status


def is_desired_row(row, anc_id, value, mut_id):
  if row['Ancestor'] == anc_id and \
     row['Value'] == value and \
     row['MutReplicate'] == mut_id:
    return True
  return False


def status_is_compensated(row):
  return row['Type'] == 'C'


def get_replicate(row):
  return int(row[0])


def replicate_is_compensated(comp_status, replicate):
  return comp_status[replicate - 1] == STATUS_COMPENSATED


main()
