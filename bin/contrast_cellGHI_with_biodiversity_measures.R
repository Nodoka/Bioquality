source('../bin/produce_cell_score.R')

# data are loaded in the source script
# species_cell   <- read.csv('../data/species_cell.csv', row.names = NULL)

# manually calculate WE and CWE
# check results with
# hori_score <- read.csv('../data/Hori_plot_score.csv', row.names = NULL)
# WE = sum weighted endemism
sum_we <- tapply(species_cell$hori_cwe,species_cell$sampname,sum)

# Corrected WE = WE/spnum_cell
cwe <- sum_we/spnum_cell

# optional: for analyses
# relative endemism in percentage
sum_we <- sum_we*100
cwe <- cwe*100

# combine results
wes <- cbind(sum_we,cwe)

# examine GHI vs WEs
# merge all results
# cell_score is generated in produce_cell_score.R
scores <- cbind(cell_score, wes)

# OPTIONAL: filter out spcount <40
# index of spnum_cell >39
spcount <- spnum_cell > 39
# filter cell with index
valid_scores <- scores[spcount,]

