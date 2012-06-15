source('../library/sanitise_data.R')
source('../library/GHI.R')

# load data
me_plot <- read.csv('../data/MOEocc_plotb.csv',    row.names = NULL)
me_sp   <- read.csv('../data/MOEocc_splistb.csv', row.names = NULL)

# delete invalid plots
# using del column
del        <- me_plot[,'del']
not_del    <- del != "*"
valid_plot <- me_plot[not_del,]

# using lat
lat        <- me_plot[,'lat']
valid_lat  <- lat != 0
valid_plot <- me_plot[valid_lat,]

# filter valid stars for a chosen star column
me_sp <- filter_rows_by_valid_star(me_sp,'star_infs')

# select relevant columns
me_plot <- valid_plot[,c('scode','sampname','lat','long')]
me_sp <- me_sp[,c('scode','sampname','spnumber','star_infs')]

## generate new sample plot unit  
# select unique lat-long pair & name gazcode
latlong <- unique(me_plot[,c('lat','long')])
latlong$gazcode <- 1:nrow(latlong)  

## gazgrid = lat/long at 4 decimal places??

# add gazcode column based on unique lat/long combination
plot <- merge(me_plot, latlong, by=c('lat','long'))

# merge gazcode unit based on scode 
splist <- merge(me_sp, plot)

# unique sort species using spnumber 
me_sp <- unique(splist[,c('scode','sampname','spnumber','star_infs','lat','long','gazcode')])

# GHI grouped by plot unit for selected star method
me_score <- tapply(me_sp$star_infs,  me_sp$scode, calculate_score)
me_score <- tapply(me_sp$star_infs,  me_sp$gazcode,  calculate_score)

# calculate spcount for plot
spno <- table(me_sp$scode)
spno <- table(me_sp$gazcode)

# transfer results (score and spcount) to plot data
plot_score <- cbind(me_score, spno)
plotscore_frame <- data.frame(gazcode=row.names(plot_score),
                             GHI=plot_score[,1],
                             spno=plot_score[,2])

gazscore <- merge(latlong, plotscore_frame, all.x=T)

# write results to csv
write.csv(gazscore,
          file="../data/MOEgazcode_scoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
