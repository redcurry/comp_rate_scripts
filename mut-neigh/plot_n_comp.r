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
pdf(file = output_path, width = 4, height = 4, useDingbats = F)
par(mar = c(5, 5, 1, 1))

# Basic plot
plot(0, 0, type = 'n', las = 1, xaxt = 'n', xlim = c(0, 1),
  ylim = c(0, 0.12),
  #ylim = c(0, 0.04),
  xlab = 'Initial fitness of mutant',
  ylab = 'Proportion of available\ncompensatory alleles')
  #ylab = 'Proportion of available\ncompensatory loci')

# X-Axis
xlabels = c(0.1, 0.3, 0.5, 0.7, 0.9)
axis(1, at = xlabels,
  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

point_types = c(1, 17)
line_types = c('solid', 'dashed')

# Legend
legend('topright', legend = c('Ancestor 1', 'Ancestor 2'),
  pch = point_types, lty = line_types, bty = 'n')

data = read.table(input_path, header = T)

for(ancestor in seq(2))
{
  subdata = data[data$Ancestor == ancestor,]
  prop_comp = subdata$AvailCompAllelesCount / 5000
  #prop_comp = subdata$AvailCompLociCount / 5000

  points(subdata$InitFitness, prop_comp, pch = point_types[ancestor])

  linear_model = lm(prop_comp ~ subdata$InitFitness)
  intercept = coef(linear_model)["(Intercept)"]
  slope = coef(linear_model)["subdata$InitFitness"]
  abline(intercept, slope, lty = line_types[ancestor])
}

dev.off()
