#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

# read files
spno_geo  = np.genfromtxt('../data/FOJKew_geo_Gtestdata.csv',  delimiter=',', dtype = None, names=True)
spno_star = np.genfromtxt('../data/FOJKew_star_Gtestdata.csv', delimiter=',', dtype = None, names=True)

# extract columns
star = map(lambda row: row[0], spno_geo)
foj = map(lambda row: row[1], spno_geo)
kew  = map(lambda row: row[2], spno_geo)


# plot data
# p1 = plt.bar(ind, menMeans,   width, color='r', yerr=womenStd)
# p2 = plt.bar(ind, womenMeans, width, color='y',
#              bottom=menMeans, yerr=menStd)
# 
# plt.ylabel('Scores')
# plt.title('Scores by group and gender')
# plt.xticks(ind+width/2., ('G1', 'G2', 'G3', 'G4', 'G5') )
# plt.yticks(np.arange(0,81,10))
# plt.legend( (p1[0], p2[0]), ('Men', 'Women') )
# 
# plt.show()