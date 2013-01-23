get_mean_ci = function(data)
{
  quantile(replicate(10000, mean(sample(data, replace = T))),
    probs = c(0.025, 0.975))
}

plot_ci = function(x, ci)
{
  arrows(x, ci[1], x, ci[2], length = 0.05, angle = 90, code = 3)
}

# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 2)
{
  print('Arguments: control_1_path control_2_path
    comp_1_1_path comp_1_2_path comp_2_1_path comp_2_2_path output_path')
  q()
}

control_1_path = args[1]
control_2_path = args[2]
comp_1_1_path = args[3]
comp_1_2_path = args[4]
comp_2_1_path = args[5]
comp_2_2_path = args[6]
output_path = args[7]

# Set up PDF document to output
pdf(file = output_path, width = 4, height = 4)
par(mar = c(5, 5, 1, 1))

# Basic plot
#plot(0, 0, type = 'n', las = 1, xaxt = 'n',
#  xlim = c(0.75, 6.25), ylim = c(0, 12),
#  xlab = 'Initial genotype (ancestor-mutant)',
#  ylab = 'Mean number of evolved mutations')

# X-Axis
#xlabels = c('1-C', '1-1', '1-2', '2-C', '2-1', '2-2')
#axis(1, at = seq(xlabels), labels = xlabels)

ctrl_1 = read.table(control_1_path)
ctrl_2 = read.table(control_2_path)
comp_1_1 = read.table(comp_1_1_path)
comp_1_2 = read.table(comp_1_2_path)
comp_2_1 = read.table(comp_2_1_path)
comp_2_2 = read.table(comp_2_2_path)

ctrl_1 = as.data.frame(cbind(rep('1-A', length(ctrl_1$V1)), ctrl_1))
names(ctrl_1) = c('Strain', 'Count')
ctrl_2 = as.data.frame(cbind(rep('2-A', length(ctrl_2$V1)), ctrl_2))
names(ctrl_2) = c('Strain', 'Count')
comp_1_1 = as.data.frame(cbind(rep('1-1', length(comp_1_1$V1)), comp_1_1))
names(comp_1_1) = c('Strain', 'Count')
comp_1_2 = as.data.frame(cbind(rep('1-2', length(comp_1_2$V1)), comp_1_2))
names(comp_1_2) = c('Strain', 'Count')
comp_2_1 = as.data.frame(cbind(rep('2-1', length(comp_2_1$V1)), comp_2_1))
names(comp_2_1) = c('Strain', 'Count')
comp_2_2 = as.data.frame(cbind(rep('2-2', length(comp_2_2$V1)), comp_2_2))
names(comp_2_2) = c('Strain', 'Count')

data = as.data.frame(rbind(ctrl_1, comp_1_1, comp_1_2, ctrl_2, comp_2_1, comp_2_2))
names(data)
#names(data) = c('Strain', 'Count')

boxplot(data$Count ~ data$Strain,
  xlab = 'Initial genotype (ancestor-mutant)',
  ylab = 'Number of evolved mutations')

#ctrl_1 = read.table(control_1_path)$V1
#ctrl_2 = read.table(control_2_path)$V1
#comp_1_1 = read.table(comp_1_1_path)$V1
#comp_1_2 = read.table(comp_1_2_path)$V1
#comp_2_1 = read.table(comp_2_1_path)$V1
#comp_2_2 = read.table(comp_2_2_path)$V1

#points(rep(1, length(ctrl_1)), ctrl_1, col = 'gray')
#points(rep(2, length(comp_1_1)), comp_1_1, col = 'gray')
#points(rep(3, length(comp_1_2)), comp_1_2, col = 'gray')

#points(rep(4, length(ctrl_2)), ctrl_2, col = 'gray')
#points(rep(5, length(comp_2_1)), comp_2_1, col = 'gray')
#points(rep(6, length(comp_2_2)), comp_2_2, col = 'gray')

#mean_data = c(mean(ctrl_1), mean(comp_1_1), mean(comp_1_2),
#  mean(ctrl_2), mean(comp_2_1), mean(comp_2_2))

#ctrl_1_ci = get_mean_ci(ctrl_1)
#ctrl_2_ci = get_mean_ci(ctrl_2)
#comp_1_1_ci = get_mean_ci(comp_1_1)
#comp_1_2_ci = get_mean_ci(comp_1_2)
#comp_2_1_ci = get_mean_ci(comp_2_1)
#comp_2_2_ci = get_mean_ci(comp_2_2)

#points(mean_data, pch = 16)

#plot_ci(1, ctrl_1_ci)
#plot_ci(2, comp_1_1_ci)
#plot_ci(3, comp_1_2_ci)
#
#plot_ci(4, ctrl_2_ci)
#plot_ci(5, comp_2_1_ci)
#plot_ci(6, comp_2_2_ci)

dev.off()
