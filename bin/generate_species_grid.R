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
## calculate area by grid unit
# calculate area of mainland and small islands by selected column
# land_types <- c('MAINISL_KM', 'SMALLISL_KM')
# ids <- c("ID", "ID_2") or sampnmae
# sum_area <- function(data,area,column){
#  return(tapply(data[,area], data[,column], sum))}
# for (area in land_type) {
#  for(id in ids) {    
#    data <- sum_area(data, area)}}

qr_mainisl   <- tapply(cell_grid$MAINISL_KM,cell_grid$ID,sum)
qr_smallisl  <- tapply(cell_grid$SMALLISL_KM,cell_grid$ID,sum)
qr_totalland <- qr_mainisl + qr_smallisl
qr_areasum   <- cbind(qr_mainisl,qr_smallisl,qr_totalland)
qr_area      <- data.frame(qrgrid=row.names(qr_areasum),      
		qr_mainisl=qr_areasum[,1],
		qr_smallisl=qr_areasum[,2],
		qr_totalland=qr_areasum[,3])

x1_mainisl   <- tapply(cell_grid$MAINISL_KM,cell_grid$ID_2,sum)
x1_smallisl  <- tapply(cell_grid$SMALLISL_KM,cell_grid$ID_2,sum)
x1_totalland <- x1_mainisl + x1_smallisl
x1_areasum   <- cbind(x1_mainisl,x1_smallisl,x1_totalland)
x1_area      <- data.frame(x1grid=row.names(x1_areasum),      
		x1_mainisl=x1_areasum[,1],
		x1_smallisl=x1_areasum[,2],
		x1_totalland=x1_areasum[,3])
----------------------------------------------------------------------
## area calculation for species on grids
# combine species_grid and grid_area
species_qrarea <- merge(species_qrgrid, qr_area)
species_x1area <- merge(species_x1grid, x1_area)

# sum area by species
spqr_mainisl   <- tapply(species_qrarea$qr_mainisl,species_qrarea$spnumber,sum)
spqr_smallisl  <- tapply(species_qrarea$qr_smallisl,species_qrarea$spnumber,sum)
spqr_totalland <- spqr_mainisl + spqr_smallisl
spqr_areasum   <- cbind(spqr_mainisl,spqr_smallisl,spqr_totalland)
spqr_area      <- data.frame(spnumber=row.names(spqr_areasum),      
		  spqr_mainisl=spqr_areasum[,1],
		  spqr_smallisl=spqr_areasum[,2],
		  spqr_totalland=spqr_areasum[,3])

spx1_mainisl   <- tapply(species_x1area$x1_mainisl,species_x1area$spnumber,sum)
spx1_smallisl  <- tapply(species_x1area$x1_smallisl,species_x1area$spnumber,sum)
spx1_totalland <- spx1_mainisl + spx1_smallisl
spx1_areasum   <- cbind(spx1_mainisl,spx1_smallisl,spx1_totalland)
spx1_area      <- data.frame(spnumber=row.names(spx1_areasum),      
		  spx1_mainisl=spx1_areasum[,1],
		  spx1_smallisl=spx1_areasum[,2],
		  spx1_totalland=spx1_areasum[,3])


# write results to file
write.csv(spqr_area,
          file="../data/species_qrarea.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

write.csv(spx1_area,
          file="../data/species_x1area.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)
