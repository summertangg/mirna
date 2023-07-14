import os
import psycopg2
import pandas as pd
from db_helper import *


def export_interactions(db_conn, root_path, out_file):
    print("\n*** Exporting miRNA - Gene interactions from miRDB records ......")
    file_path = os.path.join(root_path, out_file)
    cur = conn.cursor()
    results = get_interactions(db_conn, cur)
    cur.close()

    # Convert the query results to a DataFrame
    df = pd.DataFrame(results, columns=["mirna", "gene", "is_target"])

    # Pivot the DataFrame
    pivot_df = pd.pivot_table(df, values="is_target", index="mirna", columns="gene", fill_value=0)

    # Replace float values 1.0 and 0.0 with strings 'Yes' and 'No', respectively
    pivot_df = pivot_df.replace({1.0: 'Yes', 0.0: 'No'})

    # Write the pivoted DataFrame to a CSV file
    pivot_df.to_csv(file_path, index=True)

    # Print a message
    print(f"{file_path} file saved successfully.")


root_path = "~/code/mirna/resources/results"
interaction_file = "mirdb_interactions.csv"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    export_interactions(conn, root_path, interaction_file)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()