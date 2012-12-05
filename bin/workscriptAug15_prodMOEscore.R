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
## gazgrid = lat/long rounded at 2 decimal places
me_plot[,'rounded_lat']  <- round(me_plot[,'lat'],2)
me_plot[,'rounded_long'] <- round(me_plot[,'long'],2)
latlong <- unique(me_plot[,c('rounded_lat','rounded_long')])
latlong$gazgrid2 <- 1:nrow(latlong)

# add gazcode column based on unique lat/long combination
plot   <- merge(me_plot, latlong) # by=c('lat','long')

# merge gazcode unit based on scode 
splist <- merge(me_sp, plot)

# unique sort species using spnumber 
me_sp <- unique(splist[,c('scode','sampname','spnumber','star_infs','lat','long','gazgrid2')])

# GHI grouped by plot unit for selected star method
me_score <- tapply(me_sp$star_infs,  me_sp$gazgrid2,  calculate_score)

# calculate spcount for plot
spno <- table(me_sp$gazgrid2)

# transfer results (score and spcount) to plot data
plot_score      <- cbind(me_score, spno)
plotscore_frame <- data.frame(gazgrid2=row.names(plot_score),
                             GHI=plot_score[,1],
                             spno=plot_score[,2])

gazscores <- merge(latlong, plotscore_frame, all.x=T)

## above here change grid2 to grid1 when working on 1 decimal place

# make a new column with valid score based on spno
less_than_40 <- gazscores$spno < 40
less_than_40[is.na(less_than_40)] <- T

gazscores[!less_than_40,'valid_scores'] <- gazscores[!less_than_40,'GHI']

# replace NA with -1
gazscores[is.na(gazscores)] <- -1

# change column names lat/long
names(gazscores)[2] <- 'lat'
names(gazscores)[3] <- 'long'

## OPTIONAL
# only keep gazcode with valid scores
valid_gazscores   <- subset(gazscores, spno != NA & spno != 0)
valid_gazscores   <- subset(gazscores, spno != -1 & spno != 0)

# write results to csv (!change to grid1)
write.csv(gazscores,
          file="../data/MOEgazgrid2_scoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

write.csv(valid_gazscores,
          file="../data/MOEgazgrid2_validscoreR.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

-----
me_plot[,'rounded_lat']  <- round(me_plot[,'lat'],1)
me_plot[,'rounded_long'] <- round(me_plot[,'long'],1)
latlong <- unique(me_plot[,c('rounded_lat','rounded_long')])
latlong$gazgrid1 <- 1:nrow(latlong)

# add gazcode column based on unique lat/long combination
plot   <- merge(me_plot, latlong) # by=c('lat','long')

# merge gazcode unit based on scode 
splist <- merge(me_sp, plot)

# unique sort species using spnumber 
me_sp <- unique(splist[,c('scode','sampname','spnumber','star_infs','lat','long','gazgrid1')])

# GHI grouped by plot unit for selected star method
me_score <- tapply(me_sp$star_infs,  me_sp$gazgrid1,  calculate_score)

# calculate spcount for plot
spno <- table(me_sp$gazgrid1)

# transfer results (score and spcount) to plot data
plot_score      <- cbind(me_score, spno)
plotscore_frame <- data.frame(gazgrid1=row.names(plot_score),
                             GHI=plot_score[,1],
                             spno=plot_score[,2])

gazscores <- merge(latlong, plotscore_frame, all.x=T)


-------
calculate summary statistics
# unique species and stars
uniqsp <-  unique(me_sp[,c('spnumber','star_infs')])


