#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

# read files
spno_geo  = np.genfromtxt('../data/FOJKew_geo_Gtestdata.csv',  delimiter=',', dtype = None, names=True)
spno_star = np.genfromtxt('../data/FOJKew_star_Gtestdata.csv', delimiter=',', dtype = None, names=True)

# extract columns
geo_category  = map(lambda row: row[0], spno_geo )
geo_foj       = map(lambda row: row[1], spno_geo )
geo_kew       = map(lambda row: row[2], spno_geo )
star_category = map(lambda row: row[0], spno_star)
star_foj      = map(lambda row: row[1], spno_star)
star_kew      = map(lambda row: row[2], spno_star)

# check that star names are the same and in the same order
assert geo_category == star_category

# plot data
ind = np.arange(4)
width = 0.35
p1 = plt.bar(ind, geo_foj, width, color='r')
p2 = plt.bar(ind, geo_kew, width, color='y')

plt.ylabel('Scores')
plt.title('')
plt.xticks(ind+width/2., geo_category )
plt.legend( (p1[0], p2[0]), ('GEO FOJ', 'GEO Kew') )

plt.show()