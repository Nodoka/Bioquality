source('../library/sanitise_data.R')

# load data
tdwg <- read.csv('../data/tdwgsp.csv',     row.names = NULL)

# filter for valid stars
tdwg <- filter_rows_by_valid_star(tdwg,'star_infs')

# index T/F of family != (not equal) Gramineae,
fam <- tdwg[,'family']
not_gramineae <- fam != 'Gramineae'
# then filter tdwg with the index.
no_grass_tdwg <- tdwg[not_gramineae,]

# calculate mean of selected column grouped by stars
tdwgc <- tapply(tdwg$tdwgtotals, tdwg$star_geo, mean)
tdwga <- tapply(tdwg$tdwgareas, tdwg$star_geo, mean)

# merge resulting mean tables to one
meantdwg <- rbind(tdwgc,tdwga)

# calculate weights for stars
weight_tdwg <- meantdwg[,'GN']/meantdwg
