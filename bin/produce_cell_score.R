source('../library/sanitise_data.R')
source('../library/GHI.R')

# load data
species_cell   <- read.csv('../data/species_cell.csv', row.names = NULL)

# filter valid stars for chosen star column
species_cell   <- filter_rows_by_valid_star(species_cell,'star_infs')

# remove moss species (horim_page = 471~500)
# uncomment to include moss sp
not_moss <- subset(species_cell, horim_page <471 | horim_page>500) 
species_cell <- not_moss

# filter out Gramineae (optional)
filter_grass <- function(species_plot){
  # index T/F of family != (not equal) Gramineae
  family        <- species_plot[,'family']
  not_gramineae <- family != 'Gramineae'
  # then filter plot data with the index
  species_plot  <- species_plot[not_gramineae,]
  return(species_plot)
}

# uncomment to filter out grass
# species_cell <- filter_grass(species_cell)

# calculate species count for cell
spnum_cell <- table(species_cell$sampname)

# GHI scores by cell (sampname) for a chosen star classification method
cal_cell_score <- tapply(species_cell$star_infs,  species_cell$sampname,  calculate_score)

# check if the order of row name(sampname) is the same
which(row.names(cal_cell_score) != row.names(spnum_cell))

# convert results to dataframe
cell_score <- data.frame(sampname=row.names                (cal_cell_score),              
                         GHI=cal_cell_score[],
                         spno=spnum_cell[])

# OPTIONAL: filter cell with spcount > 39
spcount <- spnum_cell > 39
valid_scores <- cell_score[spcount,]
# alternatively: add valid_score column
cell_score[spcount,'valid_scores'] <- cell_score[spcount,'GHI']
# replace NA with -1 or make a column with 0 (valid_score)
cell_score$valid_scores[is.na(cell_score$valid_scores)] <- -1
#cell_score$valid_score[is.na(cell_score$valid_score)] <- 0

# write results to csv
write.csv(cell_score,
          file="../data/hori_plot_scoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(valid_scores,
          file="../data/hori_plot_validscoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
