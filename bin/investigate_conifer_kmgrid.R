# load all data
conifer <- read.csv('../data/conifer_kmgrid.csv', row.names = NULL)

# delete lat,long = 0
valid_conifer <- subset(conifer, lat != 0 & long !=0)

# filter relevant columns
conifer_km <- valid_conifer[,c('spnumber','xi','yi')]

# generate kmgrid ID
conifer_km[,'rounded_x']  <- round(conifer_km[,'xi']/100000,0)
conifer_km[,'rounded_y']  <- round(conifer_km[,'yi']/100000,0)
kmplot <- unique(conifer_km[,c('rounded_x','rounded_y')])
kmplot$kmgrid <- 1:nrow(kmplot)  


# create species - grid list
conifer_grid <- merge(conifer_km, kmplot)

# select unique species-grid pairs for km grid
conifer_kmgrid <- unique(conifer_grid
[,c('spnumber','rounded_x','rounded_y','kmgrid')])

## grid count calculation
sp_kmgrid  <- table(conifer_kmgrid[,'spnumber'])
sp_kmcount <- data.frame(spnumber=row.names(sp_kmgrid),
                         kmcount=sp_kmgrid[])

# write results to file
write.csv(sp_kmcount,
          file="../data/conifer_kmcount.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

