import pandas as pd
import numpy as np

# Read the dataset
data = pd.read_csv("Lab Data\^BVSP.csv");

# Create a table to store the close values, differences and symbols
table = np.zeros((len(data),3),dtype=float)

# Fill the table with close values
for i in range (0, len(data)):
    table[i][0] = data['Close'][i]

# Calculate the differences
for i in range (1, len(table)):
    table[i][1] = table[i][0] - table[i-1][0]

max_val,min_val=table[1][1],table[1][1]
#print(max_val,min_val)

# Calculate min and max value
for i in range (2, len(table)):
    if table[i][1] > max_val:
        max_val = table[i][1]
    if table[i][1] < min_val:
        min_val = table[i][1]
print("max value : ",max_val,"\nmin value : ",min_val)

interval = (max_val - min_val) / 12
print("interval : ",interval)

# Calculate the symbols
for i in range (1, 13):
    symbol = min_val +(interval * i)
    for j in range (1, len(table)):
        if table[j][1] <= symbol and table[j][2] == 0:
            table[j][2] = i

# Calculate the frequency
frequency = np.zeros((13),dtype=int)
for i in range (1, len(table)):
    frequency[int(table[i][2])] += 1

print("Total frequency : ",sum(frequency))

# Calculate the probabilities
probability = np.zeros((13),dtype=float)
for i in range (1, 13):
    probability[i] = frequency[i] / sum(frequency)

print("\nSymbol\tFrequency\tProbability")
for i in range(1, 13):
    print(i,"\t",frequency[i],"\t",probability[i])

# Entropy calculation
entropy = 0
for i in range(1, 13):
    if(probability[i] != 0):
        entropy -= probability[i] * np.log2(probability[i])

print("Entropy : ",entropy)