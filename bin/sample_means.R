source('../library/GHI.R')

# load all data
plants          <- read.csv('../data/plants.csv',          row.names = 1)
mainsplistR     <- read.csv('../data/mainsplistR.CSV',     row.names = NULL)
testsamplerbs09 <- read.csv('../data/testsamplerbs09.CSV', row.names = NULL)
testsampleutaki <- read.csv('../data/testsampleutaki.CSV', row.names = NULL)
testsamprbs10   <- read.csv('../data/testsamprbs10.CSV',   row.names = NULL)

# uncomment to select a dataset
# dataset <- mainsplistR
dataset <- testsamplerbs09
# dataset <- testsampleutaki
# dataset <- testsamprbs10

# extract the 'star' column of a chosen dataset
star <- dataset$star

# extract the frequencies of 'BK', 'GD', 'BU' and 'GN' as a vector
frequencies <- as.vector(table(star)[GHI.colours])

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
