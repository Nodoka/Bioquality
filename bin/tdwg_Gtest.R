# load data
tdwg <- read.csv('../data/tdwgsp.csv',     row.names = NULL)

# calculate mean of selected column grouped by stars
tdwgc <- tapply(tdwg$tdwgtotals, tdwg$star_geo, mean)
tdwga <- tapply(tdwg$tdwgareas, tdwg$star_geo, mean)

# merge resulting mean tables to one
meantdwg <- rbind(tdwgc,tdwga)

# scatter plot
plot(tdwg$tdwgtotals,tdwg$tdwgareas)

# save plot on display as a file
     savePlot(filename = paste("Rplot", type, sep="."),
              type = c("png", "jpeg", "tiff", "bmp"),
              device = dev.cur())
     

