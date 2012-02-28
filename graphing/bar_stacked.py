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

# create array of populations
populations = np.array([geo_foj,geo_kew,star_foj,star_kew])

# plot data
def plot_stacked_bar(results):
    # extract each column into a variable
    bk = results[0,:]
    gd = results[1,:]
    bu = results[2,:]
    gn = results[3,:]
    ind = np.arange(4)
    width = 0.35
    p1 = plt.bar(ind, bk, width, color='black')
    p2 = plt.bar(ind, gd, width, color='yellow', bottom=bk)
    p3 = plt.bar(ind, bu, width, color='blue'  , bottom=bk + gd)
    p4 = plt.bar(ind, gn, width, color='green' , bottom=bk + gd + bu)
    plt.xlabel('Data Source')
    plt.legend( (p1[0], p2[0], p3[0], p4[0]), geo_category )
    plt.xticks(ind+width/2., ('GEO FOJ','GEO Kew','Star FOJ','Star Kew') )
    
plot_stacked_bar(populations)

plt.ylabel('Number of Taxa')
plt.title('Number of Taxa Assigned to Stars from 4 Data Sources')

plt.show()
