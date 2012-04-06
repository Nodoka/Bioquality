# load data
cell_pref  <- read.csv('../data/cell_pref.csv',    row.names = NULL)

# OPTIONAL: not necessary with a dataset after March 2012
# remove subcells representing water parts of cells, with no prefecture
# cell_pref <- subset(cell_pref, pref != "")

# unique pair of cell vs. pref
cell_pref <- aggregate(cell_pref$sect_area, list(sampname=cell_pref$sampname,Pref=cell_pref$Pref), sum)

# rename the column "x"
names(cell_pref)[3] <- 'sect_areasum'

# rearrange data in descending order of sect_areasum
cell_pref <- cell_pref[order(-cell_pref$sect_area),]

# select unique cell-pref pair
cell_pref <- cell_pref[!duplicated(cell_pref$sampname),]

# write results of cell pref unique pair
write.csv(cell_pref,
          file="../data/cell_uniqpref.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
