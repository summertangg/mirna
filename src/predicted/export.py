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

    results = get_interactions_with_pathways(db_conn, cur, config)

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
    num_of_base_col = []
    ratio_a_col = []
    ratio_c_col = []
    ratio_g_col = []
    ratio_u_col = []
    for index, row in pivot_df.iterrows():
        print(f"{index}: disease {mirnas_dict[index]}")
        if mirnas_dict[index] == 'DLBCL':
            disease_col.append('Yes')
            num_of_base_col.append(num_of_bases(m54.sequence[index]))
            ratio_a_col.append(frequency_of_base(m54.sequence[index], 'A'))
            ratio_c_col.append(frequency_of_base(m54.sequence[index], 'C'))
            ratio_g_col.append(frequency_of_base(m54.sequence[index], 'G'))
            ratio_u_col.append(frequency_of_base(m54.sequence[index], 'U'))
        else:
            disease_col.append('No')
            num_of_base_col.append(0)
            ratio_a_col.append(0)
            ratio_c_col.append(0)
            ratio_g_col.append(0)
            ratio_u_col.append(0)
    
    # pivot_df.insert(0, 'DIAGNOSTIC_POSITIVE', disease_col)
    pivot_df['NUM_OF_BASES'] = num_of_base_col
    pivot_df['RATIO_A'] = ratio_a_col
    pivot_df['RATIO_C'] = ratio_c_col
    pivot_df['RATIO_G'] = ratio_g_col
    pivot_df['RATIO_U'] = ratio_u_col
    pivot_df['DIAGNOSTIC_POSITIVE'] = disease_col

    # Write the pivoted DataFrame to a CSV file
    pivot_df.to_csv(file_path, index=True)

    # Print a message
    print(f"{file_path} file saved successfully.")

def num_of_bases(seq):
    return len(seq)

def frequency_of_base(seq, base):
    total_base = len(seq)
    count = 0

    # Iterate through the sequence
    for v in seq:
        if v == base:
            count += 1
    ratio = "{:.2f}".format(count/total_base)
    return ratio

root_path = "~/code/mirna/resources/results"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    export_interactions(conn, root_path, m54.interaction_file, m54.all_mirnas)

    # export_interactions(conn, root_path, mlawrie.table_1_file, mlawrie.table_1)
    # export_interactions(conn, root_path, mlawrie.table_2_file, mlawrie.table_2)

    # export_interactions(conn, root_path, mlar.table_1_file, mlar.table_1)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
