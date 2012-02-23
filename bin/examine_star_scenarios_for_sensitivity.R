source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data for star sensitivity analysis
mainsplistR     <- read.csv('../data/mainsplistR.csv',     row.names = NULL)


# define star columns (copied from sanitise_data) 
star_columns <- c('star', 'star_geo', 'star_geod', 'star_geou', 'star_infa', 'star_infs')

# filter rows by valid star on selected column
# how to reduce redundancy in star* used across this section?
splist_star_scenario* <- filter_rows_by_valid_star(mainsplistR,'star*')
# summary of the number of valid stars for each star classification methods
star_table_scenario* <- table(splist_star_scenario[,'star*'])
# star summary table with all star classification methods
stars_table <- rbind(star_table_scenario,,,,,)

# individual scripts run in R
splist_star <- filter_rows_by_valid_star(mainsplistR,'star')
splist_star_geo <- filter_rows_by_valid_star(mainsplistR,'star_geo')
splist_star_geou <- filter_rows_by_valid_star(mainsplistR,'star_geou')
splist_star_geod <- filter_rows_by_valid_star(mainsplistR,'star_geod')
splist_star_infa <- filter_rows_by_valid_star(mainsplistR,'star_infa')
splist_star_infs <- filter_rows_by_valid_star(mainsplistR,'star_infs')
star_table_star <- table(splist_star[,'star'])
star_table_star_geo <- table(splist_star_geo[,'star_geo'])
star_table_star_geou <- table(splist_star_geou[,'star_geou'])
star_table_star_geod <- table(splist_star_geod[,'star_geod'])
star_table_star_infa <- table(splist_star_infa[,'star_infa'])
star_table_star_infs <- table(splist_star_infs[,'star_infs'])
sum_table <- rbind(star_table_star,star_table_star_geo,star_table_star_geou,star_table_star_geod,star_table_star_infa,star_table_star_infs)

# bar plot
barplot(sum_table,legend.text=c("star","star_geo","star_geou","star_geod","star_infa","star_infs"),beside=TRUE)
 
# graphs needed: proportion bar graphs, one grouped by star on x; series = star_scenario, the other grouped by star_scenario; series = star
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


