#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

# extract columns of each dataset
star_category = np.genfromtxt('../data/Ryukyu_starhabit.csv',delimiter=',',dtype=None,skip_header=1,usecols=0)
taxa_no = np.genfromtxt('../data/Ryukyu_starhabit.csv',delimiter=',',dtype=None,skip_header=1,usecols=range(1,6))

# plot data
def plot_stacked_bar(results):
    # extract each column into a variable
    bk = results[0,:]
    gd = results[1,:]
    bu = results[2,:]
    gn = results[3,:]
    ind = np.arange(5)
    width = 0.35
    p1 = plt.bar(ind, bk, width, color='black')
    p2 = plt.bar(ind, gd, width, color='yellow', bottom=bk)
    p3 = plt.bar(ind, bu, width, color='blue'  , bottom=bk + gd)
    p4 = plt.bar(ind, gn, width, color='green' , bottom=bk + gd + bu)
    plt.xlabel('Data Source', size ='large')
    plt.legend( (p1[0], p2[0], p3[0], p4[0]), star_category, loc=2)
    plt.xticks(ind+width/2., ('Tree','Shrub','Climber','Herb','Fern') )

plot_stacked_bar(taxa_no)
plt.ylabel('Number of Taxa', size='large')
plt.title('(1)', position=(1,-0.1))
#plt.title('1) Number of Taxa Assigned to Stars from 4 Data Sources', y=-0.1)

plt.show()


# calculate proportions by normalising populations
# use float to prevent integer arithmetic (rounding down to zero)
prop_taxa_no = taxa_no /sum(taxa_no).astype(float)

plot_stacked_bar(prop_taxa_no)
plt.ylabel('Proportion of Taxa', size='large')
plt.title('(2)', position=(1,-0.1))
#plt.title('2) Proportion of Taxa Assigned to Stars for 6 Star Classification Methods', y=-0.1)

plt.show()
