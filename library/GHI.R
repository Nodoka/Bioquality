GHI.colours <- c('BK', 'GD', 'BU', 'GN')
GHI.coefficients <- c(27,9,3,0)

GHI.subsample_frequencies <- function(frequencies, subsample_size) {
  ordered_coefficient_vector <- rep(1:4,frequencies)
  
  # this step is necessary in case any colours don't appear
  # in the subsample i.e. have a frequency of 0
  ordered_coefficient_factor <- factor(ordered_coefficient_vector)
  
  as.vector(table(sample(ordered_coefficient_factor,subsample_size)))
}

GHI.score <- function(frequencies) {
  100 * sum(frequencies * GHI.coefficients) / sum(frequencies)
}
