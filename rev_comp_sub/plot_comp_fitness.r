# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 3)
{
  print('Arguments: input_file output_file ancestor treat_name')
  q()
}

# First argument is the input file,
# second argument is the output (plot) file,
# third argument is the treatment variable,
# fourth argument is the ancestor number,
# fifth argument is the treatment display name
input_file = args[1]
output_file = args[2]
ancestor = args[3]
treat_name = args[4]

# Set up PDF document to output
pdf(file = output_file, width = 4, height = 4)
par(mar = c(5, 5, 1, 1))

# Read data (contains column headers)
data = read.table(input_file, header = T)

# Look at one ancestor only
data = data[data$Ancestor == ancestor,]

# Get the possible treatment values, e.g., c(10, 100, 1000, 10000)
treat_values = sort(unique(data$Value))
treat_values

# Choose rows for which full or partial compensation occurred
data = data[(data$Recovery == 'F' | data$Recovery == 'P') &
  data$Type == 'C',]

boxplot(data$FinalFitness ~ data$Value,
  xlab = treat_name,
  ylab = 'Final relative fitness',
  ylim = c(0, 1))

# Plot things
#barx = barplot(height,
#  names.arg = prettyNum(treat_values, big.mark = ',',
#    preserve.width = 'individual'),
#  xlab = treat_name,
#  ylab = 'Proportion',
#  ylim = c(0, 1),
#  space = 0.5,
#  col = c('darkblue', 'darkgreen', 'darkred'))
#  legend.text = legend_text,
#  args.legend = c(x = 'topleft', bty = 'n'))

#errorbars(barx, c(p_fit_buffered, p_unfit_buffered), ci_lower, ci_upper)

dev.off()
