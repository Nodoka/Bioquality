source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data for star sensitivity analysis
mainsplistR     <- read.csv('../data/mainsplistR.csv',     row.names = NULL)


# define star columns (copied from sanitise_data) 
star_columns <- c('star', 'star_geo', 'star_geod', 'star_geou', 'star_infa', 'star_infs')

# filter rows by valid star on selected column
# how to reduce redundancy in star* used across this section?
# splist_star_scenario* <- filter_rows_by_valid_star(mainsplistR,'star*')
# summary of the number of valid stars for each star classification methods
# star_table_scenario* <- table(splist_star_scenario[,'star*'])
# star summary table with all star classification methods
# stars_table <- rbind(star_table_scenario,,,,,)

# individual scripts run in R
splist_star      <- filter_rows_by_valid_star(mainsplistR,'star')
splist_star_geo  <- filter_rows_by_valid_star(mainsplistR,'star_geo')
splist_star_geou <- filter_rows_by_valid_star(mainsplistR,'star_geou')
splist_star_geod <- filter_rows_by_valid_star(mainsplistR,'star_geod')
splist_star_infa <- filter_rows_by_valid_star(mainsplistR,'star_infa')
splist_star_infs <- filter_rows_by_valid_star(mainsplistR,'star_infs')
star_table_star      <- table(splist_star[,'star'])
star_table_star_geo  <- table(splist_star_geo[,'star_geo'])
star_table_star_geou <- table(splist_star_geou[,'star_geou'])
star_table_star_geod <- table(splist_star_geod[,'star_geod'])
star_table_star_infa <- table(splist_star_infa[,'star_infa'])
star_table_star_infs <- table(splist_star_infs[,'star_infs'])
# summary table of star species numbers in all classification method, row=method by column=star. 
# sum_table <- rbind(star_table_star,star_table_star_geo,star_table_star_geou,star_table_star_geod,star_table_star_infa,star_table_star_infs)
# summary table of star species numbers in all classification method, row=star by column=method.
sum_table  <- cbind(star_table_star,star_table_star_geo,star_table_star_geou,star_table_star_geod,star_table_star_infa,star_table_star_infs)

# calculate the differences of each star method from the default
difference <- sum_table[,-1]-replicate(5,sum_table[,1])


# convert summary table and differences to dataframe
sum_table_frame <- data.frame(star=row.names(sum_table), 			     
		     star_default=sum_table[,1], 
		     star_geo=sum_table[,2], 
                     star_geou=sum_table[,3],
                     star_geod=sum_table[,4], 
                     star_infa=sum_table[,5], 
                     star_infs=sum_table[,6],
                     row.names=NULL)

difference_frame <- data.frame(star=row.names(difference), 			 
		     star_geo=difference[,1], 
                     star_geou=difference[,2],
                     star_geod=difference[,3], 
                     star_infa=difference[,4], 
                     star_infs=difference[,5],
                     row.names=NULL)
 
# write results to csv file. change sum_table to dataframe or modify the first row label 'star'.
write.csv(sum_table_frame,
	  file="../data/star_sensitivity_spnos_data.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(difference_frame,
	  file="../data/star_sensitivity_spnos_diff.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# graphs needed: proportion bar graphs, one grouped by star on x; series = star_scenario, the other grouped by star_scenario; series = star
# bar plot
# barplot(sum_table,legend.text=c("star","star_geo","star_geou","star_geod","star_infa","star_infs"),beside=TRUE)
---------
# alternative way?
# extract the 'star' column of a chosen dataset
star_scenario* <- mainsplistR$star*
# extract the frequencies of 'BK', 'GD', 'BU' and 'GN' as a vector
frequencies_star_scenario* <- GHI.star_frequencies(star*)
# number of stars for each star classification method
star_sens_table <- rbind(frequencies_star,,,,,)

# individual scripts run in R
star_default <- mainsplistR$star
star_geo <- mainsplistR$star_geo
star_geou <- mainsplistR$star_geou
star_geod <- mainsplistR$star_geod
star_infa <- mainsplistR$star_infa
star_infs <- mainsplistR$star_infs
frequencies_star_default <- GHI.star_frequencies(star_default)
frequencies_star_geo <- GHI.star_frequencies(star_geo)
frequencies_star_geou <- GHI.star_frequencies(star_geou)
frequencies_star_geod <- GHI.star_frequencies(star_geod)
frequencies_star_infa <- GHI.star_frequencies(star_infa)
frequencies_star_infs <- GHI.star_frequencies(star_infs)
star_sens_table <- rbind(frequencies_star_default,frequencies_star_geo,frequencies_star_geou,frequencies_star_geod,frequencies_star_infa,frequencies_star_infs)


