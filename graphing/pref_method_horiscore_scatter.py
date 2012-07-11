#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs foj raw scores,
with bubble size inversely proportional to
total number of foj species in prefecture.
CHECK max score (lim = 400?)
"""
import numpy as np
import matplotlib.pyplot as plt

# load a numpy record array from scores.csv
scores = np.genfromtxt("../data/prefscores_calc_methods.csv", delimiter=',', dtype=None, names=True)
# uncomment to use uniq method
# scores = np.genfromtxt("../data/prefscores_calc_uniqmethods.csv", delimiter=',', dtype=None, names=True)
# uncomment to use excl method
# scores = np.genfromtxt("../data/prefscores_calc_exclmethods.csv", delimiter=',', dtype=None, names=True)

# extract scores and spnos
foj_scores   = np.array( map(lambda row: row[1], scores) )
hori_scores  = np.array( map(lambda row: row[2], scores) )
foj_spnos    = np.array( map(lambda row: row[3], scores) )
hori_spnos   = np.array( map(lambda row: row[4], scores) )
hmean_scores = np.array( map(lambda row: row[5], scores) )
hmean_spnos  = np.array( map(lambda row: row[6], scores) )
hmax_scores  = np.array( map(lambda row: row[7], scores) )
hmax_spnos   = np.array( map(lambda row: row[8], scores) )

# flag outliers in red
## in compasion with hori_spnos?????
mean_colours  = map(lambda spno: 'r' if spno < 100 else 'b', hmean_spnos)
max_colours = map(lambda spno: 'r' if spno < 100  else 'b', hmax_spnos)

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
    ax.set_aspect(1)
    ax.set_xlim([0, 300])
    ax.set_ylim([0, 300])
    ax.plot(lx, ly, c='k', alpha=0.2)
    ax.set_xlabel('Holistic Hori score', fontsize=16)
    #ax.set_ylabel('Cell-based Hori score', fontsize=18)
    ax.grid(True)

fig = plt.figure()
#fig.suptitle('Comparison of GHI Scores from 2 methods', fontsize=22)
fig.suptitle('(1) Border Repeat', fontsize=20)
#fig.suptitle('(2) Border Unique', fontsize=20)
#fig.suptitle('(3) Border Exclude', fontsize=20)
ax1 = fig.add_subplot(211)
# sizes are constant times the mean times one over the species number
mean_sizes  = 20 * sum(hmean_spnos)  / (hmean_spnos  * len(hmean_spnos) )
max_sizes   = 20 * sum(hmax_spnos) / (hmax_spnos * len(hmax_spnos))
ax1.scatter(hori_scores, hmean_scores, s=mean_sizes, c=mean_colours, alpha=0.5)
ax1.set_ylabel('Cell-based Average Hori Score', fontsize=16)
#ax1.set_title('Mean Hori scores vs Holistic Hori scores', fontsize=22)
make_axes_pretty(ax1)

ax2 = fig.add_subplot(212)
ax2.scatter(hori_scores, hmax_scores, s=max_sizes, c=max_colours, alpha=0.5)
ax2.set_ylabel('Cell-based Maximum Hori Score', fontsize=16)
#ax2.set_title('Max Hori scores vs Holistic Hori scores', fontsize=22)
make_axes_pretty(ax2)

plt.show()
