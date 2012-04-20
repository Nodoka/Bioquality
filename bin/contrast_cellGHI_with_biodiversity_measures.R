source('../bin/produce_cell_score.R')

# data are loaded in the source script
# species_cell   <- read.csv('../data/species_cell.csv', row.names = NULL)

# calculate spno
spno <- table(species_cell$sampname)

# manually calculate WE and CWE
# check results with
# hori_score <- read.csv('../data/Hori_plot_score.csv', row.names = NULL)
# WE = sum weighted endemism
sum_we <- tapply(species_cell$hori_cwe,species_cell$sampname,sum)

# Corrected WE = WE/spno
cwe <- sum_we/spno

# optional: for analyses
# relative endemism in percentage
sum_we <- sum_we*100
cwe <- cwe*100

# combine results
wes <- cbind(spno,sum_we,cwe)

# examine GHI vs WEs
# merge all results
# cell_score is generated in produce_cell_score.R
scores <- cbind(cell_score, wes)

# index of spno >39
spcount <- spno > 39
# filter cell with index
valid_scores <- scores[spcount,]

