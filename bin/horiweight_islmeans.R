source('../library/sanitise_data.R')

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

# calculate mean and sd of selected column grouped by star_infs
# for main and small islands species
mainc_mgr <- tapply(main$horimgrid, main$star_infs, mean)
mainc_qgr <- tapply(main$quartergrid, main$star_infs, mean)
mainc_1gr <- tapply(main$X1grid, main$star_infs, mean)

maina_mgr <- tapply(main$mgr_totalland, main$star_infs, mean)
maina_qgr <- tapply(main$qgr_totalland, main$star_infs, mean)
maina_1gr <- tapply(main$X1gr_totalland, main$star_infs, mean)

# merge resulting mean tables to one
meanmain_count <- rbind(mainc_mgr,mainc_qgr,mainc_1gr)
meanmain_area  <- rbind(maina_mgr,maina_qgr,maina_1gr)

# calculate standard deviation of selected column grouped by stars
sdmainc_mgr <- tapply(main$horimgrid, main$star_infs, sd)
sdmainc_qgr <- tapply(main$quartergrid, main$star_infs, sd)
sdmainc_1gr <- tapply(main$X1grid, main$star_infs, sd)

# calculate sd of selected column (total land area of grid cells of 
# occurrence) grouped by stars
sdmaina_mgr <- tapply(main$mgr_totalland, main$star_infs, sd)
sdmaina_qgr <- tapply(main$qgr_totalland, main$star_infs, sd)
sdmaina_1gr <- tapply(main$X1gr_totalland, main$star_infs, sd)

# merge resulting sd tables to one
sdmain_count <- rbind(sdmainc_mgr,sdmainc_qgr,sdmainc_1gr)
sdmain_area  <- rbind(sdmaina_mgr,sdmaina_qgr,sdmaina_1gr)

# convert to dataframe (count, mean)
main_count <- data.frame(datatype=row.names(meanmain_count),
                    mean_bk=meanmain_count[,1],
                    mean_gd=meanmain_count[,2],
                    mean_bu=meanmain_count[,3],
                    mean_gn=meanmain_count[,4],
                    sd_bk=sdmain_count[,1],
                    sd_gd=sdmain_count[,2],
                    sd_bu=sdmain_count[,3],
                    sd_gn=sdmain_count[,4])

main_area <- data.frame(datatype=row.names(meanmain_area),
                    mean_bk=meanmain_area[,1],
                    mean_gd=meanmain_area[,2],
                    mean_bu=meanmain_area[,3],
                    mean_gn=meanmain_area[,4],
                    sd_bk=sdmain_area[,1],
                    sd_gd=sdmain_area[,2],
                    sd_bu=sdmain_area[,3],
                    sd_gn=sdmain_area[,4])

# write filtered data to file 
write.csv(main_count,
          file="../data/horimain_countmean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(main_area,
          file="../data/horimain_areamean.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

smallc_mgr <- tapply(small$horimgrid, small$star_infs, mean)
smallc_qgr <- tapply(small$quartergrid, small$star_infs, mean)
smallc_1gr <- tapply(small$X1grid, small$star_infs, mean)

smalla_mgr <- tapply(small$mgr_totalland, small$star_infs, mean)
smalla_qgr <- tapply(small$qgr_totalland, small$star_infs, mean)
smalla_1gr <- tapply(small$X1gr_totalland, small$star_infs, mean)

# merge resulting mean tables to one
meansmall_count <- rbind(smallc_mgr,smallc_qgr,smallc_1gr)
meansmall_area  <- rbind(smalla_mgr,smalla_qgr,smalla_1gr)

# calculate standard deviation of selected column grouped by stars
sdsmallc_mgr <- tapply(small$horimgrid, small$star_infs, sd)
sdsmallc_qgr <- tapply(small$quartergrid, small$star_infs, sd)
sdsmallc_1gr <- tapply(small$X1grid, small$star_infs, sd)

# calculate sd of selected column (total land area of grid cells of 
# occurrence) grouped by stars
sdsmalla_mgr <- tapply(small$mgr_totalland, small$star_infs, sd)
sdsmalla_qgr <- tapply(small$qgr_totalland, small$star_infs, sd)
sdsmalla_1gr <- tapply(small$X1gr_totalland, small$star_infs, sd)

# merge resulting sd tables to one
sdsmall_count <- rbind(sdsmallc_mgr,sdsmallc_qgr,sdsmallc_1gr)
sdsmall_area  <- rbind(sdsmalla_mgr,sdsmalla_qgr,sdsmalla_1gr)

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
