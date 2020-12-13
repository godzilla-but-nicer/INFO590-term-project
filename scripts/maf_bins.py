import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import sys

print('starting')
# command line args
depth_file = sys.argv[1]
# name of the sample
name = depth_file.split('/')[-1].split('.')[0]
window_size = int(sys.argv[2])
step_size = int(sys.argv[3])

# read the samtools depth output as df
depth = pd.read_csv(depth_file, sep='\t', header=None)
print('data loaded')

# plot distribution of the coverages
unique, counts = np.unique(depth['coverage'].values, return_counts=True)

fig, ax = plt.subplots()
ax.bar(unique, counts / np.sum(counts))
ax.set_xlabel('Depth')
ax.set_ylabel('Frequency')

plt.savefig('plots/' + name + '_coverage_dist.png')
print('histogram plot saved!')

# plot sliding window mean coverage
coverages = depth['coverage'].values
steps = np.floor(coverages.shape[0] / step_size)
mean_covs = np.zeros(windows)
median_covs = np.zeros(windows)

for s in range(steps):
    mean_covs[a] = np.mean(coverages[window_size * s:window_side*s + window_size])
    median_covs[a] = np.median(coverages[window_size * s:window_side*s + window_size])

fig, ax = plt.subplots()
ax.plot(range(windows), mean_covs)
ax.set_xlabel('Site')
ax.set_ylabel('Depth')
ax.set_title('Forward-looking mean [{0} bases, {1} step]'.format(window_size))

plt.savefig('plots/' + name + '_mean_median_coverage.png')
print('done')

# write out calculated values
window_starts = [s*window_size for s in range(steps)]
out_name = 'depth_files' + name + str(window_size) + str(step_size) + '.csv'
df_out = pd.DataFrame({'site': window_starts, 'mean': mean_cov, 'median': median_cov})
df_out.to_csv(out_name, index=False)