#!/usr/bin/env python
# a bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

# extract column of the dataset
data = np.genfromtxt('../data/sens_scores_difftable.csv',delimiter=',',dtype=None)
star_category = data[0,1:6]
diffmeans     = data[1,1:6]
diffstd       = data[2,1:6]

# or type in the data
N = 5
diffmeans = (8.2784, 15.6807, 0.9163, -40.3757, -18.6863)
diffstd =   (10.5863, 10.0328, 9.9718, 35.6703, 28.8641)

ind = np.arange(5)  # the x locations for the groups
width = 0.35       # the width of the bars

fig = plt.figure()
ax = fig.add_subplot(111)
p1 = ax.bar(ind, diffmeans, width, color='r', yerr=diffstd)

# add some
ax.set_xlabel('Star Classification Method')
ax.set_ylabel('Difference in Mean GHI Scores Compared to the Default')
ax.set_title('Difference in Mean GHI Scores between 5 classification methods and the Default')
ax.set_xticks(ind+width)
ax.set_xticklabels( ('Geo', 'Geo-up', 'Geo-down', 'Infra-auto', 'Infra-selective') )

plt.show()
-------------------------
#!/usr/bin/env python
# a bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt

# extract column of the dataset
diffdata = np.genfromtxt('../data/sens_scores_difftable.csv',delimiter=',',dtype=None)

# plot data
def plot_bar_with_error(results):
    fig = plt.figure()
    ax = fig.add_subplot(111)
    # extract each column into a variable
    diffmeans = results[1,1:6]
    diffstd = results[2,1:6]
    ind = np.arange(5)
    width = 0.35
    p1 = ax.bar(ind, diffmeans, width, color='r', yerr=diffstd)
    plt.xlabel('Star Classification Method')
    plt.legend( (p1[0], p1[1], p1[2], p1[3], p1[4]), label)
    plt.xticks(ind+width/2., ('Default','GEO','GEO-Up','GEO-Down','INFRA-Auto','INFRA-Selective') )

plot_bar_with_error(diffdata)
plt.ylabel('Difference in Mean GHI Scores Compared to the Default')
plt.title('Difference in Mean GHI Scores between 5 Classification Methods and the Default')

plt.show()
