compute_range_size_stats_for_3_grids <- function(records, grouping, stat) {
  mgr <- tapply(records[,1], grouping, stat)
  qgr <- tapply(records[,2], grouping, stat)
  dgr <- tapply(records[,3], grouping, stat)
  rbind(mgr,qgr,dgr)
}

compute_count_for_3_grids <- function(horiw_data, stat) {
  grid_counts <- horiw_data[,c('horimgrid', 'quartergrid', 'X1grid')]
  compute_range_size_stats_for_3_grids(grid_counts, data$star_infs, stat)
}

compute_area_for_3_grids <- function(horiw_data, stat) {
  grid_areas <- horiw_data[,c('mgr_totalland','qgr_totalland','X1gr_totalland')]
  compute_range_size_stats_for_3_grids(grid_areas, data$star_infs, stat)
}