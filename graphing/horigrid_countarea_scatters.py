#!/usr/local/bin/ipython -i
"""
A scatter graph of grid count vs grid area.
"""
import numpy as np
import matplotlib.pyplot as plt

# extract data from csv
# CAUTION! column locations differ from filtered.
# file_name = "../data/Hori_area_weight.csv"

# uncomment when using filtered data
file_name = "../data/Hori_area_weight_filtered.csv"

# columns:
# 11 - star_infs
# 14, 12, 13 = horimgrid, quartergrid, X1grid
# 18 - mgr_totalland
# 22 - qgr_totalland
# 25 - X1gr_totalland
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=11)
grid_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=14)
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=18)
# remove "" from the text string
stars = [star[1:-1] for star in star_infs]

colours = map(lambda star_colour: 'k' if star_colour == 'BK' else 'y' if star_colour == 'GD' else 'b' if star_colour == 'BU' else 'g' if star_colour == 'GN' else 'w', stars)

fig = plt.figure()
ax = fig.add_subplot(111)
# grid_land/10000 to rescale the range
ax.scatter(grid_land, grid_count, c=colours, alpha=0.5)
ax.set_xlim(0, 380000.1)
ax.set_ylim(0, 1000.1)
# uncomment to manually set ticks
# xtix = np.arange(0, 380000.1, 100000)
# ytix = np.arange(0, 1000.1, 200)
# ax.xaxis.set_ticks(xtix)
# ax.yaxis.set_ticks(ytix)

ax.set_xlabel('Horikawa grid area', fontsize=18)
ax.set_ylabel('Horikawa grid count', fontsize=18)
ax.set_title('Comparison of range size', fontsize=22)
ax.grid(True)

plt.show()
