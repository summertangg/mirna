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

def insert_gene(conn, cur, gene_id, description):
    gene_id = gene_id.upper()
    print(gene_id)
    cur.execute("SELECT COUNT(*) FROM genes WHERE gene_id = %s", (gene_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO genes (gene_id, description) VALUES (%s, %s)", (gene_id, description))
        print(f"{gene_id} inserted successfully.")
    else:
        cur.execute("UPDATE genes SET description = %s WHERE gene_id = %s", (description, gene_id))
        print(f"{gene_id} is updated with new description: {description}.")
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
ORDER BY gene
""")

    # Fetch all the query results
    results = cur.fetchall()
    return results