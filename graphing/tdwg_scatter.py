#!/usr/local/bin/ipython -i
"""
A scatter graph of grid count vs grid area.
"""
import numpy as np
import matplotlib.pyplot as plt

# extract data from csv
file_name = "../data/tdwgsp_filtered.csv"

# columns (filtered):
# 1 - star_infs
# 2 - tdwgtotals
# 3 - tdwgareas
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=1)
tdwg_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=2)
tdwg_area = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=3)

# remove "" from the text string
stars = [star[1:-1] for star in star_infs]

colours = map(lambda star_colour: 'k' if star_colour == 'BK' else 'y' if star_colour == 'GD' else 'b' if star_colour == 'BU' else 'g' if star_colour == 'GN' else 'w', stars)

fig = plt.figure()
ax = fig.add_subplot(111)
# grid_land/10000 to rescale the range
ax.scatter(tdwg_count, tdwg_area, c=colours, alpha=0.5)
ax.set_xlim(0, 250.1)
ax.set_ylim(0, 12000.1)
# uncomment to manually set ticks
# xtix = np.arange(0, 380000.1, 100000)
# ytix = np.arange(0, 1000.1, 200)
# ax.xaxis.set_ticks(xtix)
# ax.yaxis.set_ticks(ytix)

ax.set_xlabel('Number of TDWG Level 3 Code', fontsize=18)
ax.set_ylabel('Summed Area of TDWG Level 3 Code', fontsize=18)
ax.set_title('Species Geographic Range Size', fontsize=22)
ax.grid(True)

plt.show()
