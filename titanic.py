# Importing essential libraries
import numpy as np # Math lib
import matplotlib.pyplot as plt # Plot lib
import pandas as pd # Manage Data lib

# Importing dataset
dataset = pd.read_csv('train.csv')
cols = list(dataset.columns.values)
cols.pop(cols.index('Survived'))
cols = cols + ['Survived']
dataset = dataset[cols]
