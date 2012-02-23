# load data
horiw <- read.csv('../data/Hori_area_weight.csv', row.names=NULL)

# calculate mean of selected column (count of grid cells of occurrence) grouped by stars
horic_mgr <- tapply(horiw$horimgrid, horiw$star_geo, mean)
horic_qgr <- tapply(horiw$quartergrid, horiw$star_geo, mean)
horic_1gr <- tapply(horiw$X1grid, horiw$star_geo, mean)

# merge resulting mean tables to one
meanhoric <- rbind(horic_mgr,horic_qgr,horic_1gr)

# calculate mean of selected column (total land area of grid cells of occurrence) grouped by stars
horia_mgr <- tapply(horiw$mgr_totalland, horiw$star_geo, mean)
horia_qgr <- tapply(horiw$qgr_totalland, horiw$star_geo, mean)
horia_1gr <- tapply(horiw$X1gr_totalland, horiw$star_geo, mean)

# merge resulting mean tables to one
meanhoria <- rbind(horia_mgr,horia_qgr,horia_1gr)
