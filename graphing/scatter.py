"""
make a scatter plot with varying color and size arguments
"""
import numpy as np
import matplotlib.pyplot as plt

# load a numpy record array from scores.csv
scores = np.genfromtxt("../data/scores.csv", delimiter=',', dtype=None, names=True)
spnos = np.array(list(np.genfromtxt("../data/spnos.csv",delimiter=',', dtype=None, names=True)[0])[1:])

prefectures = map(lambda row: row[0], scores)
hori_scores = map(lambda row: row[1], scores)
foj_scores  = map(lambda row: row[2], scores)
threshold = 1500
colours = map(lambda spno: 'r' if spno < threshold else 'b', spnos)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(foj_scores, hori_scores, s=100000.0/spnos, c=colours, alpha=0.5)

xtix = arange(0, 700.1, 100)
ytix = arange(0, 2000.1, 500)
xticks(xtix)
yticks(ytix)

ax.set_xlabel('Flora Of Japan score', fontsize=18)
ax.set_ylabel('Hori score', fontsize=18)
ax.set_title('Comparison of GHI Scores from 2 Sources', fontsize=22)
ax.grid(True)

plt.show()
