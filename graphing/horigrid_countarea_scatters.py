"""
A scatter graph of grid count vs grid area.
Check for xy limits, possible in multi panel?
"""
import numpy as np
import matplotlib.pyplot as plt

# extract data from csv
# file_name = "../data/Hori_area_weight.csv"

# uncomment when using filtered data
file_name = "../data/Hori_area_weight_filtered.csv"

# columns:
# 12 - star_infs
# 15, 13, 14 = horimgrid, quartergrid, X1grid [error in 13]
# 19 - mgr_totalland
# 23 - qgr_totalland
# 26 - X1gr_totalland
star_infs = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=12)
grid_count = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=15)
grid_land = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=19)


# old script using a differently formatted dataset
# spnos = np.array(list(np.genfromtxt("../data/spnos.csv",delimiter=',', dtype=None, names=True)[0])[1:])

# threshold = 1500
# colours = star_infs???
# bk = grid_land[star_infs == "BK"]
# gd = grid_land[star_infs == "GD"]
# bu = grid_land[star_infs == "BU"]
# gn = grid_land[star_infs == "GN"]
# color=['k', 'y', 'b', 'g']
# colours = map(lambda spno: 'r' if spno < threshold else 'b', spnos)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(grid_land, grid_count, alpha=0.5)

#error: name xticks|yticks not defined.
#xtix = arange(0, 380000.1, 500)
#ytix = arange(0, 1000.1, 100)
#xticks(xtix)
#yticks(ytix)

ax.set_xlabel('Horikawa grid area', fontsize=18)
ax.set_ylabel('Horikawa grid count', fontsize=18)
ax.set_title('Comparison of range size', fontsize=22)
ax.grid(True)

plt.show()
