# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 2)
{
  print('Arguments: input_path output_path anc_fit mut_fit')
  q()
}

input_path = args[1]
output_path = args[2]
anc_fit = as.numeric(args[3])
mut_fit = as.numeric(args[4])

# Set up PDF document to output
pdf(file = output_path, width = 3.5, height = 2.5, useDingbats = F)
par(mar = c(5, 5, 1, 1), cex = 0.75)

data = read.table(input_path, header = F)

# Beneficial mutations
fits = data[data$V1 > mut_fit,] / anc_fit

# Neutral and deleterious
#fits = data[data$V1 <= mut_fit,] / anc_fit

# Plot histogram
hist(fits, breaks = 20, main = '',
  xlab = 'Fitness relative to ancestor')

dev.off()
