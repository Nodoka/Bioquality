source('../library/sanitise_data.R')
source('../library/star_weight_stats.R')

# load data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)

# filter for valid stars
horiw <- filter_rows_by_valid_star(horiw,'star_infs')

# shuffle column location of 'species' to the end
species <- horiw$species
horiw <- cbind(horiw[,-5],species)

# filter infraspecific taxa
horiw <- filter_infra(horiw)

# uncomment to run analysis only with endemics
horiw <- filter_endemics(horiw)

# uncomment to run analysis only with grids on main islands
# horiw <- filter_mainisl(horiw)

# uncomment to run analysis without GN
# horiw <- filter_nogn(horiw)

# mean counts and land areas of grid cells of occurrence, grouped by stars
hori_mean_count <- compute_count_for_3_grids(horiw, mean)
hori_mean_area <- compute_area_for_3_grids(horiw, mean)

# calculate weights for stars
weight_count <- hori_mean_count[,'GN']/hori_mean_count
weight_area  <- hori_mean_area[,'GN']/hori_mean_area

# calculate the differences of distribution from that of finest resolution
differences <- as.matrix(horiw[,c('qgr_totalland','X1gr_totalland')]) - replicate(2,horiw[,'mgr_totalland'])
logdiff     <- log(differences/horiw[,'mgr_totalland']+1)

diff_frame <- data.frame(rownum=row.names(logdiff), qrt_landdiff=logdiff[,1], x1_landdiff=logdiff[,2])

# after filtering out GN, calculate mean & weight for x1adds count
mean_x1adds <- tapply(horiw$x1gridadds, horiw$star_infs, mean)
weight_x1adds <- mean_x1adds['BU']/mean_x1adds

-----------------------------
# write filtered data to file 
# Note: data name is horiw
write.csv(horiw,
          file="../data/Hori_area_weight_filtered.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

