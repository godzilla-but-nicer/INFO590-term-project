import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import sys

# load a datafile
smoothing = int(sys.argv[2])
data_file = sys.argv[1]
df = pd.read_csv(data_file, index_col=None)

# calculate ranges for the y axis
low_percentile = 5
high_percentile = 100 - low_percentile
mean_low = np.percentile(df['mean'].values, low_percentile)
mean_high = np.percentile(df['mean'].values, high_percentile)

median_low = np.percentile(df['median'].values, low_percentile)
median_high = np.percentile(df['median'].values, high_percentile)

# calculate the smoothed lines
# we're going to reject outliers for this part and only keep data that falls
# below the 'high' percentile
mean_vals = df['mean'].values
median_vals = df['median'].values
mean_vals[mean_vals > mean_high] = mean_high
median_vals[median_vals > median_high] = median_high

smooth_radius = int(smoothing / 2)
smoothed_mean = np.zeros(df.shape[0])
smoothed_median = np.zeros(df.shape[0])

for w in range(smooth_radius, df.shape[0] - smooth_radius):
    smoothed_mean[w] = np.mean(mean_vals[w - smooth_radius : w + smooth_radius])
    smoothed_median[w] = np.mean(median_vals[w - smooth_radius : w + smooth_radius])


fig, ax = plt.subplots(nrows=2, sharex=True)
ax[0].plot(df['site'], df['mean'], c='grey', alpha=0.5)
ax[0].plot(df['site'][smooth_radius:-smooth_radius], smoothed_mean[smooth_radius:-smooth_radius], c='C0')
ax[0].set_ylabel('Mean depth')
ax[0].set_ylim((mean_low, mean_high))

ax[1].plot(df['site'], df['median'], c='grey', alpha=0.5)
ax[1].plot(df['site'][smooth_radius:-smooth_radius], smoothed_median[smooth_radius:-smooth_radius], c='C1')
ax[1].set_ylabel('Median depth')
ax[1].set_ylim((median_low, median_high))
ax[1].set_xlabel('Site')
# output name
name = data_file.split('/')[-1].split('.')[0]
plt.savefig('../plots/fancy_depth/' + name + '_depth_split.png')
