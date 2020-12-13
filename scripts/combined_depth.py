import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# load all of the data files
male_1 = pd.read_csv('../depth_data/male-1_depth100000100000.csv', index_col=None)
male_2 = pd.read_csv('../depth_data/male-2_depth100000100000.csv', index_col=None)
female_1 = pd.read_csv('../depth_data/female-1_depth100000100000.csv', index_col=None)
female_2 = pd.read_csv('../depth_data/female-2_depth100000100000.csv', index_col=None)

# pull out the sites and avg the sexes together
males = pd.merge(male_1, male_2, on='site')
males['male_mean'] = males[['mean_x', 'mean_y']].mean(axis=1)
males['male_median'] = males[['median_x', 'median_y']].mean(axis=1)
males = males[['site', 'male_mean', 'male_median']]

females = pd.merge(female_1, female_2, on='site')
females['female_mean'] = females[['mean_x', 'mean_y']].mean(axis=1)
females['female_median'] = females[['median_x', 'median_y']].mean(axis=1)
females = females[['site', 'female_mean', 'female_median']]

# get the male to female ratio of read depths
ratio = pd.merge(males, females, on='site')
ratio['mean'] = ratio['male_mean'] / ratio['female_mean']
ratio['median'] = ratio['male_median'] / ratio['female_median']
ratio = ratio[['site', 'mean', 'median']]

ratio.to_csv('../depth_data/ratio.csv')