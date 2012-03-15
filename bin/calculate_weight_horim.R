source('../library/sanitise_data.R')

# load data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)

# filter for valid stars
horiw <- filter_rows_by_valid_star(horiw,'star_infs')

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

# calculate mean of selected column (count of grid cells of occurrence) grouped by stars
horic_mgr <- tapply(horiw$horimgrid, horiw$star_infs, mean)
horic_qgr <- tapply(horiw$quartergrid, horiw$star_infs, mean)
horic_1gr <- tapply(horiw$X1grid, horiw$star_infs, mean)

# calculate mean of selected column (total land area of grid cells of occurrence) grouped by stars
horia_mgr <- tapply(horiw$mgr_totalland, horiw$star_infs, mean)
horia_qgr <- tapply(horiw$qgr_totalland, horiw$star_infs, mean)
horia_1gr <- tapply(horiw$X1gr_totalland, horiw$star_infs, mean)

# merge resulting mean tables to one
meanhori_count <- rbind(horic_mgr,horic_qgr,horic_1gr)
meanhori_area <- rbind(horia_mgr,horia_qgr,horia_1gr)

# calculate weights for stars
weight_count <- meanhori_count[,'GN']/meanhori_count
weight_area <- meanhori_area[,'GN']/meanhori_area

# calculate the differences of distribution from that of finest resolution
differences <- horiw[,c('qgr_totalland','X1gr_totalland')] - replicate(2,horiw[,'mgr_totalland'])
difference_means <- apply(differences,2,mean)
difference_sds <- apply(differences,2,sd)
