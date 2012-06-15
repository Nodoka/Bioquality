source('../library/sanitise_data.R')
source('../library/GHI.R')

# load data
me_plot <- read.csv('../data/MOEocc_plotb.csv',    row.names = NULL)
me_sp   <- read.csv('../data/MOEocc_splistb2.csv', row.names = NULL)

# delete invalid plots
# using del column
del        <- me_plot[,'del']
not_del    <- del != "*"
valid_plot <- me_plot[not_del,]

# using lat
lat        <- me_plot[,'lat']
valid_lat  <- lat != 0
valid_plot <- me_plot[valid_lat,]

# filter valid star for a selected column
me_sp <- filter_rows_by_valid_star(me_sp,'star_infs')

# filter relevant columns
me_plot <- valid_plot[,c('scode','sampname','lat','long')]

# select unique lat-long pair & name gazcode
latlong <- unique(me_plot[,c('lat','long')])
latlong$gazcode <- 1:nrow(latlong)  

# make plot
plot <- merge(me_plot, latlong)

# GHI grouped by plot unit for selected star method
me_score <- tapply(me_sp$star_infs,  me_sp$scode, calculate_score)

# calculate spcount for plot
spno <- table(me_sp$scode)
