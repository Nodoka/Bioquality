# for sourcing scripts that generate files, see
# workscripApr21_compref_aggl_source.R
# load data
scores   <- read.csv('../data/FOJHori_scores.csv',     row.names = NULL)
spnos    <- read.csv('../data/FOJHori_spnos.csv',     row.names = NULL)
meanhori <- read.csv('../data/hori_meanscores.csv', row.names = NULL)
maxhori  <- read.csv('../data/hori_maxscores.csv', row.names = NULL)

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
          file="../data/prefscores_calc_methods.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
