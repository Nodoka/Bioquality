# load all data
conifer <- read.csv('../data/conifer_splocgridcells.csv', row.names = NULL)

# delete lat,long = 0
valid_conifer <- subset(conifer, lat != 0 & long !=0)

# filter relevant columns
conifer_latlong <- valid_conifer[,c('spnumber','lat','long')]

# generate degreegrid ID
latlong <- unique(conifer_latlong[,c('lat','long')])
latlong$gridcell <- 1:nrow(latlong)  


# create species - grid list
conifer_grid <- merge(conifer_latlong, latlong)

# select unique species-grid pairs for km grid
conifer_onegrid <- unique(conifer_grid
[,c('spnumber','lat','long','gridcell')])

## grid count calculation
sp_onegrid   <- table(conifer_onegrid[,'spnumber'])
sp_gridcount <- data.frame(spnumber=row.names(sp_onegrid),
                           gridcount=sp_onegrid[])

# write results to file
write.csv(sp_gridcount,
          file="../data/conifer_gridcount.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)


