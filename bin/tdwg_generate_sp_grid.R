source('../library/sanitise_data.R')

# load all data
sp_tdwg   <- read.csv('../data/tdwgl3spdataall.csv', row.names = NULL)
tdwg_grid <- read.csv('../data/tdwgl3x1_area.csv',    row.names = NULL)
# load tdwg species list
tdwg <- read.csv('../data/tdwgsp.csv',     row.names = NULL)
# uncomment to use R generated tdwg species list
# tdwgr <- read.csv('../data/tdwgspR.csv',     row.names = NULL)
# tdwg <- tdwgr

# filter for relevant columns
sp_tdwg   <- sp_tdwg[,c('spnumber','star_infs','l3code')]
tdwg_grid <- tdwg_grid[,c('LEVEL3_COD','AREA','PERIMETER','ID')]
tdwg      <- tdwg[,c('spnumber','family','genus','sp1','rank1','sp2','star_infs','tdwgtotals','tdwgareas')] 

# rename columns from 'LEVEL3_COD' to 'l3code'
column_index <- which(names(tdwg_grid) == 'LEVEL3_COD') 
                names(tdwg_grid)[column_index] <- 'l3code'

# unique pair of grid vs. l3code
grid_l3 <- aggregate(tdwg_grid$AREA, list(l3code=tdwg_grid$l3code,ID=tdwg_grid$ID), sum)

# rename the column "x"
names(grid_l3)[3] <- 'areas'

# filter AREA < 0.01
valid_area <- subset(grid_l3, areas > 0.009999)
tdwg_grid <- valid_area

# grid stats: the number of x1grid per l3code
countsum <- table(tdwg_grid$l3code)

# grid stats: mean and sum of x1 grid area per l3 code
areamean <- tapply(tdwg_grid$areas, tdwg_grid$l3code, mean)
areasum  <- tapply(tdwg_grid$areas, tdwg_grid$l3code, sum)

# convert to dataframe
gridstats <- data.frame(l3code=row.names(countsum), 
                        x1sumcount=countsum[],
                        x1areamean=areamean[],
                        x1areasum=areasum[])

# create species - grid list
sp_grid <- merge(sp_tdwg, tdwg_grid)

# rearrange data in descending order of sect_areasum
# sp_grid <- sp_grid[order(-sp_grid$areas),]

# select unique species-grid pairs for ID
# species_grid <- sp_grid[!duplicated(sp_grid$ID),]
# species_grid <- unique(sp_grid[,c('spnumber','star_infs','ID')])

# grid count calculation
sp_gridcount  <- table(sp_grid[,'spnumber'])
species_gridcount <- data.frame(spnumber=row.names(sp_gridcount),x1count=sp_gridcount[])

# merge grid count and species list
tdwg_count <- merge(species_gridcount,tdwg)

# filter for valid stars
tdwg_count <- filter_rows_by_valid_star(tdwg_count,'star_infs')

# filter infra taxa
tdwg_sp <- subset(tdwg_count, rank1 != "subsp." & rank1 != "var." & rank1 != "f.")
tdwg_count <- tdwg_sp

# write results to file
write.csv(tdwg_count,
          file="../data/tdwgsp_x1count.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

# calculate weights
tdwgx1 <- tdwg_count

# index T/F of family != (not equal) Gramineae,
fam           <- tdwgx1[,'family']
not_gramineae <- fam != 'Gramineae'
# then filter tdwg with the index.
no_grass_tdwg <- tdwgx1[not_gramineae,]
tdwgx1 <- no_grass_tdwg

# mean x1count and then weight
meancount <- tapply(tdwg$x1count, tdwg$star_infs, mean)
w <- meancount['GN']/meancount


