# generated in 
source('../bin/compare_prefscore_agglomeration.R')
# load all data
rept <- read.csv('../data/prefscores_calc_methods.csv', row.names = NULL)
uniq <- read.csv('../data/prefscores_calc_uniqmethods.csv', row.names = NULL)

# omit NA values
valid_rept <- na.omit(rept)
valid_uniq <- na.omit(uniq)

# omit Izu 
valid_rept <- valid_rept[-48,]
valid_uniq <- valid_uniq[-48,]

# correlation analyses
# holistic vs mean or max GHI
# $foj_scores = [,2]
# $hori_scores = [,3]
# $meanGHI = [,6]
# $maxGHI = [,8]
cor(valid_rept$hori_scores, valid_rept$meanGHI, method="spearman")
cor(valid_rept$hori_scores, valid_rept$maxGHI, method="spearman")
cor(valid_uniq$hori_scores, valid_uniq$meanGHI, method="spearman")
cor(valid_uniq$hori_scores, valid_uniq$maxGHI, method="spearman")

# repeat vs valid_unique agglomeration
cor(valid_rept$hori_scores, valid_uniq$hori_scores, method="spearman")
cor(valid_rept$meanGHI, valid_uniq$meanGHI, method="spearman")
cor(valid_rept$maxGHI, valid_uniq$maxGHI, method="spearman")

# hori vs FOJ
cor(valid_rept$hori_scores, valid_rept$foj_scores, method="spearman")
cor(valid_rept$meanGHI, valid_rept$foj_scores, method="spearman")
cor(valid_rept$maxGHI, valid_rept$foj_scores, method="spearman")
cor(valid_uniq$hori_scores, valid_uniq$foj_scores, method="spearman")
cor(valid_uniq$meanGHI, valid_uniq$foj_scores, method="spearman")
cor(valid_uniq$maxGHI, valid_uniq$foj_scores, method="spearman")

