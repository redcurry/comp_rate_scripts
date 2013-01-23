# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 2)
{
  print('Arguments: input_path output_path')
  q()
}

input_path = args[1]
output_path = args[2]

# Set up PDF document to output
pdf(file = output_path, width = 3.5, height = 2.5, useDingbats = F)
par(mar = c(5, 5, 1, 1), cex = 0.75)

data = read.table(input_path, header = T)
first_data = data[data$Step == 1,]

hist(first_data$Fitness, breaks = 20, main = '',
  xlab = 'Fitness relative to mutant')

dev.off()
