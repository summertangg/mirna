import pandas as pd

# Query result
data = [
    ("AAK1", "hsa-mir-155-5p", 1),
    ("ABCC4", "hsa-mir-155-5p", 1),
    ("ABCF3", "hsa-mir-155-3p", 1),
    ("ABHD16A", "hsa-mir-155-5p", 1),
    ("ABI2", "hsa-mir-155-5p", 1),
    ("ACOT7", "hsa-mir-155-5p", 1),
    ("ACOX1", "hsa-mir-155-5p", 1),
    ("ACTR2", "hsa-mir-155-5p", 1),
    ("ADAM10", "hsa-mir-155-5p", 1),
    ("ADAMTS4", "hsa-mir-155-5p", 1),
    ("ADAMTS5", "hsa-mir-155-3p", 1)
]

# Convert query result to DataFrame
df = pd.DataFrame(data, columns=["gene_id", "mirna", "count"])
print(df)

# List of all gene_id values
all_genes = df["gene_id"].unique()

# Pivot the DataFrame
pivot_df = pd.pivot_table(df, values="count", index="mirna", columns='gene_id', fill_value=0)

# Print the pivoted DataFrame
print(pivot_df)

# Write the pivoted DataFrame to a CSV file
pivot_df.to_csv("pivot_result.csv", index=True)
