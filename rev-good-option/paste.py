# Similar to bash's paste, but works on its arguments (should be multi-line)


import sys


def main():
  string_lists = to_string_lists(sys.argv[1:])
  for line_i in range(max_lines(string_lists)):
    print_line(string_lists, line_i)


def to_string_lists(args):
  return [arg.split('\n') for arg in args]


def max_lines(args):
  return max([len(arg) for arg in args])


def print_line(string_lists, line_i):
  for string_list in string_lists:
    print_item(string_list, line_i)
  print


def print_item(string_list, line_i):
  if line_i < len(string_list):
    print string_list[line_i],
  else:
    print ' ',


main()
