#!/usr/local/bin/ipython -i
"""
Scatter graphs of GHI and other BD measures using Horikawa data.
"""
import numpy as np
import matplotlib.pyplot as plt

# load a numpy record array from horicell_BDmeasures.csv
# column headings:
# "sampname","GHI","spno","sum_we","cwe","endemino","propend"
GHI = np.genfromtxt("../data/horicell_BDmeasures.csv", delimiter=',', dtype=None, skip_header=1, usecols=1)
spno = np.genfromtxt("../data/horicell_BDmeasures.csv", delimiter=',', dtype=None, skip_header=1, usecols=2)
cwe = np.genfromtxt("../data/horicell_BDmeasures.csv", delimiter=',', dtype=None, skip_header=1, usecols=4)
endemics = np.genfromtxt("../data/horicell_BDmeasures.csv", delimiter=',', dtype=None, skip_header=1, usecols=5)
propend = np.genfromtxt("../data/horicell_BDmeasures.csv", delimiter=',', dtype=None, skip_header=1, usecols=6)

# add y = x line
#lx = np.arange(0,300)
#ly = np.arange(0,300)

# make 2 graphs: GHI vs spno, GHI vs endemics
def make_axes_pretty(ax):
    #ax.plot(lx, ly, c="k", alpha=0.2)
    xtix = np.arange(0, 300.1, 50)
    #ytix = np.arange(0, 300.1, 50)
    ax.xaxis.set_ticks(xtix)
    #ax.yaxis.set_ticks(ytix)
    #ax.tick_params(labelsize=8)
    #ax.set_aspect(1)
    ax.set_xlim([0, 300])
    #ax.set_ylim([0, 300])
    ax.set_xlabel('GHI', fontsize='large')
    ax.grid(True)

# plot GHI vs spno
fig = plt.figure()
fig.suptitle('Comparison of GHI with Biodiversity Measures', fontsize=20)
ax1 = fig.add_subplot(131)
ax1.scatter(GHI, spno, color='c', alpha=0.5, s=4)
ax1.axhline(y=40, color='b', alpha=0.5, linestyle='--')
ytix1 = np.arange(0, 300.1, 50)
ax1.yaxis.set_ticks(ytix1)
ax1.set_ylim([0, 300])
ax1.set_aspect(1)
ax1.set_ylabel('Number of Species', fontsize='large')
ax1.set_title('(1)', position = (1,-0.15))
make_axes_pretty(ax1)

ax2 = fig.add_subplot(132)
ax2.scatter(GHI, endemics, color='m', alpha=0.5, s=4)
ytix2 = np.arange(0, 70.1, 10)
ax2.yaxis.set_ticks(ytix2)
ax2.set_ylim([0, 70])
ax2.set_aspect(4.3)
ax2.set_ylabel('Number of Endemic Species', fontsize='large')
ax2.set_title('(2)', position = (1,-0.15))
make_axes_pretty(ax2)

ax3 = fig.add_subplot(133)
ax3.scatter(GHI, cwe, color='r', alpha=0.5, s=4)
ytix3 = np.arange(0, 6.1, 1)
ax3.yaxis.set_ticks(ytix3)
ax3.set_ylim([0, 6])
ax3.set_aspect(50)
ax3.set_ylabel('Corrected Weighted Endemism (%)', fontsize='large')
ax3.set_title('(3)', position = (1,-0.15))
make_axes_pretty(ax3)


plt.show()
