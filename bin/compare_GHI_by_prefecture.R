source('../library/GHI.R')
source('../library/sanitise_data.R')

# load data
hori <- read.csv('../data/species_pref.csv',     row.names = NULL)
foj  <- read.csv('../data/species_pref_foj.csv', row.names = NULL)

# neaten up raw data frames
hori <- sanitise(hori)
foj  <- sanitise(foj)

# number of species by star and prefecture
calculate_score <- function(subgroup) {
  GHI.score(GHI.star_frequencies(subgroup))
}

calculate_proportions <- function(subgroup) {
  GHI.star_frequencies(subgroup) / length(subgroup)
}

hori_scores <- tapply(hori$star, hori$pref, calculate_score)
foj_scores  <- tapply(foj$star,  foj$pref,  calculate_score)

# paired-t test (correaltion analysis as second step) on scores between hori and foj
# t.test(hori_scores,foj_scores,paired=TRUE)


# write results (scores) to file, to be checked for labels
write.csv(hori_scores,
          file="../data/hori_scores.csv",
          fileEncoding="UTF-8",)

write.csv(foj_scores,
          file="../data/foj_scores.csv",
          fileEncoding="UTF-8",)

barplot(rbind(hori_scores, foj_scores), beside=TRUE)

