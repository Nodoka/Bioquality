#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs foj raw scores,
with bubble size inversely proportional to
total number of foj species in prefecture.
"""
import numpy as np
import matplotlib.pyplot as plt

file_name ="../data/horicell_BDmeasures.csv"

# extract data using columns
cell_scores = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=1)
cell_spnos = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=2)
sum_we = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=3)
cwe = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=4)

# plot 3 graphs
def make_axes_pretty(ax):
    # plt.axis('equal')
    #xtix = np.arange(0, 1200.1, 100)
    #ytix = np.arange(0, 500.1, 100)
    #ax.xaxis.set_ticks(xtix)
    #ax.yaxis.set_ticks(ytix)
    #ax.set_aspect(1)
    #ax.set_xlim([0, 300])
    #ax.set_ylim([0, 300])
    ax.set_xlabel('Horikawa geoquadrat GHI score', fontsize=18)
    #ax.set_ylabel('Cell-based Hori score', fontsize=18)
    ax.grid(True)

fig = plt.figure()
fig.suptitle('Comparison of biodiversity measures', fontsize=22)
ax1 = fig.add_subplot(131)
# sizes are constant times the mean times one over the species number
#mean_sizes  = 20 * sum(hmean_spnos)  / (hmean_spnos  * len(hmean_spnos) )
#max_sizes   = 20 * sum(hmax_spnos) / (hmax_spnos * len(hmax_spnos))
ax1.scatter(cell_scores, cell_spnos, alpha=0.5)
ax1.set_ylabel('Number of Species', fontsize=18)
make_axes_pretty(ax1)

ax2 = fig.add_subplot(132)
ax2.scatter(cell_scores, sum_we, alpha=0.5)
ax2.set_ylabel('Weighted Endemism (%)', fontsize=18)
make_axes_pretty(ax2)

ax3 = fig.add_subplot(133)
ax3.scatter(cell_scores, cwe, alpha=0.5)
ax3.set_ylabel('Corrected Weighted Endemism (%)', fontsize=18)
make_axes_pretty(ax3)

plt.show()
