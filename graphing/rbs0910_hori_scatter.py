#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs RBS scores
"""
import numpy as np
import matplotlib.pyplot as plt

# extract data from csv
file_name = "../data/RBS0910_Horim.csv"
# use columns
# 0 = scode (1~39 = rbs09, 4001~4021 = rbs2010)
# 16 = spcount
# 18 = GHI40 for RBS
# 31 = XMGHI40
scode = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=0)
rbs_score = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=18)
hori_score = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=31)
spcount = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=16)

# add y = x line
#lx = np.arange(0,460)
#ly = np.arange(0,460)

# define colours
colours = map(lambda plot_type: 'm' if plot_type < 40 else 'r', scode)

# sizes are constant times the mean times one over the species number
#sizes   = 20 * sum(spcount) / (spcount * len(spcount))
sizes = spcount

# plot scatter graph
fig = plt.figure()
fig.suptitle('Comparison of GHI between RBS samples and Horikawa maps', fontsize=20)
ax = fig.add_subplot(111)
ax.scatter(hori_score, rbs_score, s= sizes, color=colours, alpha=0.5)
#ax.plot(lx, ly, c='k', alpha=0.2) 
ax.set_aspect(1) 
ax.set_xlim([0, 460])
ax.set_ylim([0, 460])
ax.set_xlabel('Horikawa score', fontsize=16)
ax.set_ylabel('RBS 2009 & 2010 score', fontsize=16)
ax.grid(True)

plt.show()
