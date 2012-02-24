source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
hori <- read.csv('../data/species_pref.csv',     row.names = NULL)
foj  <- read.csv('../data/species_pref_foj.csv', row.names = NULL)

# neaten up raw data frames
hori <- sanitise(hori)
foj  <- sanitise(foj)

hori_scores <- tapply(hori$star, hori$pref, calculate_score)
foj_scores  <- tapply(foj$star,  foj$pref,  calculate_score)


# merge and transpose scores into one table
merged_scores <- t(rbind(foj_scores,hori_scores))
# filter out invalid values (NA) on scores
valid_scores <- na.omit(merged_scores)
# convert scores to dataframe
scores_frame <- data.frame(preflist=row.names(valid_scores), foj_scores=valid_scores[,1], hori_scores=valid_scores[,2], row.names=NULL)

# write results (scores) to file
write.csv(scores_frame,
          file="../data/scores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# scatter plot on scores
plot(valid_scores[,1],valid_scores[,2])
# scatter plot onscores in ranked order
plot(rank(valid_scores[,1]),rank(valid_scores[,2]))

# ranked correlation analysis in 3 ways. uncomment to run alternative methods.
cor(rank(valid_scores[,1]),rank(valid_scores[,2]))
# cor(valid_scores[,1],valid_scores[,2], method = "spearman")
# cor(foj_scores,hori_scores, use= "na.or.complete", method = "spearman")

# fit a linear model (linear regression analysis)
compare_scores <- lm(rank(valid_scores[,2]) ~ rank(valid_scores[,1]))
# draw a linear model graph with a linear regression line
abline(compare_scores)

# paired-t test on scores between hori and foj. 
# This test is probably not good because data are not normally distributed (check histogram).
t.test(hori_scores,foj_scores,paired=TRUE)
# histogram of scores
plot(density(foj_scores,na.rm=TRUE))
plot(density(hori_scores,na.rm=TRUE))

# bar plot
barplot(rbind(hori_scores, foj_scores), beside=TRUE)
