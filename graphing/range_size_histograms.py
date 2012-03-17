#!/usr/local/bin/ipython -i
import numpy as np
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

n, bins, patches = pylab.hist([bk,gd,bu,gn],
                              bins=5,
                              normed=True,
                              color=['k', 'y', 'b', 'g'])
                              
pylab.show()