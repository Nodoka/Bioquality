#!/usr/local/bin/ipython -i
import numpy as np
import matplotlib.pyplot as plt
import pylab

# extract data from csv
# CAUTION!! column locations differ from filtered
# file_name = "../data/Hori_area_weight.csv"

# uncomment when using filtered data
file_name = "../data/Hori_area_weight_filtered.csv"

# columns:
# 12 or 11(filtered) - star_infs
# 19 or 18(filtered) - mgr_totalland
# 23 or 22(filtered) - qgr_totalland
# 26 or 25(filtered) - X1gr_totalland
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=11)
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=22)

# delete "" when using original data
bk = grid_land[star_infs == '"BK"']
gd = grid_land[star_infs == '"GD"']
bu = grid_land[star_infs == '"BU"']
gn = grid_land[star_infs == '"GN"']

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
ax.set_xlim(0, 10000)

ax.yaxis.set_ticklabels(["Black","Gold","Blue","Green"])
ax.set_xlabel('Species Range Size')
ax.set_ylabel('Star')
# ax.set_ylim(-0.2, 1.4)
# plt.setp(bp['whiskers'], color='k',  linestyle='-' )
# plt.setp(bp['fliers'], markersize=3.0)
plt.show()
# plt.savefig("../graphing/horiall_boxplot.png")

# histograms
n, bins, patches = pylab.hist([bk,gd,bu,gn],
                              bins=25,
                              normed=True,
                              color=['k', 'y', 'b', 'g'])                
pylab.show()
# pylab.savefig("../graphing/horiall_histogram.png")
