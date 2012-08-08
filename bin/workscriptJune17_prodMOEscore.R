source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
me_plot <- read.csv('../data/MOEocc_originalplot.csv',    row.names = NULL)
me_sp   <- read.csv('../data/MOEocc_originalsplist.csv', row.names = NULL)

# filter valid stars for a chosen star column
me_sp <- filter_rows_by_valid_star(me_sp,'star_infs')

# select relevant columns
me_plot <- me_plot[,c('plotID','siteid','lat','long')]
me_sp   <- me_sp[,c('siteid','plotID','spnumber','star_infs')]

# GHI grouped by plot unit for selected star method
## siteid or plotID (score???)
me_score <- tapply(me_sp$star_infs,  me_sp$plotID,    calculate_score)

# socount grouped by plot unit
spno <- table(me_sp$plotID)

me_scores <- cbind(me_score, spno)
me_scoreframe <- data.frame(plotID=row.names(me_scores),
                             GHI=me_scores[,1],
                             spno=me_scores[,2])

me_plotscore <- merge(me_plot, me_scoreframe)

# delete invalid plots
# using lat
lat        <- me_plotscore[,'lat']
valid_lat  <- lat != 0
valid_plotscore <- me_plotscore[valid_lat,]

