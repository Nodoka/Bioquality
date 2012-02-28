source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
foj  <- read.csv('../data/species_pref_foj.csv', row.names = NULL)

# neaten up raw data frames, within sanitise, only do the followings.
foj <- rename_sampname_to_pref(foj)
foj <- select_sensitivity_columns(foj)
foj <- set_pref_levels(foj)

# make species list by prefecture for each star classification method
# how to avoid redundancy in star* used across this section?
# foj_star* <- filter_rows_by_valid_star(foj,'star*')

foj_star      <- filter_rows_by_valid_star(foj,'star')
foj_star_geo  <- filter_rows_by_valid_star(foj,'star_geo')
foj_star_geou <- filter_rows_by_valid_star(foj,'star_geou')
foj_star_geod <- filter_rows_by_valid_star(foj,'star_geod')
foj_star_infa <- filter_rows_by_valid_star(foj,'star_infa')
foj_star_infs <- filter_rows_by_valid_star(foj,'star_infs')

# GHI scores by prefecture for each star classification method
# foj_scores_star*  <- tapply(foj_star*$star*,  foj_star*$pref,  calculate_score)
# combine GHI scores by prefecture with all star classification methods
# sens_scores <- cbind (foj_scores_star*,,,)

# individual scripts run in R
foj_scores_star       <- tapply(foj_star$star,  foj_star$pref, calculate_score)
foj_scores_star_geo   <- tapply(foj_star_geo$star_geo,  foj_star_geo$pref,  calculate_score)
foj_scores_star_geou  <- tapply(foj_star_geou$star_geou,  foj_star_geou$pref,  calculate_score)
foj_scores_star_geod  <- tapply(foj_star_geod$star_geod,  foj_star_geod$pref,  calculate_score)
foj_scores_star_infa  <- tapply(foj_star_infa$star_infa,  foj_star_infa$pref,  calculate_score)
foj_scores_star_infs  <- tapply(foj_star_infs$star_infs,  foj_star_infs$pref,  calculate_score)
sens_scores           <- cbind(foj_scores_star,foj_scores_star_geo,foj_scores_star_geou,foj_scores_star_geod,foj_scores_star_infa,foj_scores_star_infs)

# calculate the differences of each star method from the default
differences      <- sens_scores[,-1] - replicate(5,sens_scores[,1])
difference_means <- apply(differences,2,mean)
difference_sds   <- apply(differences,2,sd)

# convert scores to dataframe
sens_scores_frame <- data.frame(preflist=row.names(sens_scores), 			     star_default=sens_scores[,1], 
		     star_geo=sens_scores[,2], 
                     star_geou=sens_scores[,3],
                     star_geod=sens_scores[,4], 
                     star_infa=sens_scores[,5], 
                     star_infs=sens_scores[,6],
                     row.names=NULL)

# write results (scores) to file
write.csv(sens_scores_frame,
          file="../data/sensitivity_scores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# bar plot
barplot(foj_scores_sensitivity,legend.text=c('star','star_geo','star_geou','star_geod','star_infa','star_infs'),beside=TRUE,xlab='prefecture',ylab='GHI score')

# rank correlation analysis
cor(foj_scores_sensitivity[1,],foj_scores_sensitivity[*,],method="spearman")

# graph: linear regression line between x: foj_scores_star (default) vs. y: one of scenarios, or all in one graph showing variation
