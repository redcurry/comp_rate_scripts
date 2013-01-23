# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 1)
{
  print('Arguments: ancestor_id')
  q()
}

ancestor_id = args[1]

treatments = c('0.1', '0.3', '0.5', '0.7', '0.9')
mutants = c(1, 2)

for(treatment_i in seq(length(treatments)))
{
  treatment = treatments[treatment_i]

  for(mutant in mutants)
  {
    if(treatment == '0.5')
      treatment_name = 'default'
    else
      treatment_name = paste(sep = '', 'W-', treatment)

    input_file = paste(sep = '', 'mut_fits/', treatment_name, '/types-',
      ancestor_id, '-', mutant)
    data = read.table(input_file, header = F)
    comp_count = length(data[data$V1 == 'PC' | data$V1 == 'FC',])

    print(paste(sep = ' ', ancestor_id, mutant, treatment, comp_count),
      quote = F)
  }
}
