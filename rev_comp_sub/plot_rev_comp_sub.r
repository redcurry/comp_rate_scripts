calc_p = function(data, recovery = '', type = '')
{
  n = nrow(data)

  if(recovery != '')
    data = data[data$Recovery == recovery,]

  if(type != '')
    data = data[data$Type == type,]

  return(nrow(data) / n)
}

calc_height <- function(data)
{
  # Get the possible treatment values, e.g., c(10, 100, 1000, 10000)
  treat_values = sort(unique(data$Value))
  treat_values

  heights = c()

  for(treat_value in treat_values)
  {
    treat_col = data$Value
    treat_rows = data[treat_col == treat_value,]

    # Reversion
    p_R = calc_p(treat_rows, 'F', 'R')

    # Full and partial compensation
    p_FC = calc_p(treat_rows, 'F', 'C')
    p_PC = calc_p(treat_rows, 'P', 'C')

    # None
    p_N = calc_p(treat_rows, 'N', 'N')

    heights = c(heights, p_R, p_FC, p_PC, p_N)
  }

  matrix(heights, nrow = 4, ncol = length(treat_values))
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
# fifth argument is the treatment display name
input_file = args[1]
output_file = args[2]
ancestor = args[3]
treat_name = args[4]

#bgcolor = "#d2c99d"
#Rcolor = "#50779b"
#FCcolor = "#519b50"
#PCcolor = "#987450"
#Ncolor = bgcolor

bgcolor = "white"
Rcolor = "#666666"
FCcolor = "#AAAAAA"
PCcolor = "#CCCCCC"
Ncolor = "white"

# Set up PDF document to output
pdf(file = output_file, width = 4, height = 4, bg = bgcolor)
par(mar = c(5, 5, 1, 1))

# Read data (contains column headers)
data = read.table(input_file, header = T)

# Look at one ancestor only
data = data[data$Ancestor == ancestor,]

height_1 = calc_height(data[data$MutReplicate == 1,])
height_2 = calc_height(data[data$MutReplicate == 2,])

legend_text = c('None',
                'PC',
                'FC',
                'R')

# Get the possible treatment values, e.g., c(10, 100, 1000, 10000)
treat_values = sort(unique(data$Value))
treat_values

# Load hacked barplot code that allows two stacked bargraphs per treatment
#   offsetx = -1 causes bar to be shifted left
#   offsetx = 1  causes bar to be shifted right
source('barplot.R')

# Plot things
barx = barplot(height_1, offsetx = -1,
  names.arg = prettyNum(treat_values, big.mark = ',',
    preserve.width = 'individual'),
  xlab = treat_name,
  ylab = 'Proportion',
  ylim = c(0, 1),
  space = 0.5,
  col = c(Rcolor, FCcolor, PCcolor, Ncolor))
#  legend.text = legend_text,
#  args.legend = c(x = 'topleft', bty = 'n'))

barplot(height_2, offsetx = 1, xaxt = 'n', add = T,
  ylim = c(0, 1),
  space = 0.5,
  col = c(Rcolor, FCcolor, PCcolor, Ncolor))

dev.off()
