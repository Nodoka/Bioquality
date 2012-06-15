source('../library/sanitise_data.R')
source('../library/star_weight_stats.R')

# load data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)

# filter for valid stars
horiw <- filter_rows_by_valid_star(horiw,'star_infs')

# filter infraspecific taxa
horiw <- filter_infra(horiw)

# mean counts and land areas of grid cells of occurrence, grouped by stars
hori_mean_count <- compute_count_for_3_grids(horiw, mean)
hori_mean_area  <- compute_area_for_3_grids(horiw, mean)

hori_sd_count <- compute_count_for_3_grids(horiw, sd)
hori_sd_area  <- compute_area_for_3_grids(horiw, sd)

# convert to dataframe
count <- stats_to_dataframe(hori_mean_count,hori_sd_count)
area  <- stats_to_dataframe(hori_mean_area,hori_sd_area)

# write filtered data to file 
write.csv(count,
          file="../data/horiw_countmean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(area,
          file="../data/horiw_areamean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
--------------------------------------------
# Count records with x1adds
horic_tdwg <- tapply(horiw$x1gridadds, horiw$star_infs, mean)
weight_count <- horic_tdwg['BU']/horic_tdwg

--------------------------------------------
source('../library/sanitise_data.R')
# load all data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)
tdwg <- read.csv('../data/tdwgsp.csv',     row.names = NULL)

# filter for valid stars
horiw <- filter_rows_by_valid_star(horiw,'star_infs')
tdwg <- filter_rows_by_valid_star(tdwg,'star_infs')

# filter for relevant columns
hori_area <- horiw[,c('family','species','spnumber','star_infs','horimgrid','quartergrid','X1grid',
'mgr_totalland','qgr_totalland','X1gr_totalland','horim_end','infra')]
tdwg_area <- tdwg[,c('family','species','spnumber','tdwgtotals','tdwgareas')]

# merge dataframes
hori_tdwg <- merge(hori_area, tdwg_area)

# filter infra
infra <- hori_tdwg[,'infra']
not_infra <- infra != 'infra'
sp_horitdwg <- hori_tdwg[not_infra,]
hori_tdwg <- sp_horitdwg

# calculate mean of selected column (total land area of grid cells of occurrence) grouped by stars
horim_tdwg <- tapply(hori_tdwg$mgr_totalland, hori_tdwg$star_infs, mean)
horiq_tdwg <- tapply(hori_tdwg$qgr_totalland, hori_tdwg$star_infs, mean)
hori1_tdwg <- tapply(hori_tdwg$X1gr_totalland, hori_tdwg$star_infs, mean)
sphori_tdwg <- tapply(hori_tdwg$tdwgareas, hori_tdwg$star_infs, mean)

# merge resulting mean tables to one
areameans <- rbind(horim_tdwg,horiq_tdwg,hori1_tdwg,sphori_tdwg)

weight_horitdwg <- areameans[,'GN']/areameans
