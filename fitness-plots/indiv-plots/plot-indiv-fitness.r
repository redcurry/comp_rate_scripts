# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 1)
{
  print('Arguments: input_path treatment output_path')
  q()
}

input_path = args[1]
treatment = as.numeric(args[2])
anc_fitness = as.numeric(args[3])
output_path = args[4]

# Read data (contains column headers)
data = read.table(input_path, header = T)

data$Fitness = data$Fitness / anc_fitness

# Get updates
updates = sort(unique(data$Update))

# Setup plot file and basic plot
pdf(file = output_path, width = 5, height = 2.5, useDingbats = F)
par(mar = c(3.1, 3.1, 0.5, 0.5), mgp = c(2, 0.75, 0))

# Basic plot
plot(0, 0, type = 'n', las = 1, xaxt = 'n',
  xlim = c(0, 10000),
  ylim = c(treatment - 0.05 * treatment, 1),
  xlab = 'Time (updates)',
  ylab = 'Mean relative fitness')

xlabels = seq(0, 10000, 2500)
axis(1, at = xlabels,
  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

data = data[data$TreatmentValue == treatment,]

# Plot individual replicates
replicates = sort(unique(data$Replicate))
for (replicate in replicates)
{
  subdata = data[data$Replicate == replicate,]
  lines(subdata$Update, subdata$Fitness, col = 'gray')
}

# Mean fitness
data_means = aggregate(data$Fitness, by = list(data$Update), mean)
names(data_means) = c('Update', 'Fitness')
lines(data_means$Update, data_means$Fitness, lty = 'solid')

dev.off()
