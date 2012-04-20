source('../library/sanitise_data.R')

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

# GHI scores by cell (sampname) for a chosen star classification method
cal_cell_score <- tapply(species_cell$star_infs,  species_cell$sampname,  calculate_score)

# convert results to dataframe
cell_score <- data.frame(sampname=row.names(cal_cell_score),              
                         GHI=cal_cell_score[],
                         row.names=NULL)

# OPTIONAL: filter cell with spcount > 39
# deleted from this script
