source('../library/GHI.R')
source('../library/sanitise_data.R')

# uncomment to select agglomeration method
# agglomeration <- ''
agglomeration <- 'uniq'
# corresponding input and output file names
input_file    <- paste('../data/species_', agglomeration, 'pref.csv', sep='')
output_file   <- paste("../data/FOJHori", agglomeration, "_scores.csv", sep="") 

# load data
# hori <- read.csv('../data/species_pref.csv',     row.names = NULL)
hori <- read.csv(input_file,                     row.names = NULL)
foj  <- read.csv('../data/species_pref_foj.csv', row.names = NULL)

# select and rename relevant star columns
foj <- rename_star_to_xstar(foj)
foj <- rename_starinfs_to_star(foj)

# neaten up raw data frames
hori <- sanitise(hori)
foj  <- sanitise(foj)

# calculate GHI scores
hori_scores <- tapply(hori$star, hori$pref, calculate_score)
foj_scores  <- tapply(foj$star,  foj$pref,  calculate_score)

# merge scores into one table
merged_scores <- cbind(foj_scores,hori_scores)
# filter out invalid values (NA) on scores
valid_scores <- na.omit(merged_scores)
# convert scores to dataframe
scores_frame <- data.frame(preflist=row.names(valid_scores), foj_scores=valid_scores[,1], hori_scores=valid_scores[,2], row.names=NULL)

# write results (scores) to file
# change file name to "FOJHoriuniq_scores" when using cell_uniqpref
write.csv(scores_frame,
          file=output_file,
          #file="../data/FOJHori_scores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# ranked correlation analysis in 3 ways. uncomment to run alternative methods.
cor(rank(valid_scores[,1]),rank(valid_scores[,2]))
# cor(valid_scores[,1],valid_scores[,2], method = "spearman")
# cor(foj_scores,hori_scores, use= "na.or.complete", method = "spearman")

# paired-t test on scores between hori and foj. 
# This test is probably not good because data are not normally distributed (check histogram).
t.test(hori_scores,foj_scores,paired=TRUE)

