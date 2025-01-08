import pandas as pd
import numpy as np

# Read the dataset
data = pd.read_csv(r"Lab Data\^BSESN.csv")
# Sort the data by date
data['Date'] = pd.to_datetime(data['Date'], format='mixed')
data.sort_values(by='Date', ascending=True, inplace=True)

# Extract the close values and calculate RT
closeValues = data['Close'].dropna().reset_index(drop=True)
RT = np.log(closeValues).diff().dropna().reset_index(drop=True)

Bins = 12
print ("max value : ",np.max(RT).round(6),
       "\nmin value : ",np.min(RT).round(6),
       "\nInterval : ",((np.max(RT) - np.min(RT)) / Bins).round(6))

frequency, ranges = np.histogram(RT,Bins)
probability = frequency / np.sum(frequency)
table = pd.DataFrame({
    'Symbol': np.arange(1,Bins+1),
    'Frequency': frequency,
    'Range': [f"[{ranges[i].round(4)}, {ranges[i+1].round(4)}]" for i in range(Bins)],
    'Probability': probability
})
print(table)
probability = probability[probability != 0]
entropy = -np.sum(probability * np.log2(probability))
print("Entropy : ",entropy.round(6))