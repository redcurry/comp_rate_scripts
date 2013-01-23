# Outputs HTML code to standard input where specified sequences
# are colored based on their differences with the first sequence;
# sequences are obtained from the standard input

import sys


INST_COLORS = {
  'a': 'ff0000',
  'b': 'ff3700',
  'c': 'ff6e00',
  'd': 'ffa600',
  'e': 'ffdd00',
  'f': 'eaff00',
  'g': 'b2ff00',
  'h': '7bff00',
  'i': '44ff00',
  'j': '0dff00',
  'k': '00ff2a',
  'l': '00ff62',
  'm': '00ff99',
  'n': '00ffd0',
  'o': '00f7ff',
  'p': '00bfff',
  'q': '0088ff',
  'r': '0051ff',
  's': '0019ff',
  't': '1e00ff',
  'u': '5500ff',
  'v': '8c00ff',
  'w': 'c300ff',
  'x': 'fb00ff',
  'y': 'ff00cc',
  'z': 'ff0095'
}


def print_style():

  print '<style type = "text/css">'

  for inst in INST_COLORS:
    print 'span.' + inst + '-back ' + \
      '{ background-color: #' + INST_COLORS[inst] + '; font-family: courier }'

  # No background style
  print 'span.white-back { background-color: #ffffff; font-family: courier }'

  print '</style>'


def print_sequence(seq, orig_seq):

  sys.stdout.write('<span class = "white-back">')
  prevInstWasWhite = True
  for inst, orig_inst in zip(seq, orig_seq):
    if inst != orig_inst:
      if prevInstWasWhite:
        sys.stdout.write('</span>')
      sys.stdout.write('<span class = "' + inst + '-back">' + inst + '</span>')
      prevInstWasWhite = False
    else:
      if prevInstWasWhite:
        sys.stdout.write(inst)
      else:
        sys.stdout.write('<span class = "white-back">' + inst)
      prevInstWasWhite = True


# Write heading
print '<html>'

# Write head
print '<head>'
print_style()
print '</head>'

# Write body
print '<body>'
print '<p>'

# Print out each sequence (colored)
first_seq = True
for seq in sys.stdin:
  if first_seq:
    orig_seq = seq
    first_seq = False

  print_sequence(seq, orig_seq)
  print ''

# Write closing
print '</p>'
print '</body>'
print '</html>'
