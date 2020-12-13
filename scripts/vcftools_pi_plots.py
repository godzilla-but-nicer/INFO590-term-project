import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import sys

# load a datafile, handle some command line args
smoothing = int(sys.argv[2]) # window size for smoothing
data_file = sys.argv[1]
name = data_file.split('/')[-1].split('.')[0] # used in output
df = pd.read_csv(data_file, index_col=None, sep='\t')

# first let's just get a distribution
pi_arr = df['PI'].values

# draw and save the plot
fig, ax = plt.subplots()
ax.hist(pi_arr, density=True, bins=30)
ax.set_xlabel(r'$\pi$')
ax.set_ylabel('Frequency')
plt.savefig('../plots/pi_plots/' + name + '_pi_dist.png')

# calculate ranges for the y axis
low_percentile = 1
high_percentile = 100 - low_percentile
mean_low = np.percentile(pi_arr, low_percentile)
mean_high = np.percentile(pi_arr, high_percentile)

# calculate the smoothed lines
# we're going to reject outliers for this part and only keep data that falls
# below the 'high' percentile
mean_vals = pi_arr
mean_vals[mean_vals > mean_high] = mean_high

smooth_radius = int(smoothing / 2)
smoothed_mean = np.zeros(df.shape[0])

for w in range(smooth_radius, df.shape[0] - smooth_radius):
    smoothed_mean[w] = np.mean(mean_vals[w - smooth_radius : w + smooth_radius])


fig, ax = plt.subplots()
ax.plot(df['BIN_START'] - 1, pi_arr, c='grey', alpha=0.5)
ax.plot(df['BIN_START'][smooth_radius:-smooth_radius] - 1, smoothed_mean[smooth_radius:-smooth_radius], c='C0')
ax.set_ylabel(r'Binned $\pi$')
ax.set_ylim((mean_low, mean_high))

# output name
plt.savefig('../plots/pi_plots/' + name + '_pi.png')