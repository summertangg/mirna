def insert_mirna(conn, cur, mirna_id, description):
    mirna_id = mirna_id.lower()
    print(mirna_id)
    cur.execute("SELECT COUNT(*) FROM mirnas WHERE mirna_id = %s", (mirna_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO mirnas (mirna_id, description) VALUES (%s, %s)", (mirna_id, description))
        print(f"{mirna_id} inserted successfully.")
    else:
        cur.execute("UPDATE mirnas SET description = %s WHERE mirna_id = %s", (description, mirna_id))
        print(f"{mirna_id} is updated with new description: {description}.")
    conn.commit()

def insert_gene(conn, cur, gene_id, description, kegg_id=None):
    gene_id = gene_id.upper()
    print(gene_id)
    cur.execute("SELECT COUNT(*) FROM genes WHERE gene_id = %s", (gene_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO genes (gene_id, description, kegg_id) VALUES (%s, %s, %s)", (gene_id, description, kegg_id))
        print(f"{gene_id} inserted successfully.")
    else:
        if description and len(description) > 0:
            cur.execute("UPDATE genes SET description = %s WHERE gene_id = %s", (description, gene_id))
            print(f"{gene_id} is updated with new description: {description}.")
        if kegg_id:
            cur.execute("UPDATE genes SET kegg_id = %s WHERE gene_id = %s", (kegg_id, gene_id))
            print(f"{gene_id} is updated with new kegg_id: {kegg_id}.")
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
        print(f"{mirna_id} - {gene_id} (target_score: {target_score}) already exists.")


def get_interactions(conn, cur):
    # Execute the SQL query
    cur.execute("""
SELECT mirna, gene, '1' AS is_target FROM mirdb_mirna_gene 
WHERE target_score > 96
ORDER BY gene
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
