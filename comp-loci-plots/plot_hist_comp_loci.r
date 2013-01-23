# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 1)
{
  print('Arguments: hist_comp_loci_path hist_control_loci_path mutant_pos n_comp output_path')
  q()
}

hist_comp_loci_path = args[1]
hist_control_loci_path = args[2]
mutant_pos = as.numeric(args[3])
n_comp = as.numeric(args[4])
output_path = args[5]

# Read data (contains column headers)
data = read.table(hist_comp_loci_path, header = T)
ctrl_data = read.table(hist_control_loci_path, header = T)

# Normalize data
data$Count = data$Count / n_comp
ctrl_data$Count = ctrl_data$Count / 100

# Setup plot file
pdf(file = output_path, width = 7.5, height = 1.5, useDingbats = F)
#par(mar = c(1, 1, 0.5, 0.5), mgp = c(2, 0.75, 0))
par(mar = c(3, 4, 1, 0), mgp = c(2, 0.75, 0), cex = 0.75)

barplot(data$Count, space = 0, las = 1, xaxt = 'n',
  ylim = c(0, 1),
  xlab = 'Locus', ylab = 'Proportion of reps.\nwith evolved locus',
  col = 'gray', border = 'gray')

xlabels = c(1, seq(10, 200, 10))
axis(1, at = c(1, seq(10, 200, 10)) - 0.5, labels = xlabels)
#axis(2, at = c(0, 0.5, 1), las = 1)

# Mark mutation position
text(mutant_pos - 0.5, 0.95, "*")

# Draw control lines (super thin boxes)
rect(seq(200) - 1, ctrl_data$Count, seq(200), ctrl_data$Count)

dev.off()
