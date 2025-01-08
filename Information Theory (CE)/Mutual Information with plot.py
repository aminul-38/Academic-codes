import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# For X
companyOne = pd.read_csv(r"Lab Data\canada.csv")
X = pd.DataFrame({
    'Date': companyOne['Date'],
    'Close': companyOne['Close']
})
X = X.dropna(subset=['Date', 'Close']).reset_index(drop=True)
X['Date'] = pd.to_datetime(X['Date'], format='mixed', errors='raise')
X.sort_values(by='Date', ascending=True, inplace=True)

# For Y
companyTwo = pd.read_csv(r"Lab Data\^TWII.csv")
Y = pd.DataFrame({
    'Date': companyTwo['Date'],
    'Close': companyTwo['Close']
})
Y = Y.dropna(subset=['Date', 'Close']).reset_index(drop=True)
Y['Date'] = pd.to_datetime(Y['Date'], format='mixed', errors='raise')
X.sort_values(by='Date', ascending=True, inplace=True)

# Merging close_x and close_y based on date
XY = pd.merge(X, Y, how='inner', on='Date')

RT = pd.DataFrame({
    'RX': XY['Close_x'],
    'RY': XY['Close_y']
})

# Calculating difference
RT = np.log(RT).diff().dropna().reset_index(drop=True)
Bins = 12

# Calculation of P(X,Y)
frequencies_x_y, x_edges, y_edges = np.histogram2d(RT['RX'], RT['RY'], Bins)
propbabilities_x_y = frequencies_x_y / np.sum(frequencies_x_y)

# Calculation of P(X)
RX = RT['RX']
frequencies_x, rx_edges = np.histogram(RX, Bins)
propbabilities_x = frequencies_x / np.sum(frequencies_x)

# Calculation of P(Y)
RY = RT['RY']
frequencies_y, ry_edges = np.histogram(RY, Bins)
propbabilities_y = frequencies_y / np.sum(frequencies_y)

# Calculate bin centers for RX and RY
rx_bin_centers = (x_edges[:-1] + x_edges[1:]) / 2
ry_bin_centers = (y_edges[:-1] + y_edges[1:]) / 2

# Flatten histogram data and create a grid of bin centers
frequency_flat = frequencies_x_y.ravel()
probability_flat = propbabilities_x_y.ravel()
rx_flat, ry_flat = np.meshgrid(rx_bin_centers, ry_bin_centers, indexing='ij')
rx_flat, ry_flat = rx_flat.ravel(), ry_flat.ravel()

# Calculate bin indices for RX and RY
rx_indices = np.clip(np.digitize(rx_flat, x_edges, right=True), 1, len(x_edges) - 1)
ry_indices = np.clip(np.digitize(ry_flat, y_edges, right=True), 1, len(y_edges) - 1)

# Create DataFrame
table = pd.DataFrame({
    'RX': rx_flat,
    'RY': ry_flat,
    'Symbol': [f"[{rx},{ry}]" for rx, ry in zip(rx_indices, ry_indices)],
    'Frequency': frequency_flat,
    'Probability': probability_flat,
})

# Filter rows with non-zero frequency
table = table[table['Frequency'] > 0].reset_index(drop=True)

# Plot 2D Histogram as Heatmap (Frequency)
plt.figure(figsize=(8, 6))
plt.imshow(frequencies_x_y.T, origin='lower', aspect='auto', cmap='viridis',
           extent=[x_edges[0], x_edges[-1], y_edges[0], y_edges[-1]])
plt.colorbar(label='Frequency')
plt.title('2D Histogram (Frequency)', fontsize=14)
plt.xlabel('RX', fontsize=12)
plt.ylabel('RY', fontsize=12)
plt.grid(alpha=0.5)
plt.show()

# Plot 2D Probability Distribution Heatmap
plt.figure(figsize=(8, 6))
plt.imshow(propbabilities_x_y.T, origin='lower', aspect='auto', cmap='plasma',
           extent=[x_edges[0], x_edges[-1], y_edges[0], y_edges[-1]])
plt.colorbar(label='Probability')
plt.title('2D Probability Distribution', fontsize=14)
plt.xlabel('RX', fontsize=12)
plt.ylabel('RY', fontsize=12)
plt.grid(alpha=0.5)
plt.show()

# Plot Frequency Distribution for RX and RY
plt.figure(figsize=(10, 4))
plt.bar(np.arange(1, Bins+1), frequencies_x, alpha=0.7, label='RX Frequencies', color='skyblue')
plt.bar(np.arange(1, Bins+1), frequencies_y, alpha=0.7, label='RY Frequencies', color='orange')
plt.xlabel('Bins', fontsize=12)
plt.ylabel('Frequency', fontsize=12)
plt.title('Frequency Distribution for RX and RY', fontsize=14)
plt.legend()
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()

# Plot Mutual Information (as a single bar for clarity)
mutual_information_from_probability = 0
for i in range(len(propbabilities_x_y)):
    for j in range(len(propbabilities_x_y[0])):
        if propbabilities_x_y[i][j] != 0 and propbabilities_x[i] != 0 and propbabilities_y[j] != 0:
            mutual_information_from_probability += propbabilities_x_y[i][j] * np.log2(
                propbabilities_x_y[i][j] / (propbabilities_x[i] * propbabilities_y[j]))
print("Mutual Information from joint probability:", mutual_information_from_probability.round(6))

plt.figure(figsize=(6, 4))
plt.bar(['Mutual Information'], [mutual_information_from_probability], color='green', alpha=0.8)
plt.title('Mutual Information', fontsize=14)
plt.ylabel('Value', fontsize=12)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()
