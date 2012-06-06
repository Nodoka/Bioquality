# load data
brepeat <- read.csv('../data/prefscores_calc_methods.csv', row.names=NULL)
bunique <- read.csv('../data/prefscores_calc_uniqmethods.csv', row.names=NULL)

# the Shapiro-Wilk test of normality: shapiro.test(x)
# summary statsitics: summary(x)
# standard deviation: sapply(x, sd)

## FOJ vs. Horikawa data
# Spearman's rank correlation analysis:
cor(brepeat$foj_scores, brepeat$hori_scores, method ='spearman')
cor(brepeat$foj_scores, brepeat$meanGHI,     method ='spearman')
cor(brepeat$foj_scores, brepeat$maxGHI,      method ='spearman')
cor(bunique$foj_scores, bunique$hori_scores, method ='spearman')
cor(bunique$foj_scores, bunique$meanGHI,     method ='spearman')
cor(bunique$foj_scores, bunique$maxGHI,      method ='spearman')
# Wilcoxon's signed-t test
wilcox.test(brepeat$foj_scores, brepeat$hori_scores, paired=T)
wilcox.test(brepeat$foj_scores, brepeat$meanGHI,     paired=T)
wilcox.test(brepeat$foj_scores, brepeat$maxGHI,      paired=T)
wilcox.test(bunique$foj_scores, bunique$hori_scores, paired=T)
wilcox.test(bunique$foj_scores, bunique$meanGHI,     paired=T)
wilcox.test(bunique$foj_scores, bunique$maxGHI,      paired=T)

## Horikawa data
# Spearman's rank correlation analysis: 
# Brepeat vs Bunique on scores and spno
cor(brepeat$hori_scores, bunique$hori_scores, method='spearman')
cor(brepeat$meanGHI,     bunique$meanGHI,     method='spearman')
cor(brepeat$maxGHI,      bunique$maxGHI,      method='spearman')
cor(brepeat$hori_spno,   bunique$hori_spno,   method='spearman')
cor(brepeat$meanspno,    bunique$meanspno,    method='spearman')
cor(brepeat$maxspno,     bunique$maxspno,     method='spearman')
# Spearman's rank correlation analysis: 
# Holistics vs mean, max for repeat and unique
cor(brepeat$hori_scores, brepeat$maxGHI, method='spearman')
cor(brepeat$hori_scores, brepeat$meanGHI,method='spearman')
cor(bunique$hori_scores, bunique$maxGHI, method='spearman')
cor(bunique$hori_scores, bunique$meanGHI,method='spearman')

# change names of relevant columns
names(brepeat)[3] <- 'holshori_scores'
names(brepeat)[6] <- 'holsmeanGHI'
names(brepeat)[8] <- 'holsmaxGHI'
names(bunique)[3] <- 'uniqhori_scores'
names(bunique)[6] <- 'uniqmeanGHI'
names(bunique)[8] <- 'uniqmaxGHI'
# filter relevant columns & merge 2 data sets
brep <- brepeat[c('preflist','holshori_scores','holsmeanGHI','holsmaxGHI')]
bunq <- bunique[c('preflist','uniqhori_scores','uniqmeanGHI','uniqmaxGHI')]
calscores <- merge(brep, bunq)

# Wilcoxon's signed-t test:
# Brepeat vs Bunique on scores
wilcox.test(calscores$holshori_scores, calscores$uniqhori_scores, paired=T)
wilcox.test(calscores$holsmeanGHI, calscores$uniqmeanGHI,     paired=T)
wilcox.test(calscores$holsmaxGHI,  calscores$uniqmaxGHI,      paired=T)

# Wilcoxons' signed-t test: 
# Holistics vs mean, max for repeat and unique
wilcox.test(calscores$holshori_scores, calscores$holsmaxGHI, paired=T)
wilcox.test(calscores$holshori_scores, calscores$holsmeanGHI,paired=T)
wilcox.test(calscores$uniqhori_scores, calscores$uniqmaxGHI, paired=T)
wilcox.test(calscores$uniqhori_scores, calscores$uniqmeanGHI,paired=T)
