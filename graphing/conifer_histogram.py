#!/usr/local/bin/ipython -i
# range_size histogram for all species without star specification
import numpy as np
import matplotlib.pyplot as plt
import pylab

# extract column from csv
kmcount = np.genfromtxt('../data/conifer_kmcount.csv', delimiter=',', dtype=None, skip_header=1, usecols=1)
gridcount = np.genfromtxt('../data/conifer_gridcount.csv', delimiter=',', dtype=None, skip_header=1, usecols=1)
tdwg = np.genfromtxt('../data/conifer_tdwgcount.csv', delimiter=',', dtype=None, skip_header=1, usecols=1)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_xlabel('Number of 100 km$^2$ Grid', fontsize='large')
ax.set_ylabel('Normalised Frequency', fontsize='large')
#ax.set_title('Normalised Frequency Distribution of Species Range Size')
# histograms
n, bins, patches = pylab.hist(kmcount,
                   bins=40,
                   normed=True,
                   color='m')            
pylab.show()

fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_xlabel('Number of TDWG level 3 Codes', fontsize='large')
ax.set_ylabel('Normalised Frequency', fontsize='large')
#ax.set_title('Normalised Frequency Distribution of Species Range Size')
# histograms
n, bins, patches = pylab.hist(tdwg,
                   bins=40,
                   normed=True,
                   color='m')            
pylab.show()
