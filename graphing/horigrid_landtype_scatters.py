#!/usr/bin/env python
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
# 18, 16, 17 - mgr_totalland, mainisl, smallisl
# 22, 20, 21 - qgr_totalland, mainisl, smallisl
# 25, 23, 24 - X1gr_totalland, mainisl, smallisl
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=11)
grid_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=[14,12,13])
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=[18,22,25])
grid_main = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=[16,20,23])
grid_small = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=[17,21,24])
# remove "" from the text string
stars = [star[1:-1] for star in star_infs]

colours = map(lambda star_colour: 'k' if star_colour == 'BK' else 'y' if star_colour == 'GD' else 'b' if star_colour == 'BU' else 'g' if star_colour == 'GN' else 'w', stars)

resolutions = (
    '0.1 lat. by 0.15 long. geoquadrat',
    '0.2 lat by 0.3 long. grid',
    '1 lat. by 1 long. grid',
)

fig = plt.figure()
fig.suptitle('Comparison of Species Within-Japan Range Size Between Area and Count Measured at 3 Resolutions Using Horikawa Maps', fontsize=12)

def plot_scatter(index):
    ax = fig.add_subplot(131 + index)
    # grid_land/10000 to rescale the range
    ax.scatter(grid_land[:,index]/10000, grid_main[:,index]/10000, c=colours, alpha=0.5)
    ax.scatter(grid_land[:,index]/10000, grid_small[:,index]/10000, c=colours, alpha=0.5)
    ax.set_aspect(1)
    ax.set_xlim(0, 38.1)
    ax.set_ylim(0, 38.1)
    # uncomment to manually set ticks
    # xtix = np.arange(0, 380000.1, 100000)
    # ytix = np.arange(0, 1000.1, 200)
    # ax.xaxis.set_ticks(xtix)
    # ax.yaxis.set_ticks(ytix)
    ax.set_xlabel('Grid area at ' + resolutions[index], fontsize=10)
    ax.set_ylabel('Grid count at ' + resolutions[index], fontsize=8)
    #ax.set_title('Comparison of range size between area and count at ' + resolutions[index], fontsize=12)
    ax.grid(True)

for index in range(0,3):
    plot_scatter(index)

plt.show()
