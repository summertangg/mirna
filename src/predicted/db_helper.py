def insert_mirna(conn, cur, mirna_id, description, disease):
    mirna_id = mirna_id.lower()
    print(mirna_id)
    cur.execute("SELECT COUNT(*) FROM mirnas WHERE mirna_id = %s", (mirna_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO mirnas (mirna_id, description, disease) VALUES (%s, %s, %s)", (mirna_id, description, disease))
        print(f"{mirna_id} inserted successfully.")
    else:
        if description and len(description) > 0:
            cur.execute("UPDATE mirnas SET description = %s WHERE mirna_id = %s", (description, mirna_id))
            print(f"{mirna_id} is updated with new description: {description}.")

        if disease and len(disease) > 0:
            cur.execute("UPDATE mirnas SET disease = %s WHERE mirna_id = %s", (disease, mirna_id))
            print(f"{mirna_id} is updated with new disease: {disease}.")
    conn.commit()

def insert_gene(conn, cur, gene_id, description, kegg_id=None, kegg_id_new=None):
    gene_id = gene_id.upper()
    print(gene_id)
    cur.execute("SELECT COUNT(*) FROM genes WHERE gene_id = %s", (gene_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO genes (gene_id, description, kegg_id, kegg_id_new) VALUES (%s, %s, %s, %s)", (gene_id, description, kegg_id, kegg_id_new))
        print(f"{gene_id} inserted successfully.")
    else:
        if description and len(description) > 0:
            cur.execute("UPDATE genes SET description = %s WHERE gene_id = %s", (description, gene_id))
            print(f"{gene_id} is updated with new description: {description}.")
        if kegg_id:
            cur.execute("UPDATE genes SET kegg_id = %s WHERE gene_id = %s", (kegg_id, gene_id))
            print(f"{gene_id} is updated with new kegg_id: {kegg_id}.")
        if kegg_id_new:
            cur.execute("UPDATE genes SET kegg_id_new = %s WHERE gene_id = %s", (kegg_id_new, gene_id))
            print(f"{gene_id} is updated with new kegg_id_new: {kegg_id_new}.")
    conn.commit()


def insert_mirna_gene_interaction(conn, cur, mirna_id, gene_id, target_score):
    mirna_id = mirna_id.lower()
    gene_id = gene_id.upper()
    print(f"interaction: {mirna_id} - {gene_id} with target_score {target_score}")
    cur.execute("SELECT COUNT(*) FROM mirdb_mirna_gene WHERE mirna = %s AND gene = %s", (mirna_id, gene_id))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES (%s, %s, %s)", (mirna_id, gene_id, target_score))
        conn.commit()
        print(f"{mirna_id} - {gene_id} (target_score: {target_score}) inserted successfully.")
    else:
        cur.execute("UPDATE mirdb_mirna_gene SET target_score = %s WHERE mirna = %s AND gene = %s", (target_score, mirna_id, gene_id))
        conn.commit()
        print(f"{mirna_id} - {gene_id} (target_score: {target_score}) is updated.")


def get_interactions(conn, cur, config=None):
    selected_mirna = ''
    
    if config:
        # Join the elements in the mirna list with single quotes and comma
        selected_mirna = ', '.join([f"'{mirna}'" for mirna in config])
        selected_mirna = f'AND mirna IN ({selected_mirna})'
    print(selected_mirna)

    cur.execute(f"""
SELECT COALESCE(i.mirna, 'mir-0') AS mirna, ge.gene_id, '1' AS is_target
FROM genes AS ge
LEFT JOIN mirdb_mirna_gene AS i ON ge.gene_id = i.gene AND i.target_score >=97 
{selected_mirna}
ORDER BY ge.gene_id
""")

    # Fetch all the query results
    results = cur.fetchall()
    return results

def get_interactions_with_pathways(conn, cur, config=None):
    selected_mirna = ''
    
    if config:
        # Join the elements in the mirna list with single quotes and comma
        selected_mirna = ', '.join([f"'{mirna}'" for mirna in config])
        selected_mirna = f'AND mirna IN ({selected_mirna})'
    print(selected_mirna)

    cur.execute(f"""
SELECT COALESCE(i.mirna, 'mir-0') AS mirna, ge.gene_id, '1' AS is_target
FROM genes AS ge
LEFT JOIN mirdb_mirna_gene AS i ON ge.gene_id = i.gene AND i.target_score >=97 
{selected_mirna}
UNION
SELECT COALESCE(mp.mirna, 'mir-0') AS mirna, da.pathway_id, '1' AS is_target
FROM david AS da
LEFT JOIN david_mirna_pathway AS mp ON da.pathway_id = mp.pathway 
{selected_mirna}
ORDER BY gene_id desc
""")

    # Fetch all the query results
    results = cur.fetchall()
    return results

def get_mirna_involved_in_pathway(conn, cur, pathway_id, config):
    selected_mirna = ', '.join([f"'{mirna}'" for mirna in config])
    selected_mirna = f'AND mirna IN ({selected_mirna})'
    print(selected_mirna)

    cur.execute(f"""
SELECT mirna, STRING_AGG(DISTINCT mg.gene, ',') AS grouped_gene, count(mg.gene) as num_gene --,
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
{selected_mirna}
WHERE mg.target_score >= 97
  AND pg.pathway_id = 7
group by mirna
HAVING count(mg.gene) >= 2
ORDER BY mirna
""")

    # Fetch all the query results
    results = cur.fetchall()
    return results


def get_all_mirans(conn, cur):
    # Execute the SQL query
    cur.execute("""
SELECT mirna_id, disease FROM mirnas 
""")

    # Fetch all the query results
    results = cur.fetchall()
    return results

def get_mirna_genes(conn, cur, mirna):
    cur.execute(f"""
SELECT gene
FROM mirdb_mirna_gene
WHERE target_score >= 97
  AND mirna = '{mirna}'
group by gene
ORDER BY gene
""")

    # Fetch all the query results
    results = cur.fetchall()
    return results

def get_pathway(cur, pathway_id):
    print(f'pathway id: {pathway_id}')
    cur.execute("SELECT name FROM pathways WHERE pathway_id = %s", (pathway_id,))
    # Fetch the record
    record = cur.fetchone()

    if record:
        # Access the name column from the record
        pathway_name = record[0]
        print("Pathway name:", pathway_name)
    else:
        print("No record found.")
    return pathway_name

def insert_pathway_gene(conn, cur, pathway_id, gene_id):
    gene_id = gene_id.upper()
    print(f"pathway - gene: {pathway_id} - {gene_id} from KEGG")
    cur.execute("SELECT COUNT(*) FROM pathway_gene WHERE pathway_id = %s AND gene = %s", (pathway_id, gene_id))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO pathway_gene (pathway_id, gene) VALUES (%s, %s)", (pathway_id, gene_id))
        conn.commit()
        print(f"{pathway_id} - {gene_id} inserted successfully.")
    else:
        print(f"{pathway_id} - {gene_id} already exists.")

def insert_david_mirna_pathway(conn, cur, mirna, pathway_kegg_id, pathway_name, p_value):
    print(f"mirna - pathway - p-value: {mirna} - {pathway_kegg_id}:{pathway_name} - {p_value} from DAVID")
    cur.execute("SELECT COUNT(*) FROM david WHERE pathway_id = %s", (pathway_kegg_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO david (pathway_id, name) VALUES (%s, %s)", (pathway_kegg_id, pathway_name))
        conn.commit()
        print(f"{pathway_kegg_id}:{pathway_name} inserted successfully.")
    else:
        print(f"{pathway_kegg_id}:{pathway_name} already exists.")
   

    cur.execute("SELECT COUNT(*) FROM david_mirna_pathway WHERE mirna = %s AND pathway = %s", (mirna, pathway_kegg_id))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO david_mirna_pathway (mirna, pathway, p_value) VALUES (%s, %s, %s)", (mirna, pathway_kegg_id, p_value))
        conn.commit()
        print(f"{mirna} - {pathway_kegg_id} - {p_value} inserted successfully.")
    else:
        print(f"{mirna} - {pathway_kegg_id} already exists.")

def insert_david_mirna_pathway_cancer(conn, cur, mirna, pathway_kegg_id, p_value):
    cur.execute("SELECT COUNT(*) FROM david_mirna_pathway WHERE mirna = %s AND pathway = %s", (mirna, pathway_kegg_id))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO david_mirna_pathway (mirna, pathway, p_value) VALUES (%s, %s, %s)", (mirna, pathway_kegg_id, p_value))
        conn.commit()
        print(f"{mirna} - {pathway_kegg_id} - {p_value} inserted successfully.")
    else:
        print(f"{mirna} - {pathway_kegg_id} already exists.")

