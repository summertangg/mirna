import os
import psycopg2
import pandas as pd
from db_helper import *
from config import mir17_training_set as m17
from config import mir10_testing_set as m10
from config import mir26_testing_set as m26
from config import mir54_training_set as m54
from config import mir_lawrie_testing_set as mlawrie
from config import mir_larrabeiti_testing_set as mlar



def export_interactions(db_conn, root_path, out_file, config=None):
    print("\n*** Exporting miRNA - Gene interactions from miRDB records ......")
    file_path = os.path.join(root_path, out_file)
    cur = conn.cursor()

    mirnas = get_all_mirans(db_conn, cur)
    mirnas_dict = {record[0]: record[1] for record in mirnas}

    results = get_interactions(db_conn, cur, config)

    cur.close()

    # Convert the query results to a DataFrame
    df = pd.DataFrame(results, columns=["mirna", "gene", "is_target"])

    # Pivot the DataFrame
    pivot_df = pd.pivot_table(df, values="is_target", index="mirna", columns="gene", fill_value=0)

    # Remove the mir-0 row
    pivot_df.drop('mir-0', inplace=True)

    # Replace float values 1.0 and 0.0 with strings 'Yes' and 'No', respectively
    pivot_df = pivot_df.replace({1.0: 'Yes', 0.0: 'No'})
    disease_col = []
    for index, row in pivot_df.iterrows():
        print(f"{index}: disease {mirnas_dict[index]}")
        if mirnas_dict[index] == 'DLBCL':
            disease_col.append('Yes')
        else:
            disease_col.append('No')
    
    # pivot_df.insert(0, 'DIAGNOSTIC_POSITIVE', disease_col)
    pivot_df['DIAGNOSTIC_POSITIVE'] = disease_col

    # Write the pivoted DataFrame to a CSV file
    pivot_df.to_csv(file_path, index=True)

    # Print a message
    print(f"{file_path} file saved successfully.")


root_path = "~/code/mirna/resources/results"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    export_interactions(conn, root_path, m54.interaction_file, m54.all_mirnas)
    export_interactions(conn, root_path, mlawrie.table_1_file, mlawrie.table_1)
    export_interactions(conn, root_path, mlawrie.table_2_file, mlawrie.table_2)

    # export_interactions(conn, root_path, m54.clean_file, m54.positive_mirnas)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
