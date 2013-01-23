bootstrap_ci = function(x, n = 10000, lower = 0.025, upper = 0.975)
{
  means = replicate(n, mean(sample(x, replace = T)))
  quantile(means, probs = c(lower, upper))
}

get_box = function(x)
{
  ci = bootstrap_ci(x)
  c(ci[1], mean(x), ci[2])
}

get_comp_fitnesses <- function(data, treat_value)
{
  comp_fitnesses = c()

  rows = data[data$Value == treat_value & data$Type == 'C',]

  comp_fitnesses = rows$FinalFitness

  return(comp_fitnesses)
}

# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 3)
{
  print('Arguments: input_file output_file ancestor treat_name')
  q()
}

# First argument is the input file,
# second argument is the output (plot) file,
# third argument is the ancestor number,
# fourth argument is the treatment display name
input_file = args[1]
output_file = args[2]
ancestor = args[3]
treat_name = args[4]

# Set up PDF document to output
pdf(file = output_file, width = 3.5, height = 2.5, useDingbats = F)
par(mar = c(5, 5, 1, 1), cex = 0.75)

# Read data (contains column headers)
data = read.table(input_file, header = T)

# Look at one ancestor only
data = data[data$Ancestor == ancestor,]

# Get the possible treatment values, e.g., c(10, 100, 1000, 10000)
treat_values = sort(unique(data$Value))
treat_values

# Basic plot
plot(0, 0, type = 'n', las = 1, xaxt = 'n',
  xlim = c(1 - 0.1, length(treat_values) + 0.1), ylim = c(0.5, 1),
  xlab = treat_name,
  # When treatmeant is initial fitness
#  ylab = 'Proportional increase\nin relative fitness')
  # When treatment is not initial fitness
  ylab = 'Final relative fitness')

# X-Axis
xlabels = treat_values
axis(1, at = seq(xlabels),
  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

# Legend
#legend('bottomleft', legend = c('Replicate 1', 'Replicate 2'),
#  lty = c('solid', 'dashed'), pch = c(1, 2), bty = 'n')

x = 1
for(treat_value in treat_values)
{
  comp_fits_1 = get_comp_fitnesses(data[data$MutReplicate == 1,], treat_value)
  comp_fits_2 = get_comp_fitnesses(data[data$MutReplicate == 2,], treat_value)

  # Only when treatment is initial fitness, do this normalizing calculation
#  comp_fits_1 = (comp_fits_1 - treat_value) / (1 - treat_value)
#  comp_fits_2 = (comp_fits_2 - treat_value) / (1 - treat_value)

  comp_fits_box_1 = get_box(comp_fits_1)
  comp_fits_box_2 = get_box(comp_fits_2)

  points(x - 0.1, comp_fits_box_1[2], pch = 1)
  points(x + 0.1, comp_fits_box_2[2], pch = 17)
#  points(x + 0.1, comp_fits_box_2[2], pch = 1)  # When treatment is W

  if(comp_fits_box_1[3] - comp_fits_box_1[1] > 0.05)
    arrows(x - 0.1, comp_fits_box_1[1], x - 0.1, comp_fits_box_1[3],
      length = 0.025, angle = 90, code = 3)
  if(comp_fits_box_2[3] - comp_fits_box_2[1] > 0.05)
    arrows(x + 0.1, comp_fits_box_2[1], x + 0.1, comp_fits_box_2[3],
      length = 0.025, angle = 90, code = 3)

#  points(rep(x, length(comp_fits_1)), comp_fits_1, pch = 1)
#  points(rep(x, length(comp_fits_2)), comp_fits_2, pch = 17)

  x = x + 1
}

dev.off()
