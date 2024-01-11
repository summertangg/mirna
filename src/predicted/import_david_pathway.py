import os
import psycopg2
import glob
from db_helper import *


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

root_path = "~/code/mirna/resources/david_files"
pathway_file = "hsa-mir-182.txt"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    # import_david_pathway(conn, root_path, pathway_file)
    import_batch_files(conn, root_path)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
