#!/usr/local/bin/ipython -i
# range_size histogram for all species without star specification
import numpy as np
import matplotlib.pyplot as plt
import pylab

# extract data from csv
# CAUTION!! column locations differ from filtered
# file_name = "../data/Hori_area_weight.csv"

# uncomment when using filtered data
file_name = "../data/Hori_area_weight_filtered.csv"

# columns:
# 12 or 11(filtered) - star_infs (not used)
# 19 or 18(filtered) - mgr_totalland
# 23 or 22(filtered) - qgr_totalland
# 26 or 25(filtered) - X1gr_totalland
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=18)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_xlabel('Species Range Size')
ax.set_ylabel('Frequency')
ax.set_title('Normalised Frequency Distribution of Species Range Size')
# histograms
n, bins, patches = pylab.hist(grid_land/10000,
                   bins=32,
                   normed=True,
                   color='r')            
pylab.show()

# pylab.savefig("../graphing/horiall_histogram_nostar.png")
