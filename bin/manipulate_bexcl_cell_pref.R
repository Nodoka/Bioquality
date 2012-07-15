# load data
cell_pref  <- read.csv('../data/cell_pref.csv',    row.names = NULL)

# OPTIONAL: not necessary with a dataset after March 2012
# remove subcells representing water parts of cells, with no prefecture
# cell_pref <- subset(cell_pref, pref != "")

# filter duplicates of Pref-sampname pair
samp_freq <- as.data.frame(table(cell_pref$Pref, cell_pref$sampname))
names(samp_freq) <- c("Pref","sampname","Freq")
# only select valid pair
valid_sampfreq <- subset(samp_freq, Freq != 0)
# OPTIONAL: check which data are duplicates
which(valid_sampfreq$Freq == 2)

# count frequency of sampname against pref
pref_freq <- table(valid_sampfreq$sampname)
pref_freq <- data.frame(sampname=row.names(pref_freq),prefno=pref_freq[])
# only select sampname with unique pref
valid_cell <- subset(pref_freq, prefno == 1)

# filter list by valid_cell
cell_pref <- merge(valid_cell, valid_sampfreq) 

# OPTIONAL: check if results plausible
# correct if answer: integer(0) = no matching data
which (cell_pref$Freq != 1)

# tidy up the list (OPTIONAL)
cell_pref <- cell_pref[,c('sampname','Pref')]

# write results of cell pref unique pair
write.csv(cell_pref,
          file="../data/cell_exclpref.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# compile exclded cell
excl_cell <- subset(pref_freq, prefno != 1)
# filter list by valid_cell
excell_pref <- merge(excl_cell, valid_sampfreq) 

# write results of excluded cell pref unique pair
write.csv(excl_cell,
          file="../data/excluded_cell.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(excell_pref,
          file="../data/excluded_cellpref.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")


