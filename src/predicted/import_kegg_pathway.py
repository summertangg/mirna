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
                if len(columns) > 2:
                    gene = {
                        "kegg_id": int(columns[0].strip()),
                        "gene_id": columns[1].strip()[: -1]
                    }
                    genes.append(gene)

        pathway_name = get_pathway(cur, pathway_id)
        print(f'\n*** Importing target genes involved in a pathway "{pathway_id}: {pathway_name}" ......')
        
        for gene in genes:
            # Insert the pathway gene if it does't exist
            insert_gene(conn, cur, gene['gene_id'], '', gene['kegg_id'])

            # Insert pathway-gene interaction
            insert_pathway_gene(conn, cur, pathway_id, gene['gene_id'])

    cur.close()

root_path = "~/code/mirna/resources/results/kegg"
pathway_files = [('hsa04662_B-CELL-RECEPTOR_genes.txt', 1),
                 ('hsa04010_MAPK_genes.txt', 2),
                 ('hsa04064_NF-KAPPA-B_genes.txt', 3),
                 ('hsa04115_P53_genes.txt', 4),
                 ('hsa04141_PI3K-AKT_genes.txt', 5),
                 ('hsa05235_PD-L1_genes.txt', 6),
                 ('hsa05200_CANCER_genes.txt', 7),
                 ('hsa04915_Estrogen_genes.txt', 8),
                 ('hsa04024_cAMP_genes.txt', 9),
                 ('hsa04310_Wnt_genes.txt', 10),
                 ('hsa04350_TGF-BETA_genes.txt', 11),
                 ('hsa04512_ECM-receptor_genes.txt', 12),
                 ('hsa04630_JAK-STAT_genes.txt', 13),
                 ('hsa04150_mTOR_genes.txt', 14),
                 ('hsa04060_Cytokine_genes.txt', 15)]

conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    import_kegg_pathway_gene(conn, root_path, pathway_files)
except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
