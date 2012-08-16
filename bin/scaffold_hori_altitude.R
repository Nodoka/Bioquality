# load data
hori_alt  <- read.csv("../data/horim_G04intsect.csv")
hori_samp <- read.csv("../data/horim_Pheader.csv")

# delete NA value columns
hori_alt <- subset(hori_alt, avgalt != 99999.0)

# calulate average, max, minimum altitude
avg_alt <- tapply(hori_alt$avgalt, hori_alt$SAMPNAME, mean)
max_alt <- tapply(hori_alt$maxalt, hori_alt$SAMPNAME, max)
min_alt <- tapply(hori_alt$minalt, hori_alt$SAMPNAME, min)

# combine altitude data
alts <- cbind(avg_alt, max_alt)
alts <- cbind(alts, min_alt)

# convert to dataframe
alts_frame <- data.frame(sampname=row.names(alts),
                         avgalt=alts[,1],
                         maxalt=alts[,2],
                         minalt=alts[,3],
                         row.names = NULL)

# merge altitude data
hori_sampalt <- merge(hori_samp, alts_frame, all.x = TRUE)

# write results to csv
write.csv(hori_sampalt,
          file="../data/horim_Pheaderedit.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

