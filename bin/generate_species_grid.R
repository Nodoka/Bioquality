# load all data
species_cell <- read.csv('../data/species_cell.csv', row.names = NULL)
cell_grid    <- read.csv('../data/Horicell_qrx1.csv',    row.names = NULL)
 
# filter for relevant columns
# cell_grid <- cell_grid[,c('sampname','ID','ID_2')]
species_cell <- species_cell[,c('sampname','species','spnumber','star','horim_page')]

# merge dataframes
species_grid <- merge(species_cell, cell_grid)

# select unique species-grid pairs for quarter (qr) and one (x1) grid seperately 
species_qrgrid <- unique(species_grid[,c('species','spnumber','star','horim_page','ID')])
species_x1grid <- unique(species_grid[,c('species','spnumber','star','horim_page','ID_2')])

# rename columns from 'ID', 'ID_2' to 'qrgrid', 'x1grid'
column_index <- which(names(species_qrgrid) == 'ID')
names(species_qrgrid)[column_index] <- 'qrgrid'
column_index <- which(names(species_x1grid) == 'ID_2')
names(species_x1grid)[column_index] <- 'x1grid'

# write results to file
write.csv(species_qrgrid,
          file="../data/species_qrgrid.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

write.csv(species_x1grid,
          file="../data/species_x1grid.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)


----------------------------------------
new bin or library: 'grid_sp_area reference'
# load all data
# species_cell <- read.csv('../data/species_cell.csv', row.names = NULL)
cell_grid    <- read.csv('../data/Horicell_qrx1.csv',    row.names = NULL)
 

# calculate sum areas for each quarter (qr) and one (x1) grid seperately
# sum all columns for matching ID or ID_2
# qr_grid <- tapply(cell_grid$MAINISL_KM,cell_grid$ID,sum)
# x1_grid <- tapply(sum)


# filter for relevant columns
# cell_grid <- cell_grid[,c('sampname','ID','ID_2','OCEAN_KM',MAINISL_KM', 'SMALLISL_KM','TOTAL_KM')]
# species_cell <- species_cell[,c('sampname','species','spnumber','star','horim_page')]

# merge dataframes
# species_grid <- merge(species_cell, cell_grid)

# horiqa <- tapply(species_grid$MAINISL_KM,species_grid$spnumber,sum)
#
