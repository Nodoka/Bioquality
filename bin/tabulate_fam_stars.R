source('../library/sanitise_data.R')
source('../library/GHI.R')

# load data for star sensitivity analysis
mainsplistR   <- read.csv('../data/mainsplistR.csv',     row.names = NULL)

# filter rows on star_infs
main_starinfs <- filter_rows_by_valid_star(mainsplistR,'star_infs')

# exclude Moss families?

# caluclate family scores
fam_scores <- tapply(main_starinfs$star_infs, main_starinfs$family, calculate_score)

# summary table of star_infs by family
# change family to kew_fam, apg_fam, apg_order
fam_starinfs <- table(main_starinfs$family,main_starinfs$star_infs)
# number of species per family
spno_fam <- table(main_starinfs$family)
# combine tables
famstats <- cbind(fam_starinfs, spno_fam)

# convert summary table and family socres to dataframe
famstats_frame <- data.frame(family=row.names(famstats), 
                    BK=famstats[,1],
                    GD=famstats[,2],
                    BU=famstats[,3], 
                    GN=famstats[,4],
                    spno=famstats[,5], 
                    famscore=fam_scores[],row.names=NULL)

# filter families with small number of species??

# write results to csv
# change name suffix to KEW, APG, APGorder
write.csv(famstats_frame,
          file="../data/mainsp_famstats.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

