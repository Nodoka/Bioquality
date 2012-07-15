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
rept = np.genfromtxt("../data/prefscores_calc_methods.csv", delimiter=',', dtype=None, names=True)
uniq = np.genfromtxt("../data/prefscores_calc_uniqmethods.csv", delimiter=',', dtype=None, names=True)
excl = np.genfromtxt("../data/prefscores_calc_exclmethods.csv", delimiter=',', dtype=None, names=True)

# extract scores and spnos
foj_scores   = np.array( map(lambda row: row[1], rept) )
foj_spnos    = np.array( map(lambda row: row[3], rept) )
rept_hori_scores  = np.array( map(lambda row: row[2], rept) )
rept_hori_spnos   = np.array( map(lambda row: row[4], rept) )
rept_mean_scores  = np.array( map(lambda row: row[5], rept) )
rept_mean_spnos   = np.array( map(lambda row: row[6], rept) )
rept_max_scores   = np.array( map(lambda row: row[7], rept) )
rept_max_spnos    = np.array( map(lambda row: row[8], rept) )

uniq_hori_scores  = np.array( map(lambda row: row[2], uniq) )
uniq_hori_spnos   = np.array( map(lambda row: row[4], uniq) )
uniq_mean_scores  = np.array( map(lambda row: row[5], uniq) )
uniq_mean_spnos   = np.array( map(lambda row: row[6], uniq) )
uniq_max_scores   = np.array( map(lambda row: row[7], uniq) )
uniq_max_spnos    = np.array( map(lambda row: row[8], uniq) )

# ALTERNATIVE: load column data using file 
#rept_file = "../data/prefscores_calc_methods.csv"
#uniq_file = "../data/prefscores_calc_uniqmethods.csv"
#excl_file = "../data/prefscores_calc_exclmethods.csv"
# extract columns (examples)
#rept_preflist = np.genfromtxt(rept_file, delimiter=',', dtype=None, skip_header=1, usecols=0)
#foj_scores   = np.genfromtxt(rept_file, delimiter=',', dtype=None, skip_header=1, usecols=1)
#rept_hori_scores  = np.genfromtxt(rept_file, delimiter=',', dtype=None, skip_header=1, usecols=2)

# sizes are difference between x_spnos and y_spnos
#hols_sizes  = np.abs(((rept_hori_spnos - uniq_hori_spnos + 1)*0.5).astype(int))
#mean_sizes  = np.abs(((rept_mean_spnos - uniq_mean_spnos + 1)*0.5).astype(int))
#max_sizes   = np.abs(((rept_max_spnos  - uniq_max_spnos  + 1)*0.5).astype(int))

# sizes are constant times the mean times one over the species number
hols_sizes = ((uniq_hori_spnos)* len(rept_hori_spnos)*20/sum(rept_hori_spnos)).astype(int)
mean_sizes = ((uniq_mean_spnos)* len(rept_mean_spnos)*20/sum(rept_mean_spnos)).astype(int)
max_sizes = ((uniq_max_spnos)* len(rept_max_spnos)*20/sum(rept_max_spnos)).astype(int)

# add y = x line
lx = np.arange(0,300)
ly = np.arange(0,300)

# plot 3 graphs
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
    #ax.set_xlabel('Holistic Hori score', fontsize=16)
    #ax.set_ylabel('Cell-based Hori score', fontsize=18)
    ax.grid(True)

# graphs for repeat vs unique
fig = plt.figure()
fig.suptitle('Comparison of GHI Scores between 2 border treatments', fontsize=18)
ax1 = fig.add_subplot(131)
ax1.scatter(rept_hori_scores, uniq_hori_scores, s=hols_sizes, marker='o', color='m', alpha=0.5)
ax1.set_xlabel('Repeat Holistic Hori Score', fontsize=12)
ax1.set_ylabel('Unique Holistic Hori Score', fontsize=12)
make_axes_pretty(ax1)

ax2 = fig.add_subplot(132)
ax2.scatter(rept_mean_scores, uniq_mean_scores, s=mean_sizes, marker='d', color='c', alpha=0.5)
ax2.set_xlabel('Repeat Average Hori Score', fontsize=12)
ax2.set_ylabel('Unique Average Hori Score', fontsize=12)
make_axes_pretty(ax2)

ax3 = fig.add_subplot(133)
ax3.scatter(rept_max_scores, uniq_max_scores, s=max_sizes, marker='^', color='r', alpha=0.5)
ax3.set_xlabel('Repeat Maximum Hori Score', fontsize=12)
ax3.set_ylabel('Unique Maximum Hori Score', fontsize=12)
make_axes_pretty(ax3)

plt.show()


# extract exlc data
excl_hori_scores  = np.array( map(lambda row: row[2], excl) )
excl_hori_spnos   = np.array( map(lambda row: row[4], excl) )
excl_mean_scores  = np.array( map(lambda row: row[5], excl) )
excl_mean_spnos   = np.array( map(lambda row: row[6], excl) )
excl_max_scores   = np.array( map(lambda row: row[7], excl) )
excl_max_spnos    = np.array( map(lambda row: row[8], excl) )

# modify repeat data to match with exclude
# delete Tokyo (12th) row from the repeat array
rept = np.delete(rept, 12, 0)

