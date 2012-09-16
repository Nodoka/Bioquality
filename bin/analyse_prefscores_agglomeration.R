# generated in 
source('../bin/compare_prefscore_agglomeration.R')
# load data
rept <- read.csv('../data/prefscores_calc_methods.csv', row.names=NULL)
uniq <- read.csv('../data/prefscores_calc_uniqmethods.csv', row.names=NULL)
excl <- read.csv('../data/prefscores_calc_exclmethods.csv', row.names=NULL)

# omit NA values
valid_rept <- na.omit(rept)
valid_uniq <- na.omit(uniq)
valid_excl <- na.omit(excl)

# omit Izu 
valid_rept <- valid_rept[-48,]
valid_uniq <- valid_uniq[-48,]
valid_excl <- valid_excl[-47,]

# omit Tokyo when comparing with 'excl' method
no_tokyo   <- valid_rept$preflist != 'Tokyo'
mvalid_rept <- valid_rept[no_tokyo,]
mvalid_uniq <- valid_uniq[no_tokyo,]

# summary statistics
diff_reptuniq <- valid_rept[,-1]  - valid_uniq[,-1]
diff_reptexcl <- mvalid_rept[,-1] - valid_excl[,-1]
diff_uniqexcl <- mvalid_uniq[,-1] - valid_excl[,-1]

sapply(diff_reptuniq, mean)
sapply(diff_reptuniq, sd)
sapply(diff_reptexcl, mean)
sapply(diff_reptexcl, sd)
sapply(diff_uniqexcl, mean)
sapply(diff_uniqexcl, sd)

# select columns for scores
rept_scores  <- valid_rept[,c('hori_scores','meanGHI','maxGHI')]
uniq_scores  <- valid_uniq[,c('hori_scores','meanGHI','maxGHI')]
excl_scores  <- valid_excl[,c('hori_scores','meanGHI','maxGHI')]

# diff between calculation methods
diff_rept <- rept_scores[,-1] - replicate(2,rept_scores[,1])
diff_uniq <- uniq_scores[,-1] - replicate(2,uniq_scores[,1])
diff_excl <- excl_scores[,-1] - replicate(2,excl_scores[,1])

# diff between foj
foj_scores  <- valid_rept[,c('preflist','foj_scores')]
mfoj_scores <- mvalid_rept[,c('preflist','foj_scores')]

rept_foj <- replicate(3,foj_scores[-1,2]) - rept_scores
uniq_foj <- replicate(3,foj_scores[-1,2]) - uniq_scores
excl_foj <- replicate(3,mfoj_scores[-1,2]) - excl_scores


# the Shapiro-Wilk test of normality: shapiro.test(x)
# summary statsitics: summary(x)
# standard deviation: sapply(x, sd)

## Horikawa data
# Spearman's rank correlation analysis: 
# Holistics vs mean, max for repeat and valid_unique, valid_excl
cor.test(valid_rept$hori_scores, valid_rept$meanGHI, method='spearman')
cor.test(valid_rept$hori_scores, valid_rept$maxGHI,  method='spearman')
cor.test(valid_uniq$hori_scores, valid_uniq$meanGHI, method='spearman')
cor.test(valid_uniq$hori_scores, valid_uniq$maxGHI,  method='spearman')
cor.test(valid_excl$hori_scores, valid_excl$meanGHI, method='spearman')
cor.test(valid_excl$hori_scores, valid_excl$maxGHI,  method='spearman')

# Spearman's rank correlation analysis: 
# valid_rept vs valid_uniq on scores and spno
cor.test(valid_rept$hori_scores, valid_uniq$hori_scores, method='spearman')
cor.test(valid_rept$meanGHI,     valid_uniq$meanGHI,     method='spearman')
cor.test(valid_rept$maxGHI,      valid_uniq$maxGHI,      method='spearman')

cor.test(valid_rept$hori_spno,   valid_uniq$hori_spno,   method='spearman')
cor.test(valid_rept$meanspno,    valid_uniq$meanspno,    method='spearman')
cor.test(valid_rept$maxspno,     valid_uniq$maxspno,     method='spearman')

# comparison of modified valid_rept or valid_uniq vs valid_excl
cor.test(mvalid_rept$hori_scores, valid_excl$hori_scores, method='spearman')
cor.test(mvalid_rept$meanGHI,     valid_excl$meanGHI,     method='spearman')
cor.test(mvalid_rept$maxGHI,      valid_excl$maxGHI,      method='spearman')

cor.test(mvalid_rept$hori_spno,   valid_excl$hori_spno,   method='spearman')
cor.test(mvalid_rept$meanspno,    valid_excl$meanspno,    method='spearman')
cor.test(mvalid_rept$maxspno,     valid_excl$maxspno,     method='spearman')

cor.test(mvalid_uniq$hori_scores, valid_excl$hori_scores, method='spearman')
cor.test(mvalid_uniq$meanGHI,     valid_excl$meanGHI,     method='spearman')
cor.test(mvalid_uniq$maxGHI,      valid_excl$maxGHI,      method='spearman')

cor.test(mvalid_uniq$hori_spno,   valid_excl$hori_spno,   method='spearman')
cor.test(mvalid_uniq$meanspno,    valid_excl$meanspno,    method='spearman')
cor.test(mvalid_uniq$maxspno,     valid_excl$maxspno,     method='spearman')

