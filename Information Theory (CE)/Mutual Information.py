import numpy as np
import pandas as pd

# For X
companyOne = pd.read_csv(r"Lab Data\canada.csv")
X = pd.DataFrame({
    'Date': companyOne['Date'],
    'Close': companyOne['Close']
})
X = X.dropna(subset=['Date','Close']).reset_index(drop=True)
X['Date'] = pd.to_datetime(X['Date'],format='mixed',errors='raise')
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
#print(XY.head(10))
RT = pd.DataFrame({
    'RX': XY['Close_x'],
    'RY': XY['Close_y']
})
# Calculating difference
RT = np.log(RT).diff().dropna().reset_index(drop=True)
# print(RT.head(10))
Bins = 12

# Calculation of P(X,Y)
frequencies_x_y, x_edges, y_edges = np.histogram2d(RT['RX'],RT['RY'],Bins)
propbabilities_x_y = frequencies_x_y/np.sum(frequencies_x_y)
#print(propbabilities_x_y)

# Calculation of P(X)
RX = RT['RX']
frequencies_x, rx_edges = np.histogram(RX,Bins)
propbabilities_x = frequencies_x/np.sum(frequencies_x)
#print(propbabilities_x)

# Calculation of P(Y)
RY = RT['RY']
frequencies_y, ry_edges = np.histogram(RY,Bins)
propbabilities_y = frequencies_y/np.sum(frequencies_y)
#print(propbabilities_y)

# Visuallizing informations in table

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
print(table)


# mutual information Calculation from joint probability
mutual_information_from_probability = 0
for i in range(len(propbabilities_x_y)):
    for j in range(len(propbabilities_x_y[0])):
        if propbabilities_x_y[i][j]!=0 and propbabilities_x[i]!=0 and propbabilities_y[j]!=0:
            mutual_information_from_probability += propbabilities_x_y[i][j] * np.log2(propbabilities_x_y[i][j] / (propbabilities_x[i] * propbabilities_y[j]))
print("Mutual Information from joint probability : ", mutual_information_from_probability.round(6))

# entropy calculation
propbabilities_X_Y = propbabilities_x_y[propbabilities_x_y !=0 ]
propbabilities_X = propbabilities_x[propbabilities_x !=0 ]
propbabilities_Y = propbabilities_y[propbabilities_y !=0 ]

entropy_x_y = -np.sum(propbabilities_X_Y * np.log2(propbabilities_X_Y)) # calculating H(X,Y)
entropy_x = -np.sum(propbabilities_X * np.log2(propbabilities_X)) # calculating H(X)
entropy_y = -np.sum(propbabilities_Y * np.log2(propbabilities_Y)) # calculating H(Y)

# mutual informatino from joint entropy
mutual_information_from_entropy = entropy_x + entropy_y - entropy_x_y
print("Mutual Information from joint entropy : ", mutual_information_from_entropy.round(6))