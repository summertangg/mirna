import os
import csv
import psycopg2
from db_helper import *


def import_mirna(db_conn, root_path, mirna_file):
    print("\n*** Importing miRNAs ......")
    file_path = os.path.join(root_path, mirna_file)
    file_path = os.path.abspath(os.path.expanduser(file_path))
    data = []

    with open(file_path, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)

    cur = conn.cursor()

    # Print the array of dictionary items
    for item in data:
        insert_mirna(conn, cur, item['miRNA'], item['description'])
    
    cur.close()


def import_pathway(db_conn, root_path, pathway_file):
    print("\n*** Importing pathways ......")
    file_path = os.path.join(root_path, pathway_file)
    file_path = os.path.abspath(os.path.expanduser(file_path))
    data = []

    with open(file_path, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)

    cur = conn.cursor()

    # Print the array of dictionary items
    for item in data:
        insert_pathway(conn, cur, item['id'], item['name'])

    cur.close()


def import_targets_verified(db_conn, root_path, target_file, pathway_id=-1):
    print("\n*** Importing verified target genes ......")
    file_path = os.path.join(root_path, target_file)
    file_path = os.path.abspath(os.path.expanduser(file_path))
    data = []

    with open(file_path, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)

    cur = conn.cursor()
    
    for index in range(len(data)):
        # Insert the miRNA if it doesn't exist
        if index == 0:
            insert_mirna(conn, cur, data[index]['miRNA'], '')
        
        # Insert the target gene if it does't exist
        insert_gene(conn, cur, data[index]['Target'], '')

        # Insert mirna-gene interaction
        insert_mirna_gene_interaction(conn, cur, data[index]['miRNA'], data[index]['Target'], pathway_id)

    cur.close()


def import_targets_pathway(db_conn, root_path, pathway_files):
    cur = conn.cursor()
    for pathway_file, pathway_id in pathway_files:
        file_path = os.path.join(root_path, pathway_file)
        file_path = os.path.abspath(os.path.expanduser(file_path))
        data = []

        with open(file_path, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                data.append(row)

        pathway_name = get_pathway(cur, pathway_id)
        print(f'\n*** Importing target genes involved in a pathway "{pathway_id}: {pathway_name}" ......')
        
        for index in range(len(data)):
            # Insert the miRNA if it doesn't exist
            if index == 0:
                insert_mirna(conn, cur, data[index]['miRNA Name'], '')
            
            # Insert the target gene if it does't exist
            insert_gene(conn, cur, data[index]['Target Gene Names'], '')

            # Insert mirna-gene interaction
            insert_mirna_gene_interaction(conn, cur, data[index]['miRNA Name'], data[index]['Target Gene Names'], pathway_id)

    cur.close()


root_path = "~/code/mirna/resources/target_files"
mirna_file = "miRNAs.csv"
pathway_file = "pathways.csv"
target_file = "hsa-mir-20a-5p-targets-verified.csv"
target_pathway_files = [
]

conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    import_mirna(conn, root_path, mirna_file)
    import_pathway(conn, root_path, pathway_file)
    import_targets_verified(conn, root_path, target_file)
    import_targets_pathway(conn, root_path, target_pathway_files)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
