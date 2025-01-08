import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Read the dataset
data = pd.read_csv(r"Lab Data\^BSESN.csv")

# Sort the data by date
data['Date'] = pd.to_datetime(data['Date'], format='%Y-%m-%d')
data.sort_values(by='Date', ascending=True, inplace=True)

# Extract the close values and calculate RT
closeValues = data['Close'].dropna().reset_index(drop=True)
RT = np.log(closeValues).diff().dropna().reset_index(drop=True)

Bins = 12
print("max value : ", np.min(RT).round(6),
      "\nmin value : ", np.min(RT).round(6),
      "\nInterval : ", ((np.max(RT) - np.min(RT)) / Bins).round(6))

frequency, ranges = np.histogram(RT, Bins)
probability = frequency / np.sum(frequency)

# Create DataFrame for visualization
table = pd.DataFrame({
    'Symbol': np.arange(1, Bins+1),
    'Frequency': frequency,
    'Range': [f"[{ranges[i].round(4)}, {ranges[i+1].round(4)}]" for i in range(Bins)],
    'Probability': probability
})
print(table)

# Calculate entropy
probability = probability[probability != 0]
entropy = -np.sum(probability * np.log2(probability))
print("Entropy : ", entropy)

# Plot frequency
plt.figure(figsize=(10, 6))
plt.bar(table['Symbol'], table['Frequency'], color='skyblue', alpha=0.8)
plt.title('Frequency Distribution', fontsize=14)
plt.xlabel('Bins (Symbol)', fontsize=12)
plt.ylabel('Frequency', fontsize=12)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()

# Plot probability
plt.figure(figsize=(10, 6))
plt.bar(table['Symbol'], table['Probability'], color='lightgreen', alpha=0.8)
plt.title('Probability Distribution', fontsize=14)
plt.xlabel('Bins (Symbol)', fontsize=12)
plt.ylabel('Probability', fontsize=12)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()

# Plot entropy (single value)
plt.figure(figsize=(6, 4))
plt.bar(['Entropy'], [entropy], color='orange', alpha=0.8)
plt.title('Entropy', fontsize=14)
plt.ylabel('Value', fontsize=12)
plt.ylim(0, entropy + 0.5)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()
