#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs foj raw scores,
with bubble size inversely proportional to
total number of foj species in prefecture.
"""
import numpy as np
import matplotlib.pyplot as plt

# load a numpy record array from scores.csv
scores = np.genfromtxt("../data/FOJHori_scores.csv", delimiter=',', dtype=None, names=True)
spnos = np.genfromtxt("../data/FOJHori_spnos.csv", delimiter=',', dtype=None, names=True)

# check that the prefecture labels are the same and in the same order
scores_prefnames = [row[0] for row in scores]
spnos_prefnames  = [row[0] for row in spnos]
assert scores_prefnames == spnos_prefnames, "scores and spnos have different prefnames"

# extract scores and spnos
foj_scores  = np.array( map(lambda row: row[1], scores) )
hori_scores = np.array( map(lambda row: row[2], scores) )
foj_spnos   = np.array( map(lambda row: row[1], spnos) )
hori_spnos  = np.array( map(lambda row: row[2], spnos) )

# flag outliers in red
foj_colours  = map(lambda spno: 'r' if spno < 1500 else 'b', foj_spnos)
hori_colours = map(lambda spno: 'r' if spno < 270  else 'b', hori_spnos)

# plot 2 graphs
def make_axes_pretty(ax):
    # plt.axis('equal')
    xtix = np.arange(0, 1200.1, 100)
    ytix = np.arange(0, 500.1, 100)
    ax.xaxis.set_ticks(xtix)
    ax.yaxis.set_ticks(ytix)
    ax.set_aspect(1)
    ax.set_xlim([0, 1200])
    ax.set_ylim([0, 500])
    ax.set_xlabel('Flora Of Japan score', fontsize=18)
    ax.set_ylabel('Hori score', fontsize=18)
    ax.grid(True)

fig = plt.figure()
fig.suptitle('Comparison of GHI Scores from 2 Sources', fontsize=22)
ax1 = fig.add_subplot(211)
# sizes are constant times the mean times one over the species number
foj_sizes  = 100 * sum(foj_spnos)  / (foj_spnos  * len(foj_spnos) )
hori_sizes = 100 * sum(hori_spnos) / (hori_spnos * len(hori_spnos))
ax1.scatter(foj_scores, hori_scores, s=foj_sizes, c=foj_colours, alpha=0.5)
ax1.set_title('size proportional to 1 / foj sample number', fontsize=22)
make_axes_pretty(ax1)

ax2 = fig.add_subplot(212)
ax2.scatter(foj_scores, hori_scores, s=hori_sizes, c=hori_colours, alpha=0.5)
ax2.set_title('size proportional to 1 / hori sample number', fontsize=22)
make_axes_pretty(ax2)

plt.show()
