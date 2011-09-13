# load all data
species_cell <- read.csv('../data/species_cell.csv', row.names = NULL)
cell_pref    <- read.csv('../data/cell_pref.csv',    row.names = NULL)

# filter for relevant columns
cell_pref <- cell_pref[,c('X.Pref_en','sampname')]
species_cell <- species_cell[,c('sampname','species','star')]

# merge dataframes
species_pref <- merge(species_cell, cell_pref)

# select unique species-prefecture pairs
species_pref <- unique(species_pref[,c('species','star','X.Pref_en')])

# remove subcells representing water parts of cells, with no prefecture
species_pref <- subset(species_pref, X.Pref_en != "")

# write results to file
write.csv(species_pref, file="../data/species_pref.csv", fileEncoding="UTF-8")
