source('../library/sanitise_data.R')

# load data
tdwg <- read.csv('../data/tdwgsp.csv',     row.names = NULL)
# uncomment to use R generated tdwg species list
# tdwgr <- read.csv('../data/tdwgspR.csv',     row.names = NULL)
# tdwg <- tdwgr

# filter for valid stars
tdwg <- filter_rows_by_valid_star(tdwg,'star_infs')

# filter infra taxa
tdwg_sp <- subset(tdwg, rank1 != "subsp." & rank1 != "var." & rank1 != "f.")
# uncomment to run analysis without infra taxa
tdwg <- tdwg_sp

# index T/F of family != (not equal) Gramineae,
fam           <- tdwg[,'family']
not_gramineae <- fam != 'Gramineae'
# then filter tdwg with the index.
no_grass_tdwg <- tdwg[not_gramineae,]
tdwg <- no_grass_tdwg

# calculate mean of selected column grouped by stars
tdwgc <- tapply(tdwg$tdwgtotals, tdwg$star_infs, mean)
tdwga <- tapply(tdwg$tdwgareas, tdwg$star_infs, mean)

# merge resulting mean tables to one
meantdwg    <- rbind(tdwgc,tdwga)

# calculate weights for stars
weight_tdwg <- meantdwg[,'GN']/meantdwg

# select and reshuffle relevant columns
tdwg_data <- tdwg[,c('spnumber','star_infs','tdwgtotals','tdwgareas',
'family','genus','sp1','rank1','sp2','species')]

# save filtered data to csv
write.csv(tdwg_data,
          file="../data/tdwgsp_filtered.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
