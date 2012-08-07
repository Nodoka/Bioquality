source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
# original data of species = Utaki_plotspecies.csv (with Brahms generated incorrect gazcode)
sp_utaki <- read.csv('../data/Utaki_species.csv',     row.names = NULL)
plot_utaki <- read.csv('../data/Utaki_plot.csv',     row.names = NULL)
gaz_utaki  <- read.csv('../data/Utaki_gazcode.csv', row.names = NULL)

# filter relevant columns
sp_utaki <- sp_utaki[,c('scode','sampname','spnumber','star_infs')]
plot_utaki <- plot_utaki[,c('scode','sampname','gazcode')]

# using plot scode, apply gazcode to spdata
sp_gaz <- merge(sp_utaki, plot_utaki)
# if sp_utaki already contains gazcode, only change the name
# sp_gaz <- sp_utaki

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
# CHECK IF 474 SAMPLES!!

# make a new column with either of cell or pref score absed on spno
less_than_40 <- scores_frame$gaz_spcount < 40
less_than_40[is.na(less_than_40)] <- T

scores_frame[!less_than_40,'valid_score'] <- scores_frame[!less_than_40, 'gaz_score']


# select relevant columns on gazcode information
gaz <- gaz_utaki[,c('gazcode','major','minor','locality','lat','ns','long','ew')]

# merge scores and gazcode
gaz_ghi <- merge(gaz, scores_frame, all.x = TRUE)

# optional: add ME major1 classification
#gazme <- read.csv('../data/Utaki_gazMEvg.csv', row.names =NULL)
#me <- gazme[,c('gazcode','MAJOR1','NAME')]
# merge MEvg to scores
#gaz_ghi <- merge(gaz_ghi, me)

# optional: add 50m elevation
#gazelev <- read.csv('../data/Utaki_gazELEV.csv', row.names =NULL)
#elev <- gazelev[,c('gazcode','ELEV')]
# merge gazelev to scores
#gaz_ghi <- merge(gaz_ghi, elev)

# merge scores and full gazcode infor
gazinfo_ghi <- merge(gaz_utaki, scores_frame)

# write results to csv
write.csv(gaz_ghi,
          file="../data/Utakigaz_score.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)
write.csv(gazinfo_ghi,
          file="../data/Utakigaz_scoreinfo.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

