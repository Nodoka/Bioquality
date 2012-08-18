from random import random
import matplotlib.pyplot as plt

def random_score():
    x = random()
    if x < 0.6: return 0
    if x < 0.8: return 3
    if x < 0.9: return 9
    return 27 

def random_scores(m):
    return [random_score() for ignore_me in range(m)]
    
def mean(x):
    return float(sum(x))/len(x)

def random_means(group_size,number_of_groups):
    return [mean(random_scores(group_size)) for i in range(number_of_groups)]


plt.hist(random_means(500,10000), bins=50)
plt.show()

