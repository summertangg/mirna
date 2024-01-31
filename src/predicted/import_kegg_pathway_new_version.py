import os
import psycopg2
from db_helper import *


def import_kegg_pathway_gene(db_conn, root_path, pathway_files):
    cur = conn.cursor()
    for pathway_file, pathway_id in pathway_files:
        file_path = os.path.join(root_path, pathway_file)
        file_path = os.path.abspath(os.path.expanduser(file_path))
        genes = []

        with open(file_path, 'r') as file:
            for line in file:
                columns = line.strip().split()
                if len(columns) > 1:
                    gene = {
                        "kegg_id_new": columns[0].strip(),
                        "gene_id": columns[1].strip()
                    }
                    genes.append(gene)

        pathway_name = get_pathway(cur, pathway_id)
        print(f'\n*** Importing target genes involved in a pathway "{pathway_id}: {pathway_name}" ......')
        
        for gene in genes:
            # Insert the pathway gene if it does't exist
            insert_gene(conn, cur, gene['gene_id'], '', None, gene['kegg_id_new'])

            # Insert pathway-gene interaction
            insert_pathway_gene(conn, cur, pathway_id, gene['gene_id'])

    cur.close()

root_path = "~/code/mirna/resources/results/kegg"
pathway_files = [
                 ('hsa05200_CANCER_genes_new_version.txt', 7),
]

conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    import_kegg_pathway_gene(conn, root_path, pathway_files)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
