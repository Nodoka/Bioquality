#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs foj raw scores,
with bubble size inversely proportional to
total number of foj species in prefecture.
"""
import numpy as np
import matplotlib.pyplot as plt

# load a numpy record array from scores.csv
scores = np.genfromtxt("../data/testprefscores.csv", delimiter=',', dtype=None, names=True)

#spnos = np.genfromtxt("../data/FOJHori_spnos.csv", delimiter=',', dtype=None, names=True)

# check that the prefecture labels are the same and in the same order
#scores_prefnames = [row[0] for row in scores]
#spnos_prefnames  = [row[0] for row in spnos]
#assert scores_prefnames == spnos_prefnames, "scores and spnos have different prefnames"


# extract scores and spnos
foj_scores  = np.array( map(lambda row: row[1], scores) )
hori_scores = np.array( map(lambda row: row[2], scores) )
hmean_scores = np.array( map(lambda row: row[3], scores) )
hmax_scores  = np.array( map(lambda row: row[4], scores) )


# plot 2 graphs
def make_axes_pretty(ax):
    # plt.axis('equal')
    #xtix = np.arange(0, 1200.1, 100)
    #ytix = np.arange(0, 500.1, 100)
    #ax.xaxis.set_ticks(xtix)
    #ax.yaxis.set_ticks(ytix)
    ax.set_aspect(1)
    ax.set_xlim([0, 300])
    ax.set_ylim([0, 300])
    ax.set_xlabel('Holistic Hori score', fontsize=18)
    #ax.set_ylabel('Cell-based Hori score', fontsize=18)
    ax.grid(True)

fig = plt.figure()
fig.suptitle('Comparison of GHI Scores from 2 methods', fontsize=22)
ax1 = fig.add_subplot(211)
# sizes are constant times the mean times one over the species number
#foj_sizes  = 100 * sum(foj_spnos)  / (foj_spnos  * len(foj_spnos) )
#hori_sizes = 100 * sum(hori_spnos) / (hori_spnos * len(hori_spnos))
ax1.scatter(hori_scores, hmean_scores, alpha=0.5)
ax1.set_ylabel('Cell-based Mean Hori Score', fontsize=18)
#ax1.set_title('Mean Hori scores vs Holistic Hori scores', fontsize=22)
make_axes_pretty(ax1)

ax2 = fig.add_subplot(212)
ax2.scatter(hori_scores, hmax_scores, alpha=0.5)
ax2.set_ylabel('Cell-based Maximum Hori Score', fontsize=18)
#ax2.set_title('Max Hori scores vs Holistic Hori scores', fontsize=22)
make_axes_pretty(ax2)

plt.show()
