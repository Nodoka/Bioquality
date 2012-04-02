#!/usr/local/bin/ipython -i
"""
Scatter graphs of foj prefecture scores
of 5 classification methods against baseline
'star' method.
"""
import numpy as np
import matplotlib.pyplot as plt

# load a numpy record array from sensitivity_scores.csv
# column headings:
# "preflist","star_default","star_geo","star_geou","star_geod","star_infa","star_infs"
preflist = np.genfromtxt("../data/sensitivity_scores.csv", delimiter=',', dtype=None, skip_header=1, usecols=0)
scores = np.genfromtxt("../data/sensitivity_scores.csv", delimiter=',', dtype=None, skip_header=1, usecols=range(1,7))

fig = plt.figure()
scoring_types = (
    'star_default',
    'star_geo',
    'star_geou',
    'star_geod',
    'star_infa',
    'star_infs',
)

def plot_scatter(index):
    ax = fig.add_subplot(230 + index)
    ax.scatter(scores[:,0], scores[:,index], alpha=0.5)
    xtix = np.arange(0, 1750.1, 250)
    ytix = np.arange(0, 1750.1, 250)
    ax.xaxis.set_ticks(xtix)
    ax.yaxis.set_ticks(ytix)
    ax.tick_params(labelsize=8)
    ax.set_aspect(1)
    ax.set_xlim([0, 1750])
    ax.set_ylim([0, 1750])
    
    ax.set_xlabel(scoring_types[0]     + ' score', fontsize=10)
    ax.set_ylabel(scoring_types[index] + ' score', fontsize=10)
    ax.set_title('Comparison of GHI Scores From ' + scoring_types[0] + ' and ' + scoring_types[index], fontsize=10)
    
    ax.grid(True)


for index in range(1,6):
    plot_scatter(index)

plt.show()
