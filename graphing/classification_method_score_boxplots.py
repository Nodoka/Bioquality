#!/usr/local/bin/ipython -i
"""
Boxplots of foj prefecture scores
of 5 classification methods against baseline
'star' method.
See Classification_method_score_scatters.py for corresponding scatter graphs.
"""

import numpy as np
import matplotlib.pyplot as plt

# extract data from csv
file_name = "../data/sensitivity_scores_diffs.csv"

# load a numpy record array from the file
# column headings:
preflist = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=0)
scores = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=range(1,6))

scoring_types = (
    'GEO',
    'GEO-Up',
    'GEO-Down',
    'INFRA-Auto',
    'INFRA-Selective',
)

# box plots
fig = plt.figure()
ax = fig.add_subplot(111)
bp = ax.boxplot(scores,
                sym='k+',
                patch_artist=True,
                positions=[1,2,3,4,5],
                #notch=1,
                bootstrap=5000)
# configure axes
ax.set_ylim(-100, 100)
ax.xaxis.set_ticklabels(scoring_types)
# plt.setp(bp['whiskers'], color='k',  linestyle='-' )
# plt.setp(bp['fliers'], markersize=3.0)
ax.set_xlabel('Star Classification Methods', fontsize='large')
ax.set_ylabel('Differences in GHI Scores Compared to the Default', fontsize='large')
#ax.set_title('Comparison of GHI Scores From Default And 5 Classification Methods', fontsize=14)
ax.set_title('(1)', position=(1,-0.1))


plt.show()
# plt.savefig("../graphing/sensscores_boxplot.png")

