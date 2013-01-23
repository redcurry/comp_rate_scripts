sample_each_rep = function(data)
{
  rep_sample = c()
  for (rep in unique(data$Replicate))
  {
    updates = data[data$Replicate == rep,]$Update
    rep_sample = c(rep_sample, sample(updates, size = 1))
  }
  return(rep_sample)
}

error = function(x, quantile, color)
{
  arrows(x0 = x, y0 = quantile["2.5%"], y1 = quantile["97.5%"],
    code = 3, length = 0.025, angle = 90, col = color)
}


# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 2)
{
  print('Arguments: anc mut')
  q()
}

anc = as.numeric(args[1])
mut = as.numeric(args[2])

path_expected_wo_epistasis =
  "results-expected-rev-update-wo-epistasis/all-wo-epistasis"
path_expected_w_epistasis =
  "results-expected-rev-update-w-epistasis/all-w-epistasis"
path_actual =
  "../update-at-reversion/results.txt"

# Set up PDF document to output
pdf(file = "plot.pdf", width = 4, height = 4, useDingbats = F)
par(mar = c(5, 5, 1, 1))

# Basic plot
plot(0, 0, type = 'n', las = 1,
  xaxt = 'n', # yaxt = 'n',
  xlim = c(0, 1), ylim = c(0, 300),
  xlab = 'Initial fitness',
  ylab = 'Start of reversion (generation)')

# X-Axis
xlabels = c(0.1, 0.3, 0.5, 0.7, 0.9)
axis(1, at = xlabels,
  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

# Y-Axis
#ylabels = c(0, 1000, 2000, 3000)
#axis(2, at = ylabels, las = 1,
#  labels = prettyNum(ylabels, big.mark = ',', preserve.width = 'individual'))

colors = c('black', 'red', 'blue')

# Legend
legend('topleft',
  legend = c('Expected w/o epistasis', 'Expected w/ epistasis', 'Actual'),
  col = colors, pch = 1, bty = 'n')

data_wo_epi = read.table(path_expected_wo_epistasis, header = T)
data_w_epi = read.table(path_expected_w_epistasis, header = T)
data_actual = read.table(path_actual, header = T)

# Look at only specified ancestor, mutant
data_wo_epi = data_wo_epi[(data_wo_epi$Ancestor == anc) &
  (data_wo_epi$Mutant == mut),]
data_w_epi = data_w_epi[(data_w_epi$Ancestor == anc) &
  (data_w_epi$Mutant == mut),]
data_actual = data_actual[(data_actual$Ancestor == anc) &
  (data_actual$Mutant == mut),]

for (treatment in c(0.1, 0.3, 0.5, 0.7, 0.9))
{
  print(paste("Doing treatment ", treatment))

  # Select the treatment's data
  subdata_wo_epi = data_wo_epi[data_wo_epi$Treatment == treatment,]
  subdata_w_epi = data_w_epi[data_w_epi$Treatment == treatment,]
  subdata_actual = data_actual[data_actual$Treatment == treatment,]

  quantile_wo_epi = quantile(prob = c(0.025, 0.5, 0.975), replicate(100,
    mean(sample_each_rep(subdata_wo_epi)))) * 0.085
  quantile_w_epi = quantile(prob = c(0.025, 0.5, 0.975), replicate(100,
    mean(sample_each_rep(subdata_w_epi)))) * 0.085
  quantile_actual = quantile(prob = c(0.025, 0.5, 0.975), replicate(100,
    mean(sample_each_rep(subdata_actual)))) * 0.085
 
  points(treatment - 0.05, quantile_wo_epi["50%"], col = colors[1])
  points(treatment, quantile_w_epi["50%"], col = colors[2])
  points(treatment + 0.05, quantile_actual["50%"], col = colors[3])

  error(treatment - 0.05, quantile_wo_epi, col = colors[1])
  error(treatment, quantile_w_epi, col = colors[2])
  error(treatment + 0.05, quantile_actual, col = colors[3])
}

dev.off()
