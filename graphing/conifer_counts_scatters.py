#!/usr/local/bin/ipython -i
"""
Scatter graphs of gridcount, tdwgcount against baseline kmcount for conifer data.
"""
import numpy as np
import matplotlib.pyplot as plt

# extract data from csv
# columns:
# 8 = kmcount
# 9 = gridcount
# 10 = tdwgcount
counts = np.genfromtxt("../data/conifer_counts.csv", delimiter=',', dtype=None, skip_header=1, usecols=range(8,11))

# add y = x line
lx = np.arange(0,130)
ly = np.arange(0,130)


fig = plt.figure()
count_types = (
    '100 km$^2$ Grid',
    'Degree Grid',
    'TDWG L3',
)

def plot_scatter(index):
    ax = fig.add_subplot(120 + index)
    ax.scatter(counts[:,index], counts[:,0], alpha=0.5)
    ax.plot(lx, ly, c="k", alpha=0.2)
    xtix = np.arange(0, 130.1, 20)
    ytix = np.arange(0, 130.1, 20)
    ax.xaxis.set_ticks(xtix)
    ax.yaxis.set_ticks(ytix)
    ax.tick_params(labelsize=8)
    ax.set_aspect(1)
    ax.set_xlim([0, 130])
    ax.set_ylim([0, 130])
    ax.set_xlabel(count_types[index] + ' Count', fontsize='large')
    ax.set_ylabel(count_types[0]     + ' Count', fontsize='large')
    #ax.set_title('Comparison of Grid Count From ' + count_types[index] + ' and ' + count_types[0], fontsize=10)
    ax.set_title(index, position = (1,-0.15))
    ax.grid(True)


for index in range(1,3):
    plot_scatter(index)

plt.show()

# add linear model
lxp = np.arange(0,130)
lyp = lxp*2.951 + 3.429


# plot TDWG vs km Grid
fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(counts[:,2], counts[:,0], alpha=0.5)
ax.plot(lx, ly, c="k", alpha=0.2)
ax.plot(lxp, lyp, c="r", alpha=0.8, linestyle=':')
xtix = np.arange(0, 130.1, 20)
ytix = np.arange(0, 130.1, 20)
ax.xaxis.set_ticks(xtix)
ax.yaxis.set_ticks(ytix)
ax.tick_params(labelsize=8)
ax.set_aspect(1)
ax.set_xlim([0, 130])
ax.set_ylim([0, 130])
ax.set_xlabel(count_types[2] + ' Count', fontsize='large')
ax.set_ylabel(count_types[0] + ' Count', fontsize='large')
ax.set_title('2', position = (1,-0.1))
ax.grid(True)
ax.text(10, 125, r'$y = 2.951x + 3.429$', fontsize=18)

plt.show()

# plot TDWG vs Degree Grid
fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(counts[:,2], counts[:,1], alpha=0.5)
ax.plot(lx, ly, c="k", alpha=0.2)
ax.plot(lxp, lyp, c="r", alpha=0.8, linestyle=':')
xtix = np.arange(0, 130.1, 20)
ytix = np.arange(0, 130.1, 20)
ax.xaxis.set_ticks(xtix)
ax.yaxis.set_ticks(ytix)
ax.tick_params(labelsize=8)
ax.set_aspect(1)
ax.set_xlim([0, 130])
ax.set_ylim([0, 130])
ax.set_xlabel(count_types[2] + ' Count', fontsize='large')
ax.set_ylabel(count_types[1] + ' Count', fontsize='large')
ax.set_title('2', position = (1,-0.1))
ax.grid(True)
ax.text(10, 125, r'$y = 2.955x + 3.148$', fontsize=18)

plt.show()
