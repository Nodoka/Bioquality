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

# make a new column with either endemic spcount or % endemics
endemino <- tapply(species_cell$horim_end.1, species_cell$sampname, sum)
propend <- endemino*100/spnum_cell
endemics <- cbind(endemino, propend)
# combine results
scores <- cbind(scores, endemics)


# OPTIONAL: filter out spcount <40
# index of spnum_cell >39
spcount <- spnum_cell > 39
# filter cell with index
valid_scores <- scores[spcount,]

# OPTIONAL: add lat long data to csv
hori_samp    <- read.csv("../data/horim_Pheader.csv")
hori_latlong <- hori_samp[,c('scode','sampname','lat','long')]
scores       <- merge(hori_latlong, scores, all.x=T)
valid_scores <- merge(hori_latlong, valid_scores, all.x=T)

# replace all NA with -1 (no data)
scores[is.na(scores)] <- -1


# write results to file
write.csv(valid_scores,
          file="../data/horicell_BDmeasures.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

# correlation analsysis
# if to use cor, use="complete.obs" to remove missing values
cor.test(valid_scores$GHI,     valid_scores$spno,    method="kendall")
cor.test(valid_scores$GHI,     valid_scores$sum_we,  method="kendall")
cor.test(valid_scores$GHI,     valid_scores$cwe,     method="kendall")
cor.test(valid_scores$GHI,     valid_scores$endemino,method="kendall")
cor.test(valid_scores$GHI,     valid_scores$propend, method="kendall")
cor.test(valid_scores$sum_we,  valid_scores$spno,    method="kendall")
cor.test(valid_scores$cwe,     valid_scores$spno,    method="kendall")
cor.test(valid_scores$endemino,valid_scores$spno,    method="kendall")
cor.test(valid_scores$sum_we,  valid_scores$cwe,     method="kendall")
cor.test(valid_scores$endemino,valid_scores$cwe,     method="kendall")
cor.test(valid_scores$propend, valid_scores$cwe,     method="kendall")

cor.test(scores$GHI,     scores$spno,    method="kendall")
cor.test(scores$GHI,     scores$sum_we,  method="kendall")
cor.test(scores$GHI,     scores$cwe,     method="kendall")
cor.test(scores$GHI,     scores$endemino,method="kendall")
cor.test(scores$GHI,     scores$propend, method="kendall")
cor.test(scores$sum_we,  scores$spno,    method="kendall")
cor.test(scores$cwe,     scores$spno,    method="kendall")
cor.test(scores$endemino,scores$spno,    method="kendall")
cor.test(scores$sum_we,  scores$cwe,     method="kendall")
cor.test(scores$endemino,scores$cwe,     method="kendall")
cor.test(scores$propend, scores$cwe,     method="kendall")

# spatial autocorrelation using Moran's I
# install Moran's I test from package ("ape) 
# also check package ("spdep")!!
install.packages("ape")
library(ape)

# calculate distance matrix
celldists <- as.matrix(dist(cbind(valid_scores$long, valid_scores$lat)))
celldists_inv <- 1/celldists
diag(celldists_inv) <- 0

# calculate Moran's I
Moran.I(valid_scores$GHI,      celldists_inv, na.rm=TRUE)
Moran.I(valid_scores$spno,     celldists_inv, na.rm=TRUE)
Moran.I(valid_scores$endemino, celldists_inv, na.rm=TRUE)
Moran.I(valid_scores$cwe,      celldists_inv, na.rm=TRUE)

# alternatively, use binary distance
celldists_bin <- (celldists>0 & celldists <= 0.75)

Moran.I(valid_scores$GHI,      celldists_bin, na.rm=TRUE)
Moran.I(valid_scores$spno,     celldists_bin, na.rm=TRUE)
Moran.I(valid_scores$endemino, celldists_bin, na.rm=TRUE)
Moran.I(valid_scores$cwe,      celldists_bin, na.rm=TRUE)

# for scores
celldists <- as.matrix(dist(cbind(scores$long, scores$lat)))
celldists_inv <- 1/celldists
diag(celldists_inv) <- 0

# calculate Moran's I
Moran.I(scores$GHI,      celldists_inv, na.rm=TRUE)
Moran.I(scores$spno,     celldists_inv, na.rm=TRUE)
Moran.I(scores$endemino, celldists_inv, na.rm=TRUE)
Moran.I(scores$cwe,      celldists_inv, na.rm=TRUE)
