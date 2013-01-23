# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 2)
{
  print('Arguments: input_path output_path anc_absolute_fitness')
  q()
}

input_path = args[1]
output_path = args[2]
anc_fitness = as.numeric(args[3])

# Set up PDF document to output
pdf(file = output_path, width = 3.5, height = 2.5, useDingbats = F)
par(mar = c(5, 5, 1, 1), cex = 0.75)

data = read.table(input_path, header = F)
fits = data$V1 / anc_fitness

hist(fits, breaks = 30, main = '',
  xlab = 'Fitness relative to ancestor')

dev.off()
