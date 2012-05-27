source('../library/sanitise_data.R')

# load data for star sensitivity analysis
mainsplistR   <- read.csv('../data/mainsplistR.csv',     row.names = NULL)

# filter rows on star_infs
main_starinfs <- filter_rows_by_valid_star(mainsplistR,'star_infs')

# make a summary table of data sources (origin) vs. stars (star_infs), need to transpose the table for running bar_stacked.py
origin_stars  <- table(main_starinfs$origin,main_starinfs$star_infs)

# group all Flora of Japan data except typo to 'FOJ' and all Kew to 'Kew'??

# write results to csv file.
write.csv(origin_stars,
	  file="../data/FOJKEW_starinfs_Gtestdata.csv",
          fileEncoding="UTF-8")

