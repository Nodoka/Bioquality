#!/usr/local/bin/ipython -i
import numpy as np
import matplotlib.pyplot as plt
import pylab

# extract data from csv
file_name = "../data/Hori_area_weight.csv"

# columns:
# 12 - star_infs
# 19 - mgr_total_land
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=12)
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=19)

bk = grid_land[star_infs == "BK"]
gd = grid_land[star_infs == "GD"]
bu = grid_land[star_infs == "BU"]
gn = grid_land[star_infs == "GN"]

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

# text_transform= mtransforms.blended_transform_factory(ax.transData,
#                                                      ax.transAxes)
# ax.set_xlabel('treatment')
# ax.set_ylabel('response')
# ax.set_ylim(-0.2, 1.4)
# plt.setp(bp['whiskers'], color='k',  linestyle='-' )
# plt.setp(bp['fliers'], markersize=3.0)
plt.show()

# histograms
n, bins, patches = pylab.hist([bk,gd,bu,gn],
                              bins=25,
                              normed=True,
                              color=['k', 'y', 'b', 'g'])                
pylab.show()
