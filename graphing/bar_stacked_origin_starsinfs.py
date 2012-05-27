#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

# read files
spno_star = np.genfromtxt('../data/FOJKew_star_Gtestdata.csv', delimiter=',', dtype = None, names=True)
spno_infs  = np.genfromtxt('../data/FOJKew_infs_Gtestdata.csv',  delimiter=',', dtype = None, names=True)

# extract columns
star_category  = map(lambda row: row[0], spno_star)
star_foj       = map(lambda row: row[1], spno_star)
star_kew       = map(lambda row: row[2], spno_star)
infs_category  = map(lambda row: row[0], spno_infs )
infs_foj       = map(lambda row: row[1], spno_infs )
infs_kew       = map(lambda row: row[2], spno_infs )

# check that star names are the same and in the same order
assert star_category == infs_category

# create array of populations
populations = np.array([star_foj,infs_foj,star_kew,infs_kew])


# plot data
def plot_stacked_bar(results):
    # extract each column into a variable
    bk = results[:,0]
    gd = results[:,1]
    bu = results[:,2]
    gn = results[:,3]
    ind = np.arange(4)
    width = 0.35
    p1 = plt.bar(ind, bk, width, color='black')
    p2 = plt.bar(ind, gd, width, color='yellow', bottom=bk)
    p3 = plt.bar(ind, bu, width, color='blue'  , bottom=bk + gd)
    p4 = plt.bar(ind, gn, width, color='green' , bottom=bk + gd + bu)
    plt.xlabel('Data Source', size ='large')
    plt.legend( (p1[0], p2[0], p3[0], p4[0]), star_category)
    plt.xticks(ind+width/2., ('Star FOJ','infs FOJ','Star Kew','infs Kew') )

plot_stacked_bar(populations)
plt.ylabel('Number of Taxa', size='large')
plt.title('(1)', position=(1,-0.1))
#plt.title('1) Number of Taxa Assigned to Stars from 4 Data Sources', y=-0.1)

plt.show()

# calculate proportions by normalising populations
# use float to prevent integer arithmetic (rounding down to zero)
norm_star_foj  = star_foj / np.sum(star_foj).astype(float)
norm_star_kew  = star_kew / np.sum(star_kew).astype(float)
norm_infs_foj  = infs_foj  / np.sum(infs_foj ).astype(float)
norm_infs_kew  = infs_kew  / np.sum(infs_kew ).astype(float)

proportions = np.array([norm_star_foj,norm_infs_foj,norm_star_kew,norm_infs_kew])

plot_stacked_bar(proportions)
plt.ylabel('Proportion of Taxa', size='large')
plt.title('(2)', position=(1,-0.1))
#plt.title('2) Proportion of Taxa Assigned to Stars from 4 Data Sources', y=-0.1)

plt.show()
