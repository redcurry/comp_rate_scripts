jitter2 = function(x)
{
  noise = rnorm(length(x), mean = 0, sd = 0) #sd = 0.01)
  return(x + noise)
}


# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 1)
{
  print('Arguments: input_path output_path anc_fit del_fit')
  q()
}

input_path = args[1]
output_path = args[2]
anc_fit = as.numeric(args[3])
del_fit = as.numeric(args[4])

# Read data (contains column headers)
data = read.table(input_path, header = T)

data = data[data$SingleCompFit > del_fit + 0.01 * del_fit,]

data$SingleCompFit = data$SingleCompFit / anc_fit
data$SingleCompRevFit = data$SingleCompRevFit / anc_fit

# Setup plot file and basic plot
pdf(file = output_path, width = 5, height = 5, useDingbats = F)
par(mar = c(3.1, 3.1, 0.5, 0.5), mgp = c(2, 0.75, 0))

# Basic plot
plot(0, 0, type = 'n', las = 1,
  xlim = c(0, 1),
  ylim = c(0, 1),
  xlab = 'Fitness of single compensator',
  ylab = 'Fitness of single compensator + reversion')

comp_data = data[data$Type == 'C',]
subs_data = data[data$Type == 'S',]

points(jitter2(comp_data$SingleCompFit), jitter2(comp_data$SingleCompRevFit))
points(jitter2(subs_data$SingleCompFit), jitter2(subs_data$SingleCompRevFit),
  col = 'red')

abline(0, 1)


# Draw mutant fitness
abline(v = (del_fit / anc_fit), lty = 'dashed')

dev.off()
