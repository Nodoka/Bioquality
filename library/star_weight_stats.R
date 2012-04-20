# filter infra
filter_infra <- function(horiw_data){
  infra <- horiw_data[,'infra']
  not_infra <- infra != 'infra'
  horiw_data <- horiw_data[not_infra,]
  return(horiw_data)
}

# filter species for Japanese endemics
# alternative method of filtering
# horiw <- horiw[horiw$horim_end %in% 'endemic',]
filter_endemics <- function(horiw_data) {
  # only consider endemics in horiw_data
  horiw_data <- subset(horiw_data, horim_end %in% 'endemic')
  # remove unnecessary levels in horiw_data$horim_end
  horiw_data$horim_end <- factor(horiw_data$horim_end, 'endemic')
  return(horiw_data)
}

# filter species recorded in mainisland 
filter_mainisl <- function(horiw_data) {
  # only consider grids on main islands in horiw_data
  horiw_data <- subset(horiw_data, mgr_mainisl > 0)  
  return(horiw_data)
}

# filter species not recorded in mainisland
filter_smallisl <- function(horiw_data) {
  # only consider grids on main islands in horiw_data
  horiw_data <- subset(horiw_data, mgr_mainisl < 0.0001)  
  return(horiw_data)
}

# compute range size stats
compute_range_size_stats_for_3_grids <- function(grid_records, grouping, stat) {
  mgr <- tapply(grid_records[,1], grouping, stat)
  qgr <- tapply(grid_records[,2], grouping, stat)
  dgr <- tapply(grid_records[,3], grouping, stat)
  rbind(mgr,qgr,dgr)
}

# run compute range size stats for count records
compute_count_for_3_grids <- function(horiw_data, stat) {
  grid_counts <- horiw_data[,c('horimgrid', 'quartergrid', 'X1grid')]
  compute_range_size_stats_for_3_grids(grid_counts, horiw_data$star_infs, stat)
}

# run compute range size stats for area records
compute_area_for_3_grids <- function(horiw_data, stat) {
  grid_areas <- horiw_data[,c('mgr_totalland','qgr_totalland','X1gr_totalland')]
  compute_range_size_stats_for_3_grids(grid_areas, horiw_data$star_infs, stat)
}

# convert stats results to dataframe
stats_to_dataframe <- function(horiw_means, horiw_sds){
data.frame(datatype=row.names(horiw_means),
           mean_bk=horiw_means[,1],
           mean_gd=horiw_means[,2],
           mean_bu=horiw_means[,3],
           mean_gn=horiw_means[,4],
           sd_bk=horiw_sds[,1],
           sd_gd=horiw_sds[,2],
           sd_bu=horiw_sds[,3],
           sd_gn=horiw_sds[,4])
}

