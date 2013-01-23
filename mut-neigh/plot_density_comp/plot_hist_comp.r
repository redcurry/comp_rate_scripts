plot_density = function(data, color)
{
  density_data = density(data, adjust = 2, from = min(data), to = max(data))
  density_data$y = density_data$y / max(density_data$y)
  lines(density_data, col = color)
}


# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 2)
{
  print('Arguments: fits_0.1_path fits_0.3_path fits_0.5_path fits_0.7_path fits 0.9_path output_path anc_fit mut_fit_0.1 mut_fit_0.3 mut_fit_0.5 mut_fit_0.7 mut_fit_0.9')
  q()
}

fits_0.1_path = args[1]
fits_0.3_path = args[2]
fits_0.5_path = args[3]
fits_0.7_path = args[4]
fits_0.9_path = args[5]
output_path = args[6]
anc_fit = as.numeric(args[7])
mut_fit_0.1 = as.numeric(args[8])
mut_fit_0.3 = as.numeric(args[9])
mut_fit_0.5 = as.numeric(args[10])
mut_fit_0.7 = as.numeric(args[11])
mut_fit_0.9 = as.numeric(args[12])

# Set up PDF document to output
pdf(file = output_path, width = 3.5, height = 2.5, useDingbats = F)
par(mar = c(5, 5, 1, 1), cex = 0.75)

data_0.1 = read.table(fits_0.1_path, header = F)
data_0.3 = read.table(fits_0.3_path, header = F)
data_0.5 = read.table(fits_0.5_path, header = F)
data_0.7 = read.table(fits_0.7_path, header = F)
data_0.9 = read.table(fits_0.9_path, header = F)

# Beneficial mutations
fits_0.1 = data_0.1[data_0.1$V1 > mut_fit_0.1,] / anc_fit
fits_0.3 = data_0.3[data_0.3$V1 > mut_fit_0.3,] / anc_fit
fits_0.5 = data_0.5[data_0.5$V1 > mut_fit_0.5,] / anc_fit
fits_0.7 = data_0.7[data_0.7$V1 > mut_fit_0.7,] / anc_fit
fits_0.9 = data_0.9[data_0.9$V1 > mut_fit_0.9,] / anc_fit

#fits_0.1 = (fits_0.1 - min(fits_0.1)) / (1 - min(fits_0.1))
#fits_0.3 = (fits_0.3 - min(fits_0.3)) / (1 - min(fits_0.3))
#fits_0.5 = (fits_0.5 - min(fits_0.5)) / (1 - min(fits_0.5))
#fits_0.7 = (fits_0.7 - min(fits_0.7)) / (1 - min(fits_0.7))
#fits_0.9 = (fits_0.9 - min(fits_0.9)) / (1 - min(fits_0.9))
fits_0.1 = (fits_0.1 - mut_fit_0.1 / anc_fit) / (1 - mut_fit_0.1 / anc_fit)
fits_0.3 = (fits_0.3 - mut_fit_0.3 / anc_fit) / (1 - mut_fit_0.3 / anc_fit)
fits_0.5 = (fits_0.5 - mut_fit_0.5 / anc_fit) / (1 - mut_fit_0.5 / anc_fit)
fits_0.7 = (fits_0.7 - mut_fit_0.7 / anc_fit) / (1 - mut_fit_0.7 / anc_fit)
fits_0.9 = (fits_0.9 - mut_fit_0.9 / anc_fit) / (1 - mut_fit_0.9 / anc_fit)

plot(0, 0, main = '', type = 'n',
  xlab = 'Fitness effect: (x - m) / (1 - m)',
  ylab = 'Density (scaled to maximum)',
  xlim = c(0, 1), ylim = c(0, 1))

plot_density(fits_0.1, 'black')
plot_density(fits_0.3, 'red')
plot_density(fits_0.5, 'blue')
plot_density(fits_0.7, 'green')
plot_density(fits_0.9, 'purple')

#lines(density(fits_0.9, adjust = 2, from = min(fits_0.9), to = max(fits_0.9)),
#  col = 'purple')

legend('topright', legend = c('0.1', '0.3', '0.5', '0.7', '0.9'),
  lty = 'solid', col = c('black', 'red', 'blue', 'green', 'purple'))

dev.off()
