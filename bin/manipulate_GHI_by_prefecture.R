source('../library/sanitise_data.R')

# load all data
cell_score <- read.csv('../data/Hori_plot_score.csv', row.names = NULL)
cell_pref  <- read.csv('../data/cell_pref.csv',    row.names = NULL)

# rename column from 'Pref' to 'pref'
column_index <- which(names(cell_pref) == 'Pref')
		names(cell_pref)[column_index] <- 'pref'

# set pref levels
cell_pref <- set_pref_levels(cell_pref)

# filter for relevant columns
cell_pref <- cell_pref[,c('pref','sampname')]

---------------------------------
# manually calculate cell_score
source('../library/GHI.R')

# load data
species_cell   <- read.csv('../data/species_cell.csv', row.names = NULL)

# filter valid stars for chosen star column
species_cell   <- filter_rows_by_valid_star(species_cell,'star_infs')

# GHI scores by cell (sampname) for a chosen star classification method
cal_cell_score <- tapply(species_cell$star_infs,  species_cell$sampname,  calculate_score)

# convert results to dataframe
cell_score     <- data.frame(sampname=row.names(cal_cell_score),      
		    GHI=cal_cell_score[],
		    row.names=NULL)

-------------------------------------
# merge dataframes
pref_score <- merge(cell_score, cell_pref)

# calculate mean and maximum scores by prefecture
pref_score_mean <- tapply(pref_score$GHI, pref_score$pref, mean)
pref_score_max  <- tapply(pref_score$GHI, pref_score$pref, max)


# convert results to dataframe
score_meanframe <- data.frame(pref=row.names(pref_score_mean),      
		    meanGHI=pref_score_mean[])

score_maxframe  <- data.frame(pref=row.names(pref_score_max),      
		    maxGHI=pref_score_max[])


# write results of scores
write.csv(score_meanframe,
          file="../data/hori_meanscores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(score_maxframe,
          file="../data/hori_maxscores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

-----------------------------------------
# filter out Gramineae for seperate analyses without Gramineae (optional)
# index T/F of family != (not equal) Gramineae
fam           <- species_cell[,'family']
not_gramineae <- fam != 'Gramineae'
# then filter tdwg with the index.
xgrass_spcell <- species_cell[not_gramineae,]

# GHI scores by cell without Gramineae for a chosen star classification method
xgrass_cell_score <- tapply(xgrass_spcell$star_infs,  xgrass_spcell$sampname,  calculate_score)

# convert results to dataframe
xgrass_cell_score <- data.frame(sampname=row.names(xgrass_cell_score),      
		     GHI=xgrass_cell_score[],
		     row.names=NULL)

# merge dataframes
xgrass_prefscore <- merge(xgrass_cell_score, cell_pref)

# calculate mean and maximum scores by prefecture
xgrass_prefscore_mean <- tapply(xgrass_prefscore$GHI, xgrass_prefscore$pref, mean)
xgrass_prefscore_max  <- tapply(xgrass_prefscore$GHI, xgrass_prefscore$pref, max)


# convert results to dataframe
xgscore_meanframe <- data.frame(pref=row.names(xgrass_prefscore_mean),      
		     xgmeanGHI=xgrass_prefscore_mean[])

xgscore_maxframe  <- data.frame(pref=row.names(xgrass_prefscore_max),      
		     xgmaxGHI=xgrass_prefscore_max[])

# calculate differences
diff_mean <- score_meanframe[,2]-xgscore_meanframe[,2]
diff_max  <- score_maxframe[,2]-xgscore_maxframe[,2]





