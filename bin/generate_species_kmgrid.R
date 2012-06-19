source('../library/sanitise_data.R')

# load all data
species_cell <- read.csv('../data/species_cell.csv', row.names = NULL)
cell_grid    <- read.csv('../data/Horicell_kmgrid.csv',    row.names = NULL)

# select and rename relevant star columns
species_cell <- rename_star_to_xstar(species_cell)
species_cell <- rename_starinfs_to_star(species_cell)
 
# filter for relevant columns
cell_grid    <- cell_grid[,c('sampname','XI','YI')]
species_cell <- species_cell[,c('sampname','spnumber','star')]

# generate kmgrid ID
cell_grid[,'rounded_x']  <- round(cell_grid[,'XI']/100000,0)
cell_grid[,'rounded_y'] <- round(cell_grid[,'YI']/100000,0)
kmplot <- unique(cell_grid[,c('rounded_x','rounded_y')])
kmplot$kmgrid <- 1:nrow(coord)  

cell_grid <- merge(cell_grid, kmplot)

## create species - grid list
# merge dataframes
species_cell <- merge(species_cell, cell_grid)

# select unique species-grid pairs for km grid
species_kmgrid <- unique(species_cell[,c('spnumber','star','rounded_x','rounded_y','kmgrid')])

# write results to file
write.csv(species_kmgrid,
          file="../data/species_kmgrid.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)


## grid count calculation
sp_kmgrid  <- table(species_kmgrid[,'spnumber'])
sp_kmcount <- data.frame(spnumber=row.names(sp_kmgrid),kmcount=sp_kmgrid[])

# write results to file
write.csv(sp_kmcount,
          file="../data/species_kmcount.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

## calculate weight
source('../library/star_weight_stats.R')

# load data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)

# filter relevant columns
horiw <- horiw[c('spnumber','family','infra','star_infs','horim_page','horim_end')]

# merge count data to hori data
horiw_km <- merge(horiw, sp_kmcount)

# filter for valid stars
horiw_km <- filter_rows_by_valid_star(horiw_km,'star_infs')

# filter infraspecific taxa
horiw_km <- filter_infra(horiw_km)

# uncomment to run analysis only with endemics
# horiw_km <- filter_endemics(horiw_km)

# uncomment to run analysis without GN
# horiw_km <- filter_nogn(horiw_km)

# mean counts km grid cells of occurrence, grouped by star
mean_count <- tapply(horiw_km$kmcount, horiw_km$star_infs, mean)

# calculate weights for stars
weight_count <- mean_count['BU']/mean_count
