source('../library/sanitise_data.R')

# load all data
species_cell <- read.csv('../data/species_cell.csv', row.names = NULL)
cell_pref    <- read.csv('../data/cell_pref.csv',    row.names = NULL)

# select and rename relevant star columns
species_cell <- rename_star_to_xstar(species_cell)
species_cell <- rename_starinfs_to_star(species_cell)

# OPTIONAL: remove moss species (horim_page = 471~500)
not_moss <- subset(species_cell, horim_page <471 | horim_page>500) 
species_cell <- not_moss

# filter for relevant columns
cell_pref <- cell_pref[,c('Pref','sampname')]
species_cell <- species_cell[,c('sampname','species','spnumber','star')]

# merge dataframes
species_pref <- merge(species_cell, cell_pref)

# select unique species-prefecture pairs
species_pref <- unique(species_pref[,c('species','spnumber','star','Pref')])

# remove subcells representing water parts of cells, with no prefecture
species_pref <- subset(species_pref, Pref != "")

# rename column from 'Pref' to 'pref'
column_index <- which(names(species_pref) == 'Pref')
names(species_pref)[column_index] <- 'pref'

# write results to file
write.csv(species_pref,
          file="../data/species_pref.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)
