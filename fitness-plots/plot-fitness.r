bootstrap_ci = function(x, n = 100, lower = 0.025, upper = 0.975)
{
  means = replicate(n, mean(sample(x, replace = T)))
  quantile(means, probs = c(lower, upper))
}

get_box = function(x)
{
  ci = bootstrap_ci(x)
  c(ci[1], mean(x), ci[2])
}

get_fitness_box = function(update, data)
{
  get_box(data[data$Update == update,]$Fitness)
}

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

# Get updates
updates = sort(unique(data$Update))

# Setup plot file and basic plot
pdf(file = output_path, width = 5, height = 2.5, useDingbats = F)
par(mar = c(3.1, 3.1, 0.5, 0.5), mgp = c(2, 0.75, 0))

# Basic plot
plot(0, 0, type = 'n', las = 1, xaxt = 'n',
  xlim = c(0, 10000),
  ylim = c(0, 1),
  xlab = 'Time (updates)',
  ylab = 'Mean relative fitness')

xlabels = seq(0, 10000, 2500)
axis(1, at = xlabels,
  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

treatments = sort(unique(data$TreatmentValue))

for(treatment in treatments)
{
  subdata = data[data$TreatmentValue == treatment,]
  #subdata_box = sapply(updates, get_fitness_box, subdata)

  # Lower CI
  #lines(updates, subdata_box[1,], lty = 'solid', col = 'gray')

  # Upper CI
  #lines(updates, subdata_box[3,], lty = 'solid', col = 'gray')

  subdata_means = aggregate(subdata$Fitness, by = list(subdata$Update), mean)
  names(subdata_means) = c('Update', 'Fitness')

  # Mean (plot after CI so that the mean lines are on top of CI lines)
  #lines(updates, subdata_box[2,], lty = 'solid')
  lines(subdata_means$Update, subdata_means$Fitness, lty = 'solid')
}

dev.off()
