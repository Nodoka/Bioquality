#!/usr/bin/env python
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
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=18)

# delete "" when using original data
bk = grid_land[star_infs == '"BK"']
gd = grid_land[star_infs == '"GD"']
bu = grid_land[star_infs == '"BU"']
gn = grid_land[star_infs == '"GN"']

# histograms
histfig = plt.figure()
histaxes = histfig.add_subplot(111)
n, bins, patches = histaxes.hist([bk/10000,gd/10000,bu/10000,gn/10000],
                              bins=32,
                              histtype='barstacked',
                              normed=True,
                              color=['k', 'y', 'b', 'g'])  
histaxes.set_xlabel('Species Range Size')              
histaxes.set_ylabel('Frequency')
plt.show()
# pylab.savefig("../graphing/horiall_histogram.png")
