# load all data
spall <- read.csv('../data/tdwgl3spdataall.csv',row.names=NULL)
tdwg_l3     <- read.csv('../data/tdwgl3_brahms.csv',    row.names = NULL)

# rename columns from 'tdwg', 'l3code' to 'l3code', 'xl3code'
# column_index <- which(names(spall) == 'l3code') 
#                 names(spall)[column_index] <- 'xl3code'
# column_index <- which(names(spall) == 'tdwg') 
#                 names(spall)[column_index] <- 'l3code'

# reference species list
splist <- unique(spall[,c('spnumber','star_infs','family','genus','sp1','rank1','sp2')])

# filter for relevant columns
spdata <- spall[,c('spnumber','l3code','star_infs')]
tdwg_l3 <- tdwg_l3[,c('l3code','area','perimeter')]

# merge dataframes
sp_l3 <- merge(spdata, tdwg_l3)

# calculate total count, area, and perimeter of l3code by spnumber
sp_count     <- table(sp_l3[,'spnumber'])
sp_area      <- tapply(sp_l3$area,sp_l3$spnumber,sum)
sp_perimeter <- tapply(sp_l3$perimeter,sp_l3$spnumber,sum)
sp_sums      <- cbind(sp_count,sp_area,sp_perimeter)
sp_tdwgsums  <- data.frame(spnumber=row.names(sp_sums),
                           tdwgtotals=sp_sums[,1],
                           tdwgareas=sp_sums[,2])

# make a new list with area
tdwgsp_list <- merge(splist,sp_tdwgsums)

# write results to file
write.csv(tdwgsp_list,
          file="../data/tdwgspR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
