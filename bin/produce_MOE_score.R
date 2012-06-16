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
me_sp   <- me_sp[,c('scode','sampname','spnumber','star_infs')]

## generate new sample plot unit  
# select unique lat-long pair & name gazcode
latlong <- unique(me_plot[,c('lat','long')])
latlong$gazcode <- 1:nrow(latlong)  

## gazgrid = lat/long rounded at 3 decimal places
me_plot[,'rounded_lat']  <- round(me_plot[,'lat'],3)
me_plot[,'rounded_long'] <- round(me_plot[,'long'],3)
latlong <- unique(me_plot[,c('rounded_lat','rounded_long')])
latlong$gazgrid <- 1:nrow(latlong)

# add gazcode column based on unique lat/long combination
plot   <- merge(me_plot, latlong) # by=c('lat','long')

# merge gazcode unit based on scode 
splist <- merge(me_sp, plot)

# unique sort species using spnumber 
me_sp <- unique(splist[,c('scode','sampname','spnumber','star_infs','lat','long','gazcode')])
me_sp <- unique(splist[,c('scode','sampname','spnumber','star_infs','lat','long','gazgrid')])

# GHI grouped by plot unit for selected star method
me_score <- tapply(me_sp$star_infs,  me_sp$scode,    calculate_score)
me_score <- tapply(me_sp$star_infs,  me_sp$gazcode,  calculate_score)
me_score <- tapply(me_sp$star_infs,  me_sp$gazgrid,  calculate_score)

# calculate spcount for plot
spno <- table(me_sp$scode)
spno <- table(me_sp$gazcode)
spno <- table(me_sp$gazgrid)

# transfer results (score and spcount) to plot data
plot_score      <- cbind(me_score, spno)
plotscore_frame <- data.frame(gazcode=row.names(plot_score),
                             GHI=plot_score[,1],
                             spno=plot_score[,2])

plotscore_frame <- data.frame(gazgrid=row.names(plot_score),
                             GHI=plot_score[,1],
                             spno=plot_score[,2])

gazscores <- merge(latlong, plotscore_frame, all.x=T)

# make a new column with valid score based on spno
less_than_40 <- gazscores$spno < 40
less_than_40[is.na(less_than_40)] <- T

gazscores[!less_than_40,'valid_scores'] <- gazscores[!less_than_40,'GHI']

## OPTIONAL
# only keep gazcode with valid scores
valid_gazscores   <- subset(gazscores, spno != NA | spno != 0)


# write results to csv
write.csv(gazscores,
          file="../data/MOEgazcode_scoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(valid_gazscores,
          file="../data/MOEgazcode_validscoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(gazscores,
          file="../data/MOEgazgrid_scoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(valid_gazscores,
          file="../data/MOEgazgrid_validscoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
