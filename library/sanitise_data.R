source('../library/GHI.R')

preflist <- read.csv('../data/preflist.csv')$pref

# data preperation steps for prefecture data analysis
sanitise <- function(species_pref_data) {
  species_pref_data <- rename_sampname_to_pref(species_pref_data)
  species_pref_data <- select_relevant_columns(species_pref_data)
  species_pref_data <- filter_star(species_pref_data)
  species_pref_data <- set_pref_levels(species_pref_data)
}

rename_sampname_to_pref <- function(species_pref_data) {
  # rename column from 'sampname' to 'pref'
  column_index <- which(names(species_pref_data) == 'sampname')
  names(species_pref_data)[column_index] <- 'pref'
  
  return(species_pref_data)
}

select_relevant_columns <- function(species_pref_data) {
  species_pref_data[,c('spnumber', 'star', 'pref')]
}

filter_star <- function(species_pref_data) {
  # only consider GHI.colours in species_pref_data
  species_pref_data <- subset(species_pref_data, star %in% GHI.colours)

  # remove unnecessary levels in species_pref_data$star
  species_pref_data$star <- factor(species_pref_data$star, GHI.colours)
  
  return(species_pref_data)
}

filter_rows_by_valid_star <- function(star_sensitivity_data, column_name) {
  # only consider GHI.colours
  valid_star <- star_sensitivity_data[,column_name] %in% GHI.colours
  star_sensitivity_data <- star_sensitivity_data[valid_star,]

  # remove unnecessary levels in star_sensitivity_data$star*
  star_sensitivity_data[,column_name] <- factor(star_sensitivity_data[,column_name], GHI.colours)
  
  return(star_sensitivity_data)
}

set_pref_levels <- function(species_pref_data)
{
  # set necessary levels (all prefectures) in species_pref_data$pref
  species_pref_data$pref <- factor(species_pref_data$pref,preflist)
  return(species_pref_data)
}
