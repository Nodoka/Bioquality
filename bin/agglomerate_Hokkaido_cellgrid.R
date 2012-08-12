source('../library/sanitise_data.R')
source('../library/GHI.R')

#  load all data
species_cell  <- read.csv('../data/species_cell.csv', row.names = NULL)
Hokkaido_grid <- read.csv('../data/Hokkaido_qrx1grid.csv',    row.names = NULL)

# select and rename relevant star columns
species_cell <- rename_star_to_xstar(species_cell)
species_cell <- rename_starinfs_to_star(species_cell)

# remove moss species (horim_page = 471~500)
not_moss     <- subset(species_cell, horim_page <471 | horim_page>500) 
species_cell <- not_moss

# rename columns from 'ID', 'ID_2', 'SAMPNAME' to 'qrgrid', 'x1grid', 'sampnmae'
column_index <- which(names(Hokkaido_grid) == 'ID') 
                names(Hokkaido_grid)[column_index] <- 'qrgrid'
column_index <- which(names(Hokkaido_grid) == 'ID_2') 
                names(Hokkaido_grid)[column_index] <- 'x1grid'
column_index <- which(names(Hokkaido_grid) == 'SAMPNAME') 
                names(Hokkaido_grid)[column_index] <- 'sampname'

# filter for relevant columns
Hokkaido_grid <- Hokkaido_grid[,c('sampname','qrgrid','x1grid')]
species_cell  <- species_cell[,c('sampname','spnumber','star')]

# create species - grid list by merging dataframes
species_cell <- merge(species_cell, Hokkaido_grid)

# select unique species-grid pairs for quarter (qr) or one (x1) grid
species_qrgrid <- unique(species_cell[,c('spnumber','star','qrgrid')])
species_x1grid <- unique(species_cell[,c('spnumber','star','x1grid')])

# calculate scores
qr_scores  <- tapply(species_qrgrid$star, species_qrgrid$qrgrid,  calculate_score)
x1_scores  <- tapply(species_x1grid$star, species_x1grid$x1grid,  calculate_score)

# calculate spcount
qr_spcount <- table(species_qrgrid$qrgrid)
x1_spcount <- table(species_x1grid$x1grid)

# make a summary table
qr_results <- cbind(qr_scores, qr_spcount)
x1_results <- cbind(x1_scores, x1_spcount)

# convert to dataframe
qr_dataframe <- data.frame(qrgrid=row.names(qr_results),
                           qrscore=qr_results[,1],
                           qrcount=qr_results[,2])

x1_dataframe <- data.frame(x1grid=row.names(x1_results),
                           x1score=x1_results[,1],
                           x1count=x1_results[,2])

# make a new column with score or NA based on spcount for qr and x1
less_than_40 <- qr_dataframe$qrcount < 40
less_than_40[is.na(less_than_40)] <- T

qr_dataframe[!less_than_40,'valqrGHI'] <- qr_dataframe[!less_than_40,'qrscore']

less_than_40 <- x1_dataframe$x1count < 40
less_than_40[is.na(less_than_40)] <- T

x1_dataframe[!less_than_40,'valx1GHI'] <- x1_dataframe[!less_than_40,'x1score']

# merge results to input
Hokkaido_qrscores <- merge(Hokkaido_grid, qr_dataframe, all.x=T)
Hokkaido_scores <- merge(Hokkaido_qrscores, x1_dataframe, all.x=T)

# write results to csv
write.csv(Hokkaido_scores,
          file="../data/Hokkaido_score.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

