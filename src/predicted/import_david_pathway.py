import os
import psycopg2
import glob
from db_helper import *
from config import mir54_training_set as m54
from config import mir_lawrie_testing_set as mlawrie
from config import mir_larrabeiti_testing_set as mlar
from config import mir_beheshti_testing_set as mbe


def import_batch_files(conn, root_path):
    # Iterate through all '.txt' files in the folder
    root_path = os.path.abspath(os.path.expanduser(root_path))
    for file_path in glob.glob(os.path.join(root_path, '*.txt')):
        if os.path.isfile(file_path):
            print(file_path)
            import_david_pathway(conn, None, file_path)

def import_david_pathway(db_conn, root_path, pathway_file):
    cur = conn.cursor()
    if root_path:
        file_path = os.path.join(root_path, pathway_file)
        file_path = os.path.abspath(os.path.expanduser(file_path))
    else:
        file_path = pathway_file
    file_name = file_path.split('/')[-1]
    mirna = file_name[: -4]


    with open(file_path, 'r') as file:
        for line in file:
            if not line.startswith('KEGG_PATHWAY'):
                continue

            columns = line.strip().split('\t')
            if len(columns) > 4:
                term = columns[1].split(':')
                insert_david_mirna_pathway(conn, cur, mirna, term[0], term[1], columns[4])

    cur.close()

def import_specific_pathway(db_conn, pathway_id, pathway_kegg_id, p_value, config):
    cur = conn.cursor()

    mirnas = get_mirna_involved_in_pathway(db_conn, cur, pathway_id, config)
    for mirna in mirnas:
        insert_david_mirna_pathway_cancer(db_conn, cur, mirna[0], pathway_kegg_id, p_value)

    cur.close()


root_path = "~/code/mirna/resources/david_files"
pathway_file = "hsa-mir-155.txt"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    # import david pathway annotations for the genes targetted by an mirna so that david_mirna_pathway records can be created
    # import_david_pathway(conn, root_path, pathway_file)
    
    # run a query to get mirnas having at least 2 genes involved in the given pathway
    # import_specific_pathway(conn, 7, 'hsa05200', 0.05, m54.positive_mirnas)
    # import_specific_pathway(conn, 7, 'hsa05200', 0.05, mlawrie.table_1)
    # import_specific_pathway(conn, 7, 'hsa05200', 0.05, mlawrie.table_2)
    import_specific_pathway(conn, 7, 'hsa05200', 0.05, mlar.table_1)
    # import_specific_pathway(conn, 7, 'hsa05200', 0.05, mbe.fig_1)

except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
