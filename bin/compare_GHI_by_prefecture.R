source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
hori <- read.csv('../data/species_pref.csv',     row.names = NULL)
foj  <- read.csv('../data/species_pref_foj.csv', row.names = NULL)

# neaten up raw data frames
hori <- sanitise(hori)
foj  <- sanitise(foj)

# number of species by star and prefecture
calculate_score = function(subgroup) {
  GHI.score(GHI.star_frequencies(subgroup))
}

hori_scores <- tapply(hori$star, hori$pref, calculate_score)
foj_scores  <- tapply(foj$star,  foj$pref,  calculate_score)
