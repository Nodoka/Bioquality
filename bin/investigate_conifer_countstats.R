# load all data
conif_kmcount <- read.csv('../data/conifer_kmcount.csv', row.names = NULL)
conif_grid <- read.csv('../data/conifer_gridcount.csv', row.names = NULL)
conif_tdwg <- read.csv('../data/conifer_tdwgcount.csv', row.names = NULL)
conif_sp <- read.csv('../data/conifer_spmain.csv', row.names = NULL)

# filter relevant columns for species list
splist <- conif_sp[,c('taxstat','spnumber','gecode','sp1','rank1','sp2','rank2','sp3')]

# merge all data
conifersp <- merge(splist, conif_kmcount, all.x=TRUE)
conifersp <- merge(conifersp, conif_grid, all.x=TRUE)
conifersp <- merge(conifersp, conif_tdwg, all.x=TRUE)

# filter infra taxa
rank1 <- conifersp[,'rank1']
infra <- rank1 != ""
spcount <- conifersp[!infra,]
# alternatively
spcount <- subset(conifersp, rank1 == "")

# filter acc taxa
accsp <- subset(spcount, taxstat == "acc")

# the Shapiro-Wilk test of normality: shapiro.test(x)
shapiro.test(accsp$kmcount)
shapiro.test(accsp$gridcount)
shapiro.test(accsp$tdwgcount)

# Kendall's rank correlation coefficcient because of ties
cor.test(accsp$kmcount, accsp$gridcount, use = "na.or.complete", method="kendall")
cor.test(accsp$kmcount, accsp$tdwgcount, use = "na.or.complete", method="kendall")
cor.test(accsp$gridcount, accsp$tdwgcount, use = "na.or.complete", method="kendall")

# Wilcoxon singed-rank test
wilcox.test(accsp$kmcount, accsp$gridcount, paired=TRUE)
wilcox.test(accsp$kmcount, accsp$tdwgcount, paired=TRUE)
wilcox.test(accsp$gridcount, accsp$tdwgcount, paired=TRUE)

# fit a linear model (linear regression analysis)
LM <- lm(accsp$kmcount ~ accsp$tdwgcount)
summary(LM)
# LM for tdwg vs degree
LMd <- lm(accsp$gridcount ~ accsp$tdwgcount)
summary(LMd)

# remove NA values
valid_accsp <- na.omit(accsp)

# write results to file
write.csv(valid_accsp,
          file="../data/conifer_counts.csv",
          fileEncoding="UTF-8",
          row.names = FALSE)

