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

# create species - grid list
sp_grid <- merge(sp_tdwg, tdwg_grid)

# select unique species-grid pairs for ID
species_grid <- unique(sp_grid[,c('spnumber','star_infs','ID')])

# grid count calculation
sp_gridcount  <- table(species_grid[,'spnumber'])
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
