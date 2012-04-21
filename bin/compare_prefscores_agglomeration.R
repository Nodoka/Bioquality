# data generated using the following scripts are called.
source('../bin/compare_GHI_by_prefecture.R')
source('../bin/compare_species_proportions_by_prefecture.R')
source('../bin/manipulate_GHI_by_prefecture.R')

# cell_pref method can be modified in
# manipulate_cell_pref.R

# combine all results into one martix
# merged_scores: before omitting na
# spno: spnos omit variable = 0
# pref_score_mean: filter cell for spcount >39 on cell
# pref_score_max: filter cell for spcount >39, not na.omit in pref_score

allscores <- cbind(foj_scores, hori_scores, foj_spno, hori_spno, pref_score_mean,pref_score_max)

# filter valid scores
valid_allscores <- na.omit(allscores)

# analyses
summary (valid_allscores)

# correlation analyses
> cor(valid_allscores[,2],valid_allscores[,6],method="spearman")
> cor(valid_allscores[,2],valid_allscores[,5],method="spearman")
> cor(valid_allscores[,2],valid_allscores[,4],method="spearman")
> cor(valid_allscores[,1],valid_allscores[,3],method="spearman")
> cor(valid_allscores[,1],valid_allscores[,2],method="spearman")
> cor(valid_allscores[,1],valid_allscores[,5],method="spearman")
> cor(valid_allscores[,1],valid_allscores[,6],method="spearman")

# scatter plots 
> plot(valid_allscores[,1],valid_allscores[,2])
> plot(valid_allscores[,1],valid_allscores[,3])
> plot(valid_allscores[,2],valid_allscores[,4])
> plot(valid_allscores[,2],valid_allscores[,5])
> plot(valid_allscores[,2],valid_allscores[,6])

# wilcoxon's signed-ranks test : non-parametric equivalent of paried-t test 
# for non-normally distributed data
# null hypothesis: difference in medians of two related samples = 0
# pair: ** foj = 1 | hori = 2 vs * cal_GHI = 5,6 | spno = 3,4
# wilcox.test(valid_allscores[,**], valid_allscores[,*], paired=T, conf.int=T)

---------------------------------------------------------
# load data
scores   <- read.csv('../data/FOJHori_scores.csv',     row.names = NULL)
spnos    <- read.csv('../data/FOJHori_spnos.csv',     row.names = NULL)
meanhori <- read.csv('../data/hori_meanscores.csv', row.names = NULL)
maxhori  <- read.csv('../data/hori_maxscores.csv', row.names = NULL)

# PREF!!!
# set pref levels
preflist <- read.csv('../data/preflist.csv')$pref

pref <- make.names(preflist)

# merge scores into one table
merged_scores <- cbind(pref, scores, spnos, meanhori, maxhori)
# filter out invalid values (NA) on scores
valid_scores <- na.omit(merged_scores)

# convert scores to dataframe
scores_frame <- data.frame(preflist=row.names(valid_scores), foj_scores=valid_scores[,1], hori_scores=valid_scores[,2], row.names=NULL)

# write results (scores) to file
write.csv(scores_frame,
          file="../data/scores_bmethods.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")

validscores  <- data.frame(pref=row.names(validscores),      
		    fojscores=validscores[,1],
                    horiscores=validscores[,2],
                    hmeanscores=validscores[,3],
                    hmaxscores=validscores[,4]
)

write.csv(validscores,
          file="../data/testprefscores.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")


