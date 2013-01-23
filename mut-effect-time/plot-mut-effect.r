# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 1)
{
  print('Arguments: input_path output_path')
  q()
}

input_path = args[1]
output_path = args[2]

# Read data (contains column headers)
data = read.table(input_path, header = T)

# Get replicates
replicates = sort(unique(data$Replicate))

# Setup plot file and basic plot
pdf(file = output_path, width = 4, height = 2, useDingbats = F)
par(mar = c(3.1, 3.1, 0.5, 0.5), mgp = c(2, 0.75, 0), cex = 0.75)

# Basic plot
plot(0, 0, type = 'n', las = 1,
  xlim = c(1, 10),
  #ylim = c(1, 14),
  ylim = c(0.99, 1.1),
  xlab = 'Mutational step',
  ylab = 'Fitness relative to previous')

xlabels = seq(10)
axis(1, at = xlabels, labels = xlabels)

for(replicate in replicates)
{
#  subdata = data[data$Replicate == replicate & data$Fitness > 1.001,]
  subdata = data[data$Replicate == replicate,]
  lines(subdata$Fitness, col = 'black')
}

#mean_data = aggregate(data$Fitness, by = list(data$Step), mean)
#names(mean_data) = c('Step', 'Fitness')
#lines(mean_data$Fitness)

dev.off()
