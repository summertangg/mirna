import os
import csv
import psycopg2
from db_helper import *


def import_targets_predicted(conn, root_path, target_file):
    print("\n*** Importing predicted target genes ......")
    file_path = os.path.join(root_path, target_file)
    file_path = os.path.abspath(os.path.expanduser(file_path))
    data = []

    with open(file_path, 'r') as file:
        lines = file.readlines()

    item = {}
    for line in lines:
        line = line.strip()
        if line.startswith('Details'):
            if item:
                data.append(item)
                item = {}
        elif line.isdigit() and 'serial_number' not in item:
            item['serial_number'] = int(line)
        elif line.isdigit() and 'ranking' not in item:
            item['target_score'] = int(line)
        elif line.startswith('hsa'):
            item['mirna'], item['gene'], item['description'] = line.split('\t')

    # Add the last item
    if item:
        data.append(item)

    # Print the retrieved data items
    # for item in data:
    #     print(item)


    cur = conn.cursor()
    
    for index in range(len(data)):
        # Insert the miRNA if it doesn't exist

        if index == 0:
            mirna_id = data[index]['mirna']
            if mirna_id.endswith('p'):
                mirna_id = mirna_id[:-3]
            insert_mirna(conn, cur, mirna_id, '')
        
        # Insert the target gene if it does't exist
        insert_gene(conn, cur, data[index]['gene'], data[index]['description'])

        # Insert mirna-gene interaction
        insert_mirna_gene_interaction(conn, cur, mirna_id, data[index]['gene'], data[index]['target_score'])

    cur.close()


root_path = "~/code/mirna/resources/mirdb_files"
target_file = "hsa-mir-20a-predicted.txt"

db_conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    import_targets_predicted(db_conn, root_path, target_file)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    db_conn.close()
