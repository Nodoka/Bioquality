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
horiw <- sp_horiw

# filter main vs small island species
filter_mainisl <- function(hori_data) {
  # only consider grids on main islands in hori_data
  hori_data <- subset(hori_data, mgr_mainisl > 0)  
  return(hori_data)
}

filter_smallisl <- function(hori_data) {
  # only consider grids on main islands in hori_data
  hori_data <- subset(hori_data, mgr_mainisl < 0.0001)  
  return(hori_data)
}
main <- filter_mainisl(horiw)
small <- filter_smallisl(horiw)

# mean counts and land areas of grid cells of occurrence, grouped by stars
main_mean_count <- compute_count_for_3_grids(main, mean)
main_mean_area <- compute_area_for_3_grids(main, mean)

main_sd_count <- compute_count_for_3_grids(main, sd)
main_sd_area <- compute_area_for_3_grids(main, sd)

# convert to dataframe (count, mean)
main_count <- data.frame(datatype=row.names(main_mean_count),
                    mean_bk=main_mean_count[,1],
                    mean_gd=main_mean_count[,2],
                    mean_bu=main_mean_count[,3],
                    mean_gn=main_mean_count[,4],
                    sd_bk=main_sd_count[,1],
                    sd_gd=main_sd_count[,2],
                    sd_bu=main_sd_count[,3],
                    sd_gn=main_sd_count[,4])

main_area <- data.frame(datatype=row.names(main_mean_area),
                    mean_bk=main_mean_area[,1],
                    mean_gd=main_mean_area[,2],
                    mean_bu=main_mean_area[,3],
                    mean_gn=main_mean_area[,4],
                    sd_bk=main_sd_area[,1],
                    sd_gd=main_sd_area[,2],
                    sd_bu=main_sd_area[,3],
                    sd_gn=main_sd_area[,4])

# write filtered data to file 
write.csv(main_count,
          file="../data/horimain_countmean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(main_area,
          file="../data/horimain_areamean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

# mean counts and land areas of grid cells of occurrence, grouped by stars
small_mean_count <- compute_count_for_3_grids(small, mean)
small_mean_area <- compute_area_for_3_grids(small, mean)

small_sd_count <- compute_count_for_3_grids(small, sd)
small_sd_area <- compute_area_for_3_grids(small, sd)

# convert to dataframe (count, mean)
small_count <- data.frame(datatype=row.names(meansmall_count),
                    mean_bk=meansmall_count[,1],
                    mean_gd=meansmall_count[,2],
                    mean_bu=meansmall_count[,3],
                    mean_gn=meansmall_count[,4],
                    sd_bk=sdsmall_count[,1],
                    sd_gd=sdsmall_count[,2],
                    sd_bu=sdsmall_count[,3],
                    sd_gn=sdsmall_count[,4])

small_area <- data.frame(datatype=row.names(meansmall_area),
                    mean_bk=meansmall_area[,1],
                    mean_gd=meansmall_area[,2],
                    mean_bu=meansmall_area[,3],
                    mean_gn=meansmall_area[,4],
                    sd_bk=sdsmall_area[,1],
                    sd_gd=sdsmall_area[,2],
                    sd_bu=sdsmall_area[,3],
                    sd_gn=sdsmall_area[,4])

# write filtered data to file 
write.csv(small_count,
          file="../data/horismall_countmean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(small_area,
          file="../data/horismall_areamean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
