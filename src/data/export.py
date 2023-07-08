import os
import psycopg2
import pandas as pd
from db_helper import *


def export_interactions(db_conn, root_path, out_file):
    print("\n*** Exporting miRNA - Gene interactions ......")
    file_path = os.path.join(root_path, out_file)
    cur = conn.cursor()
    results = get_interactions(conn, cur)
    cur.close()

    # Convert the query results to a DataFrame
    df = pd.DataFrame(results, columns=["gene", "mirna", "count"])

    # Pivot the DataFrame
    pivot_df = pd.pivot_table(df, values="count", index="mirna", columns="gene", fill_value=0)

    # Write the pivoted DataFrame to a CSV file
    pivot_df.to_csv(file_path, index=True)

    # Print a message
    print(f"{file_path} file saved successfully.")


root_path = "~/code/mirna/resources/results"
interaction_file = "interactions.csv"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    export_interactions(conn, root_path, interaction_file)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
