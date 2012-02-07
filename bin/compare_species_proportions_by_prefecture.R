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

# convert table into vector? i.e.number of star as vector, then sum the total number of species per prefecture
# paired-t test between the number of species per prefecture (or rather proportions relative to the total species pool) between hori and foj
