#!/usr/bin/env python
import numpy as np
import matplotlib.pyplot as plt
import pylab

# extract data from csv
file_name = "../data/tdwgsp_filtered.csv"

# columns (filtered):
# 1 - star_infs
# 2 - tdwgtotals
# 3 - tdwgareas
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=1)
tdwg_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=2)
tdwg_area = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=3)

# CHECK ""
bk = tdwg_area[star_infs == '"BK"']
gd = tdwg_area[star_infs == '"GD"']
bu = tdwg_area[star_infs == '"BU"']
gn = tdwg_area[star_infs == '"GN"']

# box plots
fig = plt.figure()
ax = fig.add_subplot(111)
bp = ax.boxplot([bk, gd, bu, gn],
                vert=0,
                sym='k+',
                patch_artist=True,
                positions=[1,2,3,4],
                notch=1,
                bootstrap=5000)

# configure axes
# ax.set_xlim(0, 10000)
# ax.set_ylim(-0.2, 1.4)
ax.yaxis.set_ticklabels(["Black","Gold","Blue","Green"])
ax.set_xlabel('Species Range Size')
ax.set_ylabel('Star')
# plt.setp(bp['whiskers'], color='k',  linestyle='-' )
# plt.setp(bp['fliers'], markersize=3.0)
plt.show()
#dir plt.savefig("../graphing/horiall_boxplot.png")

# histograms
histfig = plt.figure()
histaxes = histfig.add_subplot(111)
n, bins, patches = histaxes.hist([bk,gd,bu,gn],
                              bins=25,
                              normed=True,
                              color=['k', 'y', 'b', 'g'])  
histaxes.set_xlabel('Species Range Size')              
histaxes.set_ylabel('Frequency')
plt.show()
# pylab.savefig("../graphing/horiall_histogram.png")
