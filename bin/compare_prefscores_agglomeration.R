# for sourcing scripts that generate files, see
# workscripApr21_compref_aggl_source.R

# uncomment to select agglomeration method
# agglomeration <- ''
agglomeration <- 'uniq'
# corresponding input and output file names
input_scores   <- paste('../data/FOJHori', agglomeration, '_scores.csv', sep='')
input_spnos    <- paste('../data/FOJHori', agglomeration, '_spnos.csv', sep='')
input_meanhori <- paste('../data/hori', agglomeration, '_meanscores.csv', sep='')
input_maxhori  <- paste('../data/hori', agglomeration, '_maxscores.csv', sep='')
output_file    <- paste("../data/prefscores_calc_", agglomeration, "methods.csv", sep="")


# load data
# scores   <- read.csv('../data/FOJHori_scores.csv',  row.names = NULL)
# spnos    <- read.csv('../data/FOJHori_spnos.csv',   row.names = NULL)
# meanhori <- read.csv('../data/hori_meanscores.csv', row.names = NULL)
# maxhori  <- read.csv('../data/hori_maxscores.csv',  row.names = NULL)
scores   <- read.csv(input_scores,   row.names = NULL)
spnos    <- read.csv(input_spnos,    row.names = NULL)
meanhori <- read.csv(input_meanhori, row.names = NULL)
maxhori  <- read.csv(input_maxhori,  row.names = NULL)


# PREF!!!
# set pref levels
preflist <- read.csv('../data/preflist.csv')$pref

pref <- make.names(preflist)

# merge scores into one table
merged_scores_and_spnos <- merge(scores, spnos, sort=F)
merged_meanhori_and_maxhori <- merge(meanhori, maxhori, sort=F)
merged_scores <- merge(merged_scores_and_spnos, merged_meanhori_and_maxhori, by.x='preflist', by.y='pref', sort=F)

# filter out invalid values (NA) on scores
valid_scores <- na.omit(merged_scores)

# write results (scores) to file
write.csv(valid_scores,
          output_file,
          #file="../data/prefscores_calc_methods.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
