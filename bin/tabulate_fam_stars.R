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
spno     <- table(mainsplistR$family)
starless <- spno - spno_fam
# combine tables
famstats <- cbind(fam_starinfs, starless)

# convert summary table and family socres to dataframe
famstats_frame <- data.frame(family=row.names(famstats), 
                    BK=famstats[,1],
                    GD=famstats[,2],
                    BU=famstats[,3], 
                    GN=famstats[,4],
                    starless=famstats[,5],
                    starsp=spno_fam[],
                    spcount=spno[], 
                    famscore=fam_scores[],row.names=NULL)

# filter families with starred sp < 40
# make a new column with either of famscore or 'NA' based on starsp
less_than_40 <- famstats_frame$starsp < 40
less_than_40[is.na(less_than_40)] <- T

famstats_frame[!less_than_40,'valid_scores'] <- famstats_frame[!less_than_40,'famscore']

# list of families by different sources
famnames <- unique(mainsplistR[,c('family','kew_fam','apg_fam','apg_order','moss')])

# merge family names KEW, APG, APGorder
famnames_stats <- merge(famstats_frame, famnames)

# write results to csv
write.csv(famstats_frame,
          file="../data/mainsp_famstats.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(famnames_stats,
          file="../data/mainsp_famnamestats.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# optional: APG ref
apgref <- unique(famnames[,c('family','apg_fam','apg_order','moss')])
famapg_stats <- merge(famstats_frame, apgref)
write.csv(famapg_stats,
          file="../data/mainsp_famapgstats.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
