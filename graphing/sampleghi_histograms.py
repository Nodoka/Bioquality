#!/usr/local/bin/ipython -i
"""
A scatter graph of hori vs RBS scores
"""
import numpy as np
import matplotlib.pyplot as plt

# extract rbs0910 data from csv
file_name = "../data/RBS0910_Horim.csv"
# use columns
# 0 = scode (1~39 = rbs09, 4001~4021 = rbs2010)
# 16 = spcount
# 18 = GHI40 for RBS
scode = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=0)
rbs_score = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=18)
spcount = np.genfromtxt(file_name, delimiter=',', dtype=None, skip_header=1, usecols=16)

# distinguish rbs09 and rbs10
rbs09_score = rbs_score[scode < 40 ]
rbs10_score = rbs_score[scode > 4000]

# extract utaki data
utaki_file = "../data/Utakigaz_Horim.csv"
# use columns
# 0 = gazcode (32 - 517)
# 9 = spcount as 'taxa'
# 10 = GHI40 for Utakigaz as 'validscore'
gazcode = np.genfromtxt(utaki_file, delimiter=',', dtype=None, skip_header=1, usecols=0)
utaki_score = np.genfromtxt(utaki_file, delimiter=',', dtype=None, skip_header=1, usecols=10)
utakispcount = np.genfromtxt(utaki_file, delimiter=',', dtype=None, skip_header=1, usecols=9)

# filter valid score
utaki_vscore = utaki_score[utakispcount >= 40] 

# extract horikawa data
hori_file = "../data/hori_plot_validscoreR.csv"
# use columns: "sampname" "GHI"      "spno"    
hori_score = np.genfromtxt(hori_file, delimiter=',', dtype=None, skip_header=1, usecols=1)


# box plots
fig = plt.figure()
ax = fig.add_subplot(111)
bp = ax.boxplot([rbs09_score,rbs10_score,utaki_vscore,hori_score],
                vert=0,
                sym='k+',
                patch_artist=True,
                positions=[1,2,3,4],
                notch=1,
                bootstrap=5000)

# configure axes
#ax.set_xlim(0, 10000)
ax.yaxis.set_ticklabels(["RBS09","RBS10","Utaki","Horikawa"], size='large')
ax.set_xlabel('Sample Plot GHI', size='x-large')
ax.set_ylabel('Sample Type', size='x-large')
# ax.set_ylim(-0.2, 1.4)
# plt.setp(bp['whiskers'], color='k',  linestyle='-' )
# plt.setp(bp['fliers'], markersize=3.0)
plt.show()

# histograms
histfig = plt.figure()
histaxes = histfig.add_subplot(111)
n, bins, patches = histaxes.hist([rbs09_score,rbs10_score,utaki_vscore,hori_score],
                              bins=50,
                              normed=True,
                              color=['m', 'r', 'c', '#99cc00'])
histaxes.set_xlabel('Sample Plot GHI', size='x-large')
histaxes.set_ylabel('Normalised Frequency', size='x-large')
plt.show()