## FOJ vs. Horikawa data
# Spearman's rank correlation analysis:
cor.test(valid_rept$foj_scores, valid_rept$hori_scores, method ='spearman')
cor.test(valid_rept$foj_scores, valid_rept$meanGHI,     method ='spearman')
cor.test(valid_rept$foj_scores, valid_rept$maxGHI,      method ='spearman')
cor.test(valid_uniq$foj_scores, valid_uniq$hori_scores, method ='spearman')
cor.test(valid_uniq$foj_scores, valid_uniq$meanGHI,     method ='spearman')
cor.test(valid_uniq$foj_scores, valid_uniq$maxGHI,      method ='spearman')
cor.test(valid_excl$foj_scores, valid_excl$hori_scores, method ='spearman')
cor.test(valid_excl$foj_scores, valid_excl$meanGHI,     method ='spearman')
cor.test(valid_excl$foj_scores, valid_excl$maxGHI,      method ='spearman')

# Wilcoxon's signed-t test
wilcox.test(valid_rept$foj_scores, valid_rept$hori_scores, paired=T)
wilcox.test(valid_rept$foj_scores, valid_rept$meanGHI,     paired=T)
wilcox.test(valid_rept$foj_scores, valid_rept$maxGHI,      paired=T)
wilcox.test(valid_uniq$foj_scores, valid_uniq$hori_scores, paired=T)
wilcox.test(valid_uniq$foj_scores, valid_uniq$meanGHI,     paired=T)
wilcox.test(valid_uniq$foj_scores, valid_uniq$maxGHI,      paired=T)
wilcox.test(valid_excl$foj_scores, valid_excl$hori_scores, paired=T)
wilcox.test(valid_excl$foj_scores, valid_excl$meanGHI,     paired=T)
wilcox.test(valid_excl$foj_scores, valid_excl$maxGHI,      paired=T)

# change names of relevant columns
# $foj_scores = [,2]
# $hori_scores = [,3]
# $meanGHI = [,6]
# $maxGHI = [,8]
names(valid_rept)[3] <- 'holshori_scores'
names(valid_rept)[6] <- 'holsmeanGHI'
names(valid_rept)[8] <- 'holsmaxGHI'
names(valid_uniq)[3] <- 'uniqhori_scores'
names(valid_uniq)[6] <- 'uniqmeanGHI'
names(valid_uniq)[8] <- 'uniqmaxGHI'
# filter relevant columns & merge 2 data sets
brep <- valid_rept[c('preflist','holshori_scores','holsmeanGHI','holsmaxGHI')]
bunq <- valid_uniq[c('preflist','uniqhori_scores','uniqmeanGHI','uniqmaxGHI')]
calscores <- merge(brep, bunq)

# Wilcoxon's signed-t test:
# valid_rept vs valid_uniq on scores
wilcox.test(calscores$holshori_scores, calscores$uniqhori_scores, paired=T)
wilcox.test(calscores$holsmeanGHI, calscores$uniqmeanGHI, paired=T)
wilcox.test(calscores$holsmaxGHI,  calscores$uniqmaxGHI,  paired=T)

# Wilcoxons' signed-t test: 
# Holistics vs mean, max for repeat and unique
wilcox.test(calscores$holshori_scores, calscores$holsmaxGHI, paired=T)
wilcox.test(calscores$holshori_scores, calscores$holsmeanGHI,paired=T)
wilcox.test(calscores$uniqhori_scores, calscores$uniqmaxGHI, paired=T)
wilcox.test(calscores$uniqhori_scores, calscores$uniqmeanGHI,paired=T)



# alternative Kendall correlation analysis:
# install package 'Kendall'
install.packages("Kendall")
library("Kendall")
## FOJ vs. Horikawa data
Kendall(valid_rept$foj_scores, valid_rept$hori_scores)
Kendall(valid_rept$foj_scores, valid_rept$meanGHI)
Kendall(valid_rept$foj_scores, valid_rept$maxGHI)
Kendall(valid_uniq$foj_scores, valid_uniq$hori_scores)
Kendall(valid_uniq$foj_scores, valid_uniq$meanGHI)
Kendall(valid_uniq$foj_scores, valid_uniq$maxGHI)
Kendall(valid_excl$foj_scores, valid_excl$hori_scores)
Kendall(valid_excl$foj_scores, valid_excl$meanGHI)
Kendall(valid_excl$foj_scores, valid_excl$maxGHI)

## comparison of border treatment
Kendall(valid_rept$hori_scores,  valid_uniq$hori_scores)
Kendall(valid_rept$meanGHI,      valid_uniq$meanGHI)
Kendall(valid_rept$maxGHI,       valid_uniq$maxGHI)
Kendall(mvalid_rept$hori_scores, valid_excl$hori_scores)
Kendall(mvalid_rept$meanGHI,     valid_excl$meanGHI)
Kendall(mvalid_rept$maxGHI,      valid_excl$maxGHI)
Kendall(mvalid_uniq$hori_scores, valid_excl$hori_scores)
Kendall(mvalid_uniq$meanGHI,     valid_excl$meanGHI)
Kendall(mvalid_uniq$maxGHI,      valid_excl$maxGHI)

## comparison of GHI calculation
Kendall(valid_rept$hori_scores, valid_rept$maxGHI)
Kendall(valid_rept$hori_scores, valid_rept$meanGHI)
Kendall(valid_uniq$hori_scores, valid_uniq$maxGHI)
Kendall(valid_uniq$hori_scores, valid_uniq$meanGHI)
Kendall(valid_excl$hori_scores, valid_excl$maxGHI)
Kendall(valid_excl$hori_scores, valid_excl$meanGHI)


