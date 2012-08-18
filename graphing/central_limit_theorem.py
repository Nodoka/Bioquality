#!/usr/local/bin/ipython -i
"""
Frequency distribution of random samples (variable size), collected 
random times (variable number of groups), for specified score.
"""
from random import random
import matplotlib.pyplot as plt

# generate 4 scores for specified probability (species rarity weight)
def random_score():
    x = random()
    if x < 0.6: return 0
    if x < 0.8: return 3
    if x < 0.9: return 9
    return 27 

# generate scores for m times (number of species per plot)
def random_scores(m):
    return [random_score() for j in range(m)]

# generic mean calculation function
# used to calculate mean score for sample m
def mean(x):
    return float(sum(x))/len(x)

# generate means of random scores by defining: 
# group size = sample size of species pool
# number of group = number of sampling
def random_means(group_size,number_of_groups):
    return [mean(random_scores(group_size)) for i in range(number_of_groups)]

# generate histogram
plt.hist(random_means(500,10000), bins=50)
plt.show()

