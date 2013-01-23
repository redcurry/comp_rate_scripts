plot_task = function(x, task_id, present)
{
  if (present)
    color = 'green'
  else
    color = 'red'

  rect(x, task_id - 1, x + 1, task_id, col = color, border = NA)
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

# Read data
data = read.table(input_path)

# Setup plot file and basic plot
pdf(file = output_path, width = 5, height = 2.5, useDingbats = F)
par(mar = c(3.1, 3.1, 0.5, 0.5), mgp = c(2, 0.75, 0))

# Basic plot
plot(0, 0, type = 'n', las = 1, #xaxt = 'n',
  xlim = c(1, 101),
  ylim = c(0, 9),
  xlab = 'Time steps',
  ylab = 'Task')

#xlabels = seq(0, 10000, 2500)
#axis(1, at = xlabels,
#  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

for(index in seq(length(data$V1)))
{
  subdata = data[index,]

  plot_task(index, 1, subdata$V1)
  plot_task(index, 2, subdata$V2)
  plot_task(index, 3, subdata$V3)
  plot_task(index, 4, subdata$V4)
  plot_task(index, 5, subdata$V5)
  plot_task(index, 6, subdata$V6)
  plot_task(index, 7, subdata$V7)
  plot_task(index, 8, subdata$V8)
  plot_task(index, 9, subdata$V9)
}

dev.off()
