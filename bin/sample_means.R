source('../library/GHI.R')

# load all data
plants          <- read.csv('../data/plants.csv',          row.names = 1)
mainsplistR     <- read.csv('../data/mainsplistR.csv',     row.names = NULL)
testsamplerbs09 <- read.csv('../data/testsamplerbs09.csv', row.names = NULL)
testsampleutaki <- read.csv('../data/testsampleutaki.csv', row.names = NULL)
testsamprbs10   <- read.csv('../data/testsamprbs10.csv',   row.names = NULL)

# uncomment to select a dataset
# dataset <- mainsplistR
dataset <- testsamplerbs09
# dataset <- testsampleutaki
# dataset <- testsamprbs10

# extract the 'star' column of a chosen dataset
stars <- dataset$star

# extract the frequencies of 'BK', 'GD', 'BU' and 'GN' as a vector
frequencies <- GHI.star_frequencies(stars)

# generate a random subsample of frequencies half the size of the dataset
# and calculate the frequencies of the subsample
subsample_size <- sum(frequencies) %/% 2
number_of_subsamples <- 1000

# generate lots of subsamples and record their frequency distributions
# in a big matrix
subsample_frequencies <- 
  replicate(number_of_subsamples, GHI.subsample_frequencies(frequencies, subsample_size))

# calculate score for each column in subsample_frequencies
scores <- apply(subsample_frequencies, 2, GHI.score)

# plot results
hist(scores)
