source('../library/sanitise_data.R')

# load all data
species_cell <- read.csv('../data/species_cell.csv', row.names = NULL)
cell_grid    <- read.csv('../data/Horicell_qrx1.csv',    row.names = NULL)

# select and rename relevant star columns
species_cell <- rename_star_to_xstar(species_cell)
species_cell <- rename_starinfs_to_star(species_cell)
 
# filter for relevant columns
cell_grid    <- cell_grid[,c('sampname','MAINISL_KM','SMALLISL_KM','ID','ID_2')]
species_cell <- species_cell[,c('sampname','species','spnumber','star','horim_page')]

## create species - grid list
# merge dataframes
species_cell <- merge(species_cell, cell_grid)

# select unique species-grid pairs for quarter (qr) or one (x1) grid
species_qrgrid <- unique(species_cell[,c('species','spnumber','star','horim_page','ID')])
species_x1grid <- unique(species_cell[,c('species','spnumber','star','horim_page','ID_2')])

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

--------------------
## grid count calculation
sp_qrgrid  <- table(species_qrgrid[,'spnumber'])
sp_qrcount <- data.frame(spnumber=row.names(sp_qrgrid),qrcount=sp_qrgrid[])

sp_x1grid  <- table(species_x1grid[,'spnumber'])
sp_x1count <- data.frame(spnumber=row.names(sp_x1grid),x1count=sp_x1grid[])

# write results to file
write.csv(sp_qrcount,
          file="../data/species_qrcount.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

write.csv(sp_x1count,
          file="../data/species_x1count.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)
------------------------------
# compute range size stats
compute_area_sum <- function(area_records, grouping) {
  mainisl   <- tapply(area_records[,1], grouping, sum)
  smallisl  <- tapply(area_records[,2], grouping, sum)
  totalland <- mainisl + smallisl
  areasum   <- cbind(mainisl,smallisl,totalland)
}

# run compute range size stats for cell_grid records
compute_area_sum_for_cell <- function(grid_data, grid_id) {
  grid_area <- grid_data[,c('MAINISL_KM', 'SMALLISL_KM')]
  compute_area_sum(grid_area, grid_id)
}

compute_area_sum_for_species <- function(sp_griddata, spnumber) {
  grid_area <- sp_griddata[,c('mainisl', 'smallisl')]
  compute_area_sum(grid_area, spnumber)
}

# convert stats results to dataframe
sum_to_dataframe <- function(grid_areasum){
data.frame(datatype=row.names(grid_areasum),
           mainisl=grid_areasum[,1],
           smallisl=grid_areasum[,2],
           totalland=grid_areasum[,3])
}


# calculate area by grid unit
qr_areasum <- compute_area_sum_for_cell(cell_grid, cell_grid$ID)
qr_area <- sum_to_dataframe(qr_areasum)
names(qr_area)[1] <- 'qrgrid'

x1_areasum <- compute_area_sum_for_cell(cell_grid, cell_grid$ID_2)
x1_area <- sum_to_dataframe(x1_areasum)
names(x1_area)[1] <- 'x1grid'


## area calculation for species on grids
# combine species_grid and grid_area
species_qrarea <- merge(species_qrgrid, qr_area)
species_x1area <- merge(species_x1grid, x1_area)

# sum area by species
spqr_areasum <- compute_area_sum_for_species(species_qrarea, species_qrarea$spnumber)
spqr_area <- sum_to_dataframe(spqr_areasum)
names(spqr_area)[1] <- 'spnumber'

spx1_areasum <- compute_area_sum_for_species(species_x1area, species_x1area$spnumber)
spx1_area <- sum_to_dataframe(spx1_areasum)
names(spx1_area)[1] <- 'spnumber'

# write results to file
write.csv(spqr_area,
          file="../data/species_qrarea.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

write.csv(spx1_area,
          file="../data/species_x1area.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

# column names prior to May01:
# grid_area
# mainisl = qr_mainisl or x1_mainisl
# small isl = qr_smallisl or x1_smallisl
# totalland = qr_totalland or x1_totalland
# sp_gridarea
# mainisl = spqr_mainisl or spx1_mainisl
# small isl = spqr_smallisl or spx1_smallisl
# totalland = spqr_totalland or spx1_totalland

