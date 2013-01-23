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
plot(0, 0, type = 'n', las = 1, xaxt = 'n', xlim = c(0, 1), ylim = c(0, 850),
  xlab = 'Initial fitness of mutant',
  ylab = 'Time at which reversion\nstops being beneficial (generations)')

# X-Axis
xlabels = c(0.1, 0.3, 0.5, 0.7, 0.9)
axis(1, at = xlabels,
  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

data = read.table(input_path, header = T)
data$Generation = data$Update * 0.085

for (mut_fit in c(0.1, 0.3, 0.5, 0.7, 0.9))
{
  subdata = data[data$MutFit == mut_fit,]
  if (length(subdata$MutFit) == 0)
    next
  quant = quantile(replicate(10000,
    mean(sample(subdata$Generation, replace=T))), probs=c(0.025, 0.975))
  points(mut_fit, mean(subdata$Generation))
  arrows(mut_fit, quant[1], mut_fit, quant[2],
    length = 0.05, angle = 90, code = 3)
}

dev.off()
