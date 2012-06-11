# data generated using the following scripts are called.
source('../bin/compare_GHI_by_prefecture.R')
source('../bin/produce_cell_score.R')

# load data
cell_pref  <- read.csv('../data/cell_pref.csv',    row.names = NULL)
# data from BRAHMS
# cell_score <- read.csv('../data/Hori_plot_score.csv', row.names = NULL)
# R generated data
# cell_score <- read.csv('../data/hori_plot_scoreR.csv', row.names = NULL)
# scores_frame <- read.csv ('../data/FOJHori_scores.csv', row.names = NULL)


# change column names
names(scores_frame)[1] <- 'Pref'

# filter relevant columns
cell_pref <- cell_pref[c('sampname','Pref')]
pref_scores <- scores_frame[c('Pref','hori_scores')]
# merge agglomerated pref scores to cell_pref
aggscore <- merge(cell_pref,pref_scores)

# set sampname levels???? 
cell <- unique(cell_pref$sampname)
cell_score$sampname <- factor(cell_score$sampname,cell)

# merge agglomerated scores to cell_scores
cellpref_scores <- merge(cell_score, aggscore)

# write results to csv
write.csv(cellpref_scores,
          file="../data/cellpref_score.csv",
          row.names=FALSE,
          fileEncoding="UTF-8")
