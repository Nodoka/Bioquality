source('../library/sanitise_data.R')

# load data
tdwg <- read.csv('../data/tdwgsp.csv',     row.names = NULL)

# filter for valid stars
tdwg <- filter_rows_by_valid_star(tdwg,'star_geo')

# calculate mean of selected column grouped by stars
tdwgc <- tapply(tdwg$tdwgtotals, tdwg$star_geo, mean)
tdwga <- tapply(tdwg$tdwgareas, tdwg$star_geo, mean)

# merge resulting mean tables to one
meantdwg <- rbind(tdwgc,tdwga)

# calculate weights for stars
weight_tdwg <- meantdwg[,'GN']/meantdwg

# scatter plot
plot(tdwg$tdwgtotals,tdwg$tdwgareas)

# save plot on display as a file
     savePlot(filename = "../data/twdg_scatter.tiff", type="tiff")
     

