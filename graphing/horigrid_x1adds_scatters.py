#!/usr/local/bin/ipython -i
"""
A multi-panel scatter graph of grid count or grid total_land comparing two larger resolutions with the finest.
"""
import numpy as np
import matplotlib.pyplot as plt

# extract data from csv
file_name = "../data/Hori_area_weight_filtered.csv"
#file_name = "../data/Hori_area_weight_filterednoGN.csv"

# columns:
# 11 - star_infs
# 14, 12, 13 = horimgrid, quartergrid, X1grid
# 29 = x1gridadds
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=11)
# count
hori_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=14)
grid_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=[13,29])

# remove "" from the text string
stars = [star[1:-1] for star in star_infs]

colours = map(lambda star_colour: 'k' if star_colour == 'BK' else 'y' if star_colour == 'GD' else 'b' if star_colour == 'BU' else 'g' if star_colour == 'GN' else 'w', stars)

#alphas = map(lambda star_alpha: 0 if star_alpha == 'GN' else 0.5, stars)

resolutions = (
    '1 degree grid',
    '1 degree grid + TDWG data',
)

# calculate proportions of count by normalising populations
# change hori_count to norm_hori_count, grid_count to norm_grid_count
#norm_hori_count = hori_count / 1418.0
#grid_count_matrix = np.mat(grid_count)
#norm_grid_count = np.asarray(np.hstack([grid_count_matrix[:,0]/122.0, #grid_count_matrix[:,1]/122.0]))

# Figure for count
fig = plt.figure()
fig.suptitle('Comparison of Species Within-Japan Range Size Measured at 2 Resolutions Using Horikawa Maps and TDWG data', fontsize=12)

def plot_scatter(index):
    ax = fig.add_subplot(211 + index)
    ax.scatter(hori_count, grid_count[:,index], color=colours, alpha=0.5)
    ax.set_aspect(10)
    ax.set_xlim([0, 1418])
    # qrgrid = 330, x1grid = 122
    ax.set_ylim([0, 122])
    # uncomment to manually set ticks
    # xtix = np.arange(0, 380000.1, 100000)
    # ytix = np.arange(0, 1000.1, 200)
    # ax.xaxis.set_ticks(xtix)
    # ax.yaxis.set_ticks(ytix)
    ax.set_xlabel('Grid count at 0.1 lat. by 0.15 long. geoquadrat', fontsize=12)
    ax.set_ylabel('Grid count at ' + resolutions[index], fontsize=12)
    #ax.set_title('Comparison of range size between area and count at ' + resolutions[index], fontsize=12)
    ax.grid(True)

for index in range(0,2):
    plot_scatter(index)

plt.show()
