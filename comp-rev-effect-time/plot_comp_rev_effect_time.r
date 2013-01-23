jitter2 = function(x, sd)
{
  noise = rnorm(length(x), mean = 0, sd = sd)
  return(x + noise)
}

# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 2)
{
  print('Arguments: input_file output_file anc_fitness mut_fitness')
  q()
}

# First argument is the input file,
# second argument is the output (plot) file,
# third argument is the ancestral fitness
input_file = args[1]
output_file = args[2]
anc_fitness = as.numeric(args[3])
mut_fitness = as.numeric(args[4])

# Set up PDF document to output
pdf(file = output_file, width = 6, height = 4, useDingbats = F)
par(mar = c(5, 5, 1, 1), cex = 0.9)

# Read data (contains column headers)
data = read.table(input_file, header = T)
data$Fitness = data$Fitness / anc_fitness

taken = data[data$Taken == 1,]
revs = data[data$Type == 'R',]

# Scatter plot
#subdata = data[sample(1:dim(data)[1], size = 10000, replace = F),]
#subdata = rbind(subdata, revs)
plot(jitter2(data$Step, 0.1), jitter2(data$Fitness, 0.01),
  las = 1, pch = '.', cex = 0.01,
  xlab = 'Time (mutational steps)',
  ylab = 'Fitness (relative to ancestor)')

# Box plot
#boxplot(data$Fitness ~ data$Step, las = 1,
#  xlab = 'Time (mutational steps)',
#  ylab = 'Fitness (relative to ancestor)')

# Violin plot
#library(vioplot)
#d = function(step) {
#  return(data[data$Step == step, 'Fitness'])
#}
#vioplot(d(1), d(2), d(3), d(4), d(5), d(6), d(7), d(8), d(9),
#  d(10), d(11), d(12), d(13), d(14), col = 'white')

abline(h = mut_fitness / anc_fitness, lty = 'dashed')

lines(taken$Step, taken$Fitness, col = 'red')
lines(revs$Step, revs$Fitness, col = 'blue')

dev.off()
