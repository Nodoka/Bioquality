source('../library/sanitise_data.R')
source('../library/star_weight_stats.R')

# load data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)

# filter for valid stars
horiw <- filter_rows_by_valid_star(horiw,'star_infs')

# filter infra
horiw <- filter_infra(horiw)

# filter records for main island vs small island species
main  <- filter_mainisl(horiw)
small <- filter_smallisl(horiw)

# mean counts and land areas of grid cells of occurrence
# for main island species, grouped by stars
main_mean_count <- compute_count_for_3_grids(main, mean)
main_mean_area  <- compute_area_for_3_grids(main, mean)
# standard diviation
main_sd_count <- compute_count_for_3_grids(main, sd)
main_sd_area  <- compute_area_for_3_grids(main, sd)

# mean counts and land areas of grid cells of occurrence
# for small island species, grouped by stars
small_mean_count <- compute_count_for_3_grids(small, mean)
small_mean_area  <- compute_area_for_3_grids(small, mean)
# standard deviation
small_sd_count <- compute_count_for_3_grids(small, sd)
small_sd_area  <- compute_area_for_3_grids(small, sd)

# convert to dataframe (count, mean)
main_count <- stats_to_dataframe(main_mean_count, main_sd_count)
main_area  <- stats_to_dataframe(main_mean_area, main_sd_area)

small_count <- stats_to_dataframe(small_mean_count, small_sd_count)
small_area  <- stats_to_dataframe(small_mean_area, small_sd_area)

# write filtered data to file 
write.csv(main_count,
          file="../data/horimain_countmean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(main_area,
          file="../data/horimain_areamean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# write filtered data to file 
write.csv(small_count,
          file="../data/horismall_countmean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(small_area,
          file="../data/horismall_areamean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
