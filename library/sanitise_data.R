source('../library/GHI.R')

sanitise_foj <- function(foj) {
  # rename column from 'sampname' to 'pref'
  column_index <- which(names(foj) == 'sampname')
  names(foj)[column_index] <- 'pref'

  # select relevant columns
  foj[,c('species', 'star', 'pref')]
  
  filter_star(foj)
}

sanitise_hori <- function(hori) {
  filter_star(hori)
}

filter_star <- function(species_pref_data) {
  # only consider GHI.colours in species_pref_hori
  species_pref_data <- subset(species_pref_data, star %in% GHI.colours)

  # remove unnecessary levels in species_pref_hori$star
  species_pref_data$star <- factor(species_pref_data$star, GHI.colours)
  
  return(species_pref_data)
}