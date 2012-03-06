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

    # xtix = arange(0, 700.1, 100)
    # ytix = arange(0, 2000.1, 500)
    # xticks(xtix)
    # yticks(ytix)
    
    ax.set_xlabel(scoring_types[0]     + ' score', fontsize=18)
    ax.set_ylabel(scoring_types[index] + ' score', fontsize=18)
    ax.set_title('Comparison of GHI Scores From ' + scoring_types[0] + ' and ' + scoring_types[index], fontsize=22)
    
    ax.grid(True)


for index in range(1,6):
    plot_scatter(index)

plt.show()
