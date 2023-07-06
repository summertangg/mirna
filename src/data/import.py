import os
import csv
import psycopg2


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
        # Check if the record already exists
        cur.execute("SELECT COUNT(*) FROM miRNAs WHERE mirna_id = %s", (item['miRNA'],))
        record_count = cur.fetchone()[0]
        
        if record_count == 0:
            # Insert the record if it doesn't exist
            cur.execute("INSERT INTO miRNAs (mirna_id, description) VALUES (%s, %s)", (item['miRNA'], item['description']))
            conn.commit()
            print(f"{item} inserted successfully.")
        else:
            print(f"{item} already exists.")

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
        # Check if the record already exists
        print(item['name'])
        cur.execute("SELECT COUNT(*) FROM pathways WHERE name = %s", (item['name'],))
        record_count = cur.fetchone()[0]
        
        if record_count == 0:
            # Insert the record if it doesn't exist
            cur.execute("INSERT INTO pathways (name) VALUES (%s)", (item['name'],))
            conn.commit()
            print(f"{item} inserted successfully.")
        else:
            print(f"{item} already exists.")

    cur.close()


root_path = "/Users/clairedeng/code/mirna/resources/target_files"
mirna_file = "miRNAs.csv"
pathway_file = "pathways.csv"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
import_mirna(conn, root_path, mirna_file)
import_pathway(conn, root_path, pathway_file)
conn.close()
