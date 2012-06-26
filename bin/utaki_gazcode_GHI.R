source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
# original data of species = Utaki_plotspecies.csv (with Brahms generated incorrect gazcode)
sp_utaki <- read.csv('../data/Utaki_species.csv',     row.names = NULL)
plot_utaki <- read.csv('../data/Utaki_plot.csv',     row.names = NULL)
gaz_utaki  <- read.csv('../data/Utaki_gazcode.csv', row.names = NULL)

# using plot scode, apply gazcode to spdata
sp_gaz <- merge(sp_utaki,plot_utaki)

# filter valid stars for star_infs
utaki_sp <- filter_rows_by_valid_star(sp_gaz, 'star_infs')

# filter unique species
utaki_sp <- unique(utaki_sp[,c('gazcode','spnumber','star_infs')])

# calculate GHI scores on gazcode
scores <- tapply(utaki_sp$star_infs, utaki_sp$gazcode, calculate_score)

# calculate spcount on gazcode
spcount <- table(utaki_sp$gazcode)

# merge scores into one table
gaz_scores <- cbind(scores,spcount)

# convert scores to dataframe
scores_frame <- data.frame(gazcode=row.names(gaz_scores),
                           gaz_score=gaz_scores[,1],               
                           gaz_spcount=gaz_scores[,2], 
                           row.names=NULL)


