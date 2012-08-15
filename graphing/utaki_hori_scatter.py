#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs Utaki gaz scores
"""
import numpy as np
import matplotlib.pyplot as plt

# extract utaki data
utaki_file = "../data/Utakigaz_Horim.csv"
# use columns
# 0 = gazcode (32 - 517) [previously 4]
# 9 = spcount as 'taxa' [11]
# 10 = GHI40 for Utakigaz as 'validscore' [22]
# 17 = XMGHI40 [37]
gazcode = np.genfromtxt(utaki_file, delimiter=',', dtype=None, skip_header=1, usecols=0)
utaki_score = np.genfromtxt(utaki_file, delimiter=',', dtype=None, skip_header=1, usecols=10)
utakihori_score = np.genfromtxt(utaki_file, delimiter=',', dtype=None, skip_header=1, usecols=17)
utakispcount = np.genfromtxt(utaki_file, delimiter=',', dtype=None, skip_header=1, usecols=9)

# add y = x line
lx = np.arange(0,500)
ly = np.arange(0,500)

# define colours
colours = map(lambda spcount: 'c' if spcount > 39 else 'w', utakispcount)

# sizes directly proportional to spcount
utaki_size = utakispcount

# plot scatter graph
fig = plt.figure()
fig.suptitle('Comparison of GHI between Utaki groves and Horikawa maps', fontsize=20)
ax = fig.add_subplot(111)
ax.plot(lx, ly, c='k', alpha=0.2) 
ax.scatter(utakihori_score, utaki_score, s=utaki_size, color = colours, marker='d', alpha=0.5)
ax.set_aspect(1) 
ax.set_xlim([0, 500])
ax.set_ylim([0, 500])
ax.set_xlabel('Horikawa score', fontsize=16)
ax.set_ylabel('Utaki grove score', fontsize=16)
ax.grid(True)

plt.show()
