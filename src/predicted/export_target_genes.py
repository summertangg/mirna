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



def export_genes(db_conn, root_path, out_dir, config):
    print("\n*** Exporting miRNA - Gene interactions from miRDB records ......")
    cur = conn.cursor()

    for mirna in config:
        results = get_mirna_genes(db_conn, cur, mirna)

        # Convert the query results to a DataFrame
        df = pd.DataFrame(results, columns=["mirna"])

        # Write the DataFrame to a CSV file
        file_path = os.path.join(root_path, out_dir, mirna+'.csv')
        df.to_csv(file_path, index=False)

        # Print a message
        print(f"{file_path} file saved successfully.")

    cur.close()



root_path = "~/code/mirna/resources/results/david"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    # export_genes(conn, root_path, "m54", m54.positive_mirnas)
    export_genes(conn, root_path, "random", m54.random_mirnas)

    # export_interactions(conn, root_path, mlar.table_1_file, mlar.table_1)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()