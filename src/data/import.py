import os
import csv
import psycopg2
from db_helper import *


def import_mirna(db_conn, root_path, mirna_file):
    print("\n*** Importing miRNAs ......")
    file_path = os.path.join(root_path, mirna_file)
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
    data = []

    with open(file_path, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)

    cur = conn.cursor()

    # Print the array of dictionary items
    for item in data:
        insert_pathway(conn, cur, item['name'])

    cur.close()


def import_targets_verified(db_conn, root_path, target_file):
    print("\n*** Importing verified target genes ......")
    file_path = os.path.join(root_path, target_file)
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
        insert_mirna_gene_interaction(conn, cur, data[index]['miRNA'], data[index]['Target'], 1)

    cur.close()


root_path = "/Users/clairedeng/code/mirna/resources/target_files"
mirna_file = "miRNAs.csv"
pathway_file = "pathways.csv"
target_file = "hsa-mir-155-3p-targets-verified.csv"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
# import_mirna(conn, root_path, mirna_file)
# import_pathway(conn, root_path, pathway_file)
import_targets_verified(conn, root_path, target_file)
conn.close()
