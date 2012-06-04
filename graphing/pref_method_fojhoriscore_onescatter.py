#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs foj raw scores,
al hori agglomeration method in one graph
"""
import numpy as np
import matplotlib.pyplot as plt

# load a numpy record array from scores.csv
scores = np.genfromtxt("../data/prefscores_calc_methods.csv", delimiter=',', dtype=None, names=True)
# uncomment to use uniq method
# scores = np.genfromtxt("../data/prefscores_calc_uniqmethods.csv", delimiter=',', dtype=None, names=True)

# extract scores and spnos
foj_scores   = np.array( map(lambda row: row[1], scores) )
hori_scores  = np.array( map(lambda row: row[2], scores) )
foj_spnos    = np.array( map(lambda row: row[3], scores) )
hori_spnos   = np.array( map(lambda row: row[4], scores) )
hmean_scores = np.array( map(lambda row: row[5], scores) )
hmax_scores  = np.array( map(lambda row: row[6], scores) )

# add y = x line
lx = np.arange(0,300)
ly = np.arange(0,300)

# plot 2 graphs
def make_axes_pretty(ax):
    # plt.axis('equal')
    #xtix = np.arange(0, 1200.1, 100)
    #ytix = np.arange(0, 500.1, 100)
    #ax.xaxis.set_ticks(xtix)
    #ax.yaxis.set_ticks(ytix)
    ax.plot(lx, ly, c='k', alpha=0.2)
    ax.set_aspect(1)
    ax.set_xlim([0, 300])
    ax.set_ylim([0, 300])
    ax.grid(True)

fig = plt.figure()
ax1 = fig.add_subplot(111)
ax1.scatter(foj_scores, hori_scores, marker='o', color='m', alpha=0.5)
ax1.scatter(foj_scores, hmean_scores, marker='d', color='c', alpha=0.5)
ax1.scatter(foj_scores, hmax_scores, marker='^', color='r', alpha=0.5)
ax1.set_xlabel('FOJ scores', fontsize=18)
ax1.set_ylabel('Holistic, Average, Max Horikawa Score', fontsize=18)
#ax1.set_title('Hori scores with 3 calculation methods vs FOJ scores', fontsize=22)
ax1.set_title('(1) Border Repeat', fontsize=22)
#ax1.set_title('(2) Border Unique', fontsize=22)
make_axes_pretty(ax1)

plt.show()
