#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

# extract columns of each dataset
labels = np.genfromtxt('../data/star_sensitivity_spnos_data.csv',delimiter=',',dtype=None,skip_header=1,usecols=0)
# remove "" from the text string
labels = [label[1:-1] for label in labels]
star_sens = np.genfromtxt('../data/star_sensitivity_spnos_data.csv',delimiter=',',dtype=None,skip_header=1,usecols=range(1,7))

# plot data
def plot_stacked_bar(results):
    # extract each column into a variable
    bk = results[0,:]
    gd = results[1,:]
    bu = results[2,:]
    gn = results[3,:]
    ind = np.arange(6)
    width = 0.35
    p1 = plt.bar(ind, bk, width, color='black')
    p2 = plt.bar(ind, gd, width, color='yellow', bottom=bk)
    p3 = plt.bar(ind, bu, width, color='blue'  , bottom=bk + gd)
    p4 = plt.bar(ind, gn, width, color='green' , bottom=bk + gd + bu)
    plt.xlabel('Star Classification Method')
    plt.legend( (p1[0], p2[0], p3[0], p4[0]), labels)
    plt.xticks(ind+width/2., ('Default','GEO','GEO-Up','GEO-Down','INFRA-Auto','INFRA-Selective') )

plot_stacked_bar(star_sens)
plt.ylabel('Number of Taxa')
plt.title('Number of Taxa Assigned to Stars for 6 Star Classification Methods')

plt.show()

# calculate proportions by normalising populations
# use float to prevent integer arithmetic (rounding down to zero)
prop_star_sens = star_sens /sum(star_sens).astype(float)

plot_stacked_bar(prop_star_sens)
plt.ylabel('Proportion of Taxa')
plt.title('Proportion of Taxa Assigned to Stars for 6 Star Classification Methods')

plt.show()
