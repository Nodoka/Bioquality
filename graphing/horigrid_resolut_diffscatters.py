#!/usr/local/bin/ipython -i
"""
A multi-panel scatter graph of grid count or grid total_land comparing two larger resolutions with the finest.
"""
import numpy as np
import matplotlib.pyplot as plt


# extract data from csv
file_name = "../data/Hori_area_weight_filtered.csv"

# columns:
# 11 - star_infs
# 14, 12, 13 = horimgrid, quartergrid, X1grid
# 18 - mgr_totalland
# 22 - qgr_totalland
# 25 - X1gr_totalland
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=11)
# count
hori_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=14)
grid_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=[12,13])
# total_land
hori_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=18)
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=[22,25])

# remove "" from the text string
stars = [star[1:-1] for star in star_infs]


colours = map(lambda star_colour: 'k' if star_colour == 'BK' else 'y' if star_colour == 'GD' else 'b' if star_colour == 'BU' else 'g' if star_colour == 'GN' else 'w', stars)

resolutions = (
    '0.2 lat by 0.3 long. grid',
    '1 lat. by 1 long. grid',
)

# make count as proportions??
# calculate proportions by normalising populations
# use float to prevent integer arithmetic (rounding down to zero)
# norm_qrgrid_count  = grid_count[:,0]*100 / 330
# norm_x1grid_count  = grid_count[:,1]*100 / 122 np.sum(star_kew).astype(float)

norm_hori_count = hori_count / 1418.0
grid_count_matrix = np.mat(grid_count)
norm_grid_count = np.asarray(np.hstack([grid_count_matrix[:,0]/330.0, grid_count_matrix[:,1]/122.0]))

# Figure for count
fig = plt.figure()
fig.suptitle('Comparison of Species Within-Japan Range Size Measured at 3 Resolutions Using Horikawa Maps', fontsize=12)

def plot_scatter(index):
    ax = fig.add_subplot(211 + index)
    #change to proportions
    ax.scatter(norm_hori_count, norm_grid_count[:,index], c=colours, alpha=0.5)
    ax.set_aspect(1)
    ax.set_xlim([0, 1])
    ax.set_ylim([0, 1])
    ax.set_xlabel('Grid count at 0.1 lat. by 0.15 long. geoquadrat', fontsize=12)
    ax.set_ylabel('Grid count at ' + resolutions[index], fontsize=12)
    #ax.set_title('Comparison of range size between area and count at ' + resolutions[index], fontsize=12)
    ax.grid(True)

for index in range(0,2):
    plot_scatter(index)

plt.show()

# Figure for total_land
fig = plt.figure()
fig.suptitle('Comparison of Species Within-Japan Range Size Measured at 3 Resolutions Using Horikawa Maps', fontsize=12)

def plot_scatter(index):
    ax = fig.add_subplot(211 + index)
    y = np.log((grid_land[:,index] - hori_land)/hori_land+1)
    ax.scatter(hori_land, y, c=colours, alpha=0.5)
    #ax.set_aspect(1)
    # max.total_land is 380000/10000
    ax.set_xlim([0, 350000])
    ax.set_ylim([0, 6])
    # uncomment to manually set ticks
    # xtix = np.arange(0, 380000.1, 100000)
    # ytix = np.arange(0, 1000.1, 200)
    # ax.xaxis.set_ticks(xtix)
    # ax.yaxis.set_ticks(ytix)
    ax.set_xlabel('Grid area at 0.1 lat. by 0.15 long. geoquadrat', fontsize=10)
    ax.set_ylabel('Grid area at ' + resolutions[index], fontsize=10)
    #ax.set_title('Comparison of range size between area and count at ' + resolutions[index], fontsize=12)
    ax.grid(True)

for index in range(0,2):
    plot_scatter(index)

plt.show()
