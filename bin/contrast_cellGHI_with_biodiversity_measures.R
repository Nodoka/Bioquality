source('../bin/produce_cell_score.R')

# data are loaded in the source script
# species_cell   <- read.csv('../data/species_cell.csv', row.names = NULL)

# manually calculate WE and CWE
# check results with
# hori_score <- read.csv('../data/Hori_plot_score.csv', row.names = NULL)

# weight = inverse of the number of cells present
weight <- 1/table(species_cell$spnumber)
sp_weight <- data.frame(spnumber=row.names(weight),cwe=weight[])

# filter relevant columns
spcell <- species_cell[,c('sampname','spnumber','star_infs','hori_cwe')]

# merge species_cell data and calculated weight data
we_spcell <- merge(spcell,sp_weight)

# WE = sum weighted endemism
# check results with
# sum_we <- tapply(species_cell$hori_cwe,species_cell$sampname,sum)
sum_we  <- tapply(we_spcell$cwe, we_spcell$sampname,sum)

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

# write results to file
write.csv(valid_scores,
          file="../data/horicell_BDmeasures.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

# correlation analsysis
cor(valid_scores$GHI,    valid_scores$spno,   method="spearman")
cor(valid_scores$sum_we, valid_scores$spno,   method="spearman")
cor(valid_scores$cwe,    valid_scores$spno,   method="spearman")
cor(valid_scores$GHI,    valid_scores$sum_we, method="spearman")
cor(valid_scores$GHI,    valid_scores$cwe,    method="spearman")
cor(valid_scores$sum_we, valid_scores$cwe,    method="spearman")
