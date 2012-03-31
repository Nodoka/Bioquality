source('../library/sanitise_data.R')

# load data
cell_pref  <- read.csv('../data/cell_pref.csv',    row.names = NULL)

# OPTIONAL
# rename column from 'Pref' to 'pref'
column_index <- which(names(cell_pref) == 'Pref')
		names(cell_pref)[column_index] <- 'pref'
# set pref levels
cell_pref <- set_pref_levels(cell_pref)

# OPTIONAL: not necessary with a dataset after March 2012
# remove subcells representing water parts of cells, with no prefecture
cell_pref <- subset(cell_pref, pref != "")

# unique pair of cell vs. pref
cell_pref <- aggregate(cell_pref$sect_area, list(sampname=cell_pref$sampname,pref=cell_pref$pref), sum)

# rename the column "x"
names(cell_pref)[3] <- 'sect_areasum'

# rearrange data in descending order of sect_areasum
cell_pref <- cell_pref[order(-cell_pref$sect_areasum),]

# order remaining, dont filter
# select unique cell-pref pair
cell_pref <- unique(cell_pref[,c('sampname','pref')])
