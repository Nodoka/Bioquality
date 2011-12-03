source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
hori <- read.csv('../data/species_pref.csv',     row.names = NULL)
foj  <- read.csv('../data/species_pref_foj.csv', row.names = NULL)

# neaten up raw data frames
hori <- sanitise(hori)
foj  <- sanitise(foj)

# number of species by star and prefecture
hori_table <- table(hori[,c('star', 'pref')])
foj_table  <- table(foj[,c('star', 'pref')])
