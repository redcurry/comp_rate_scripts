calc_n = function(data, recovery = '', type = '')
{
  n = nrow(data)

  if(recovery != '')
    data = data[data$Recovery == recovery,]

  if(type != '')
    data = data[data$Type == type,]

#  return(nrow(data) / n)
  return(nrow(data))
}

calc_n_revertants <- function(data, treat_values)
{
  n_revertants = c()

  for(treat_value in treat_values)
  {
    treat_col = data$Value
    treat_rows = data[treat_col == treat_value,]

    # Reversion
    n_R = calc_n(treat_rows, 'F', 'R')

    n_revertants = c(n_revertants, n_R)
  }

  return(n_revertants)
}

calc_n_compensatory <- function(data, treat_values)
{
  n_compensatory = c()

  for(treat_value in treat_values)
  {
    treat_col = data$Value
    treat_rows = data[treat_col == treat_value,]

    n_C = calc_n(treat_rows, 'F', 'C') + calc_n(treat_rows, 'P', 'C')

    n_compensatory = c(n_compensatory, n_C)
  }

  return(n_compensatory)
}

calc_n_none <- function(data, treat_values)                                     
{                                                                               
  n_none = c()                                                                  
                                                                                
  for(treat_value in treat_values)                                              
  {                                                                             
    treat_col = data$Value                                                      
    treat_rows = data[treat_col == treat_value,]                                
                                                                                
    n_N = calc_n(treat_rows, 'N', 'N')                                          
                                                                                
    n_none = c(n_none, n_N)                                                     
  }                                                                             
                                                                                
  return(n_none)                                                                
}

# Get command-line arguments, which must be specified after the '--args' flag
args = commandArgs(T)

if(length(args) < 3)
{
  print('Arguments: input_file output_file ancestor treat_name')
  q()
}

# First argument is the input file,
# second argument is the output (plot) file,
# third argument is the ancestor number,
# fourth argument is the treatment display name
input_file = args[1]
output_file = args[2]
ancestor = args[3]
treat_name = args[4]

# Set up PDF document to output
pdf(file = output_file, width = 3.5, height = 2.5, useDingbats = F)
par(mar = c(5, 5, 1, 1), cex = 0.75)

# Read data (contains column headers)
data = read.table(input_file, header = T)

# Look at one ancestor only
data = data[data$Ancestor == ancestor,]

# Get the possible treatment values, e.g., c(10, 100, 1000, 10000)
treat_values = sort(unique(data$Value))
treat_values

# Basic plot
plot(0, 0, type = 'n', las = 1, xaxt = 'n',
  xlim = c(1 - 0.1, length(treat_values) + 0.1), ylim = c(0, 100),
  xlab = treat_name,
#  ylab = 'Percent reversion')
  ylab = 'Percent compensatory')
#  ylab = 'Percent uncompensated')

# X-Axis
xlabels = treat_values
axis(1, at = seq(xlabels),
  labels = prettyNum(xlabels, big.mark = ',', preserve.width = 'individual'))

# Legend
#legend('bottomleft', legend = c('Replicate 1', 'Replicate 2'),
#  lty = c('solid', 'dashed'), pch = c(1, 2), bty = 'n')

#n_status_1 = calc_n_revertants(data[data$MutReplicate == 1,], treat_values)
#n_status_2 = calc_n_revertants(data[data$MutReplicate == 2,], treat_values)
n_status_1 = calc_n_compensatory(data[data$MutReplicate == 1,], treat_values)
n_status_2 = calc_n_compensatory(data[data$MutReplicate == 2,], treat_values)
#n_status_1 = calc_n_none(data[data$MutReplicate == 1,], treat_values)
#n_status_2 = calc_n_none(data[data$MutReplicate == 2,], treat_values)

# When plotting W, they should have same symbols and not be connected
# because they are independent runs, so there's no relationship

#lines(seq(treat_values), n_status_1, lty = 'solid')
points(seq(treat_values), n_status_1, pch = 1)

#lines(seq(treat_values), n_status_2, lty = 'dashed')
points(seq(treat_values), n_status_2, pch = 17)
#points(seq(treat_values), n_status_2, pch = 1)

# One linear regression (use with W treatment)
xvalues = c(seq(treat_values), seq(treat_values))
yvalues = c(n_status_1, n_status_2)
linear_model = lm(yvalues ~ xvalues)
intercept = coef(linear_model)[1]
slope = coef(linear_model)[2]
abline(intercept, slope)
summary(linear_model)  # Print out statistics for reporting on paper


dev.off()
