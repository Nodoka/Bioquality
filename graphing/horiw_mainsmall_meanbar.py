#!/usr/bin/env python
# a bar plot with errorbars
# check work_classmethod_meandiffbar.py for def version
import numpy as np
import matplotlib.pyplot as plt

# specifly the file
mainisl_data = "../data/horimain_areamean.csv"
smallisl_data = "../data/horismall_areamean.csv"

# extract relevant columns
# columns:
# mean = [1:4] in order of BK, GD, BU, GN
# sd   = [5:8] in order of BK, GD, BU, GN
main_means = np.genfromtxt(mainisl_data, delimiter=',', dtype=None, skip_header=1, usecols=range(1,5))
main_sds = np.genfromtxt(mainisl_data, delimiter=',', dtype=None, skip_header=1, usecols=range(5,9))
small_means = np.genfromtxt(smallisl_data, delimiter=',', dtype=None, skip_header=1, usecols=range(1,5))
small_sds = np.genfromtxt(smallisl_data, delimiter=',', dtype=None, skip_header=1, usecols=range(5,9))

main_logmeans = np.log10(main_means)
main_logsds = np.log10(main_sds)
small_logmeans = np.log10(small_means)
small_logsds = np.log10(small_sds)

ind = np.arange(4)  # the x locations for the groups
width = 0.35       # the width of the bars

resolutions = (
    '0.1 lat. by 0.15 long. geoquadrat',
    '0.2 lat by 0.3 long. grid',
    '1 lat. by 1 long. grid',
)

fig = plt.figure()
fig.suptitle('Difference in Mean within-Japan Range Size for Main vs. Small Islands Species',fontsize=12)
#fig.figtext(0,0,'Star Category')
#fig.ylabel('Mean Range Size at')
def plot_meanbar(index):
    ax = fig.add_subplot(311+index)
    p1 = ax.bar(ind, main_logmeans[index,], width, color='r', yerr=main_logsds[index,])
    p2 = ax.bar(ind+width, small_logmeans[index,], width, color='y', yerr=small_logsds[index,])
    ax.set_ylim(0,12)
    ax.set_xlabel('Star Category')
    ax.set_ylabel('Mean Range size at ' + resolutions[index],fontsize=8)
    ax.set_xticks(ind+width)
    ax.set_xticklabels( ('Black', 'Gold', 'Blue', 'Green') )

for index in range(0,3):
    plot_meanbar(index)

plt.show()
