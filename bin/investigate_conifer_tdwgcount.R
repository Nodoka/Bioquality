# load all data
conifer <- read.csv('../data/conifer_tdwgspdataall.csv', row.names = NULL)

# delete l3code is empty
valid_conifer <- subset(conifer, l3code != '')

# filter relevant columns
conifer_tdwg <- valid_conifer[,c('spnumber','l3code')]

# select unique species-tdwg l3 pairs
conifer_l3 <- unique(conifer_tdwg[,c('spnumber','l3code')])

## grid count calculation
sp_tdwg  <- table(conifer_l3[,'spnumber'])
sp_tdwgcount <- data.frame(spnumber=row.names(sp_tdwg),
                           tdwgcount=sp_tdwg[])

# write results to file
write.csv(sp_tdwgcount,
          file="../data/conifer_tdwgcount.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)


