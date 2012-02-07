source('../library/GHI.R')

sanitise <- function(species_pref_data) {
  species_pref_data <- rename_sampname_to_pref(species_pref_data)
  species_pref_data <- select_relevant_columns(species_pref_data)
  species_pref_data <- filter_star(species_pref_data)
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
