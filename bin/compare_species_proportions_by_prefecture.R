source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
hori <- read.csv('../data/species_pref.csv',     row.names = NULL)
foj  <- read.csv('../data/species_pref_foj.csv', row.names = NULL)

# select and rename relevant star columns
foj <- rename_star_to_xstar(foj)
foj <- rename_starinfs_to_star(foj)

# neaten up raw data frames
hori <- sanitise(hori)
foj  <- sanitise(foj)

# number of species by star and prefecture
hori_table <- table(hori[,c('star', 'pref')])
foj_table  <- table(foj[,c('star', 'pref')])

# number of species by prefecture
hori_spno <- table(hori[,c('pref')])
foj_spno  <- table(foj[,c('pref')])

# merge species number into one table
spnos <- cbind(foj_spno,hori_spno)

# convert scores to dataframe
spnos_frame <- data.frame(preflist=row.names(spnos), foj_spno=spnos[,1], hori_spno=spnos[,2], row.names=NULL)

# write results (scores) to file
write.csv(spnos_frame,
          file="../data/FOJHori_spnos.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# paired-t test between the number of species per prefecture (or rather proportions relative to the total species pool) between hori and foj? check histogram if normally distributed. also think how to treat data = 0
# rank correlation analysis for the sum number of species
cor(foj_spno,hori_spno, method = "spearman")

# fit a linear model (linear regression analysis)
compare_spnos <- lm(rank(t(hori_spno)) ~ rank(t(foj_spno)))

# graphs to be considered.


