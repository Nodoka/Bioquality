source('../library/sanitise_data.R')
source('../bin/produce_cell_score.R')

# uncomment to select agglomeration method
# '' = holistic by default
agglomeration <- ''
# agglomeration <- 'uniq'
# agglomeration <- 'excl'

# corresponding input and output file names
input_file       <- paste('../data/cell_', agglomeration, 'pref.csv', sep='')
output_file_mean <- paste("../data/hori", agglomeration, "_meanscores.csv", sep="") 
output_file_max  <- paste("../data/hori", agglomeration, "_maxscores.csv", sep="") 

# load all data
# cell_score <- read.csv('../data/Hori_plot_score.csv', row.names = NULL)
# cell_pref  <- read.csv('../data/cell_pref.csv',    row.names = NULL)
cell_pref  <- read.csv(input_file, row.names = NULL)

# rename column from 'Pref' to 'pref'
column_index <- which(names(cell_pref) == 'Pref')
		names(cell_pref)[column_index] <- 'pref'

# set pref levels
cell_pref <- set_pref_levels(cell_pref)

# filter for relevant columns
cell_pref <- cell_pref[,c('pref','sampname')]

# cell_score is generated in produce_cell_score.R
# OPTIONAL: filter cell with spcount > 39
# index T/F of spcount >39
spcount <- spnum_cell > 39
# filter cell with index
cell_score <- cell_score[spcount,]

# merge data sets
pref_score <- merge(cell_score, cell_pref)

# calculate mean and maximum scores by prefecture
pref_score_mean <- tapply(pref_score$GHI, pref_score$pref, mean)
pref_score_max  <- tapply(pref_score$GHI, pref_score$pref, max)
pref_spno_mean  <- tapply(pref_score$spno, pref_score$pref, mean)
pref_spno_max   <- tapply(pref_score$spno, pref_score$pref, max)


# convert results to dataframe
score_meanframe <- data.frame(pref=row.names(pref_score_mean),      
		    meanGHI=pref_score_mean[],
                    meanspno=pref_spno_mean[])

score_maxframe  <- data.frame(pref=row.names(pref_score_max),      
		    maxGHI=pref_score_max[],
                    maxspno=pref_spno_max[])

# write results of scores
# change file name to "horiuniq_m*scores" when using cell_uniqpref
write.csv(score_meanframe,
          file=output_file_mean,
          #file="../data/hori_meanscores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(score_maxframe,
          file=output_file_max,
          #file="../data/hori_maxscores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# for analysis without Gramineae
# filter out Gramineae in produce_cell_score.R
# generate score_frame using the script above, change output name
# calculate differences
# diff_mean <- score_meanframe[,2]-xgscore_meanframe[,2]
# diff_max  <- score_maxframe[,2]-xgscore_maxframe[,2]