# re-extract arrays
rept_hori_scores  = np.array( map(lambda row: row[2], rept) )
rept_hori_spnos   = np.array( map(lambda row: row[4], rept) )
rept_mean_scores  = np.array( map(lambda row: row[5], rept) )
rept_mean_spnos   = np.array( map(lambda row: row[6], rept) )
rept_max_scores   = np.array( map(lambda row: row[7], rept) )
rept_max_spnos    = np.array( map(lambda row: row[8], rept) )


# sizes are difference between x_spnos and y_spnos
#hols_sizes  = np.abs(((rept_hori_spnos - excl_hori_spnos + 1)*0.5).astype(int))
#mean_sizes  = np.abs(((rept_mean_spnos - excl_mean_spnos + 1)*0.5).astype(int))
#max_sizes   = np.abs(((rept_max_spnos  - excl_max_spnos  + 1 )*0.5).astype(int))

# sizes are constant times the mean times one over the species number
hols_sizes = ((excl_hori_spnos)* len(rept_hori_spnos)*20/sum(rept_hori_spnos)).astype(int)
mean_sizes = ((excl_mean_spnos)* len(rept_mean_spnos)*20/sum(rept_mean_spnos)).astype(int)
max_sizes = ((excl_max_spnos)* len(rept_max_spnos)*20/sum(rept_max_spnos)).astype(int)

# plot graphs for modified repeat vs exclude
fig = plt.figure()
fig.suptitle('Comparison of GHI Scores between 2 border treatments', fontsize=18)
ax1 = fig.add_subplot(131)
ax1.scatter(rept_hori_scores, excl_hori_scores, s=hols_sizes, marker='o', color='m', alpha=0.5)
ax1.set_xlabel('Repeat Holistic Hori Score', fontsize=12)
ax1.set_ylabel('Exclude Holistic Hori Score', fontsize=12)
make_axes_pretty(ax1)

ax2 = fig.add_subplot(132)
ax2.scatter(rept_mean_scores, excl_mean_scores, s=mean_sizes, marker='d', color='c', alpha=0.5)
ax2.set_xlabel('Repeat Average Hori Score', fontsize=12)
ax2.set_ylabel('Exclude Average Hori Score', fontsize=12)
make_axes_pretty(ax2)

ax3 = fig.add_subplot(133)
ax3.scatter(rept_max_scores, excl_max_scores, s=max_sizes, marker='^', color='r', alpha=0.5)
ax3.set_xlabel('Repeat Maximum Hori Score', fontsize=12)
ax3.set_ylabel('Exclude Maximum Hori Score', fontsize=12)
make_axes_pretty(ax3)

plt.show()


# modify unique data to match with exclude
# delete Tokyo (12th) row from the unique array
uniq = np.delete (uniq, 12, 0)

# re-extract arrays
uniq_hori_scores  = np.array( map(lambda row: row[2], uniq) )
uniq_hori_spnos   = np.array( map(lambda row: row[4], uniq) )
uniq_mean_scores  = np.array( map(lambda row: row[5], uniq) )
uniq_mean_spnos   = np.array( map(lambda row: row[6], uniq) )
uniq_max_scores   = np.array( map(lambda row: row[7], uniq) )
uniq_max_spnos    = np.array( map(lambda row: row[8], uniq) )

# sizes are difference between x_spnos and y_spnos
#hols_sizes  = np.abs(((uniq_hori_spnos - excl_hori_spnos + 1)*0.5).astype(int))
#mean_sizes  = np.abs(((uniq_mean_spnos - excl_mean_spnos + 1)*0.5).astype(int))
#max_sizes   = np.abs(((uniq_max_spnos  - excl_max_spnos  + 1)*0.5).astype(int))

# sizes are constant times the mean times one over the species number
hols_sizes = ((excl_hori_spnos)* len(uniq_hori_spnos)*20/sum(uniq_hori_spnos)).astype(int)
mean_sizes = ((excl_mean_spnos)* len(uniq_mean_spnos)*20/sum(uniq_mean_spnos)).astype(int)
max_sizes = ((excl_max_spnos)* len(uniq_max_spnos)*20/sum(uniq_max_spnos)).astype(int)

# plot graphs for modified unique vs exclude
fig = plt.figure()
fig.suptitle('Comparison of GHI Scores between 2 border treatments', fontsize=18)
ax1 = fig.add_subplot(131)
ax1.scatter(uniq_hori_scores, excl_hori_scores, s=hols_sizes, marker='o', color='m', alpha=0.5)
ax1.set_xlabel('Unique Holistic Hori Score', fontsize=12)
ax1.set_ylabel('Exclude Holistic Hori Score', fontsize=12)
make_axes_pretty(ax1)

ax2 = fig.add_subplot(132)
ax2.scatter(uniq_mean_scores, excl_mean_scores, s=mean_sizes, marker='d', color='c', alpha=0.5)
ax2.set_xlabel('Unique Average Hori Score', fontsize=12)
ax2.set_ylabel('Exclude Average Hori Score', fontsize=12)
make_axes_pretty(ax2)

ax3 = fig.add_subplot(133)
ax3.scatter(uniq_max_scores, excl_max_scores, s=max_sizes, marker='^', color='r', alpha=0.5)
ax3.set_xlabel('Unique Maximum Hori Score', fontsize=12)
ax3.set_ylabel('Exclude Maximum Hori Score', fontsize=12)
make_axes_pretty(ax3)

plt.show()

# .astype(float)???
# integer(hols - uniq +1)*2??
