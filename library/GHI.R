GHI.colours <- c('BK', 'GD', 'BU', 'GN')
GHI.coefficients <- c(27,9,3,0)

# takes vector or factor of star categories
# returns the frequencies of 'BK', 'GD', 'BU' and 'GN' as a vector
GHI.star_frequencies <- function(stars) {
  stars <- factor(stars, GHI.colours)
  as.vector(table(stars))
}

GHI.score <- function(frequencies) {
  100 * sum(frequencies * GHI.coefficients) / sum(frequencies)
}

GHI.subsample_frequencies <- function(frequencies, subsample_size) {
  ordered_coefficient_vector <- rep(1:4,frequencies)
  
  # this step is necessary in case any colours don't appear
  # in the subsample i.e. have a frequency of 0
  ordered_coefficient_factor <- factor(ordered_coefficient_vector)
  
  as.vector(table(sample(ordered_coefficient_factor,subsample_size)))
}

# GHI calculation functions
calculate_score <- function(subgroup) {
  GHI.score(GHI.star_frequencies(subgroup))
}

calculate_proportions <- function(subgroup) {
  GHI.star_frequencies(subgroup) / length(subgroup)
}
