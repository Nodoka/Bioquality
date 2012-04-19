source('../library/sanitise_data.R')
source('../library/star_weight_stats.R')

# load data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)

# filter for valid stars
horiw <- filter_rows_by_valid_star(horiw,'star_infs')

# filter infra
infra <- horiw[,'infra']
not_infra <- infra != 'infra'
sp_horiw <- horiw[not_infra,]

# shuffle column location of 'species' to the end
species <- sp_horiw$species
sp_horiw <- cbind(sp_horiw[,-5],species)

# uncomment to run analysis without infraspecific taxa.
# horiw <- sp_horiw


# filter species for Japanese endemics
filter_endemics <- function(hori_data) {
  # only consider endemics in hori_data
  hori_data <- subset(hori_data, horim_end %in% 'endemic')

  # remove unnecessary levels in hori_data$horim_end
  hori_data$horim_end <- factor(hori_data$horim_end, 'endemic')
  
  return(hori_data)
}

# alternative method of filtering
# horiw <- horiw[horiw$horim_end %in% 'endemic',]
# uncomment to run analysis only with endemics
# horiw <- filter_endemics(horiw)

# filter species recorded in mainisland 
filter_mainisl <- function(hori_data) {
  # only consider grids on main islands in hori_data
  hori_data <- subset(hori_data, mgr_mainisl > 0)  
  return(hori_data)
}

# uncomment to run analysis only with grids on main islands
# horiw <- filter_mainisl(horiw)

---------------------------

# mean counts and land areas of grid cells of occurrence, grouped by stars
hori_mean_count <- compute_count_for_3_grids(horiw, mean)
hori_mean_area <- compute_area_for_3_grids(horiw, mean)

# calculate weights for stars
weight_count <- hori_mean_count[,'GN']/hori_mean_count
weight_area  <- hori_mean_area[,'GN']/hori_mean_area

# calculate the differences of distribution from that of finest resolution
differences      <- horiw[,c('qgr_totalland','X1gr_totalland')] - replicate(2,horiw[,'mgr_totalland'])
difference_means <- apply(differences,2,mean)
difference_sds   <- apply(differences,2,sd)

-----------------------------
# write filtered data to file 
# Note: data name is horiw
write.csv(horiw,
          file="../data/Hori_area_weight_filtered.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

