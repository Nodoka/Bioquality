# Plotting results extracted from:
# bin/compare_GHI_by_prefecture.R

# scatter plot on scores
plot(valid_scores[,1],valid_scores[,2])
# scatter plot onscores in ranked order
plot(rank(valid_scores[,1]),rank(valid_scores[,2]))

# fit a linear model (linear regression analysis)
compare_scores <- lm(rank(valid_scores[,2]) ~ rank(valid_scores[,1]))
# draw a linear model graph with a linear regression line
abline(compare_scores)

# save plot as tiff
savePlot(filename=("../data/FOJHori_ranked_score.tiff"),type="tiff")

# histogram of scores
plot(density(foj_scores,na.rm=TRUE))
plot(density(hori_scores,na.rm=TRUE))

# bar plot
barplot(rbind(hori_scores, foj_scores), beside=TRUE)
