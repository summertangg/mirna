def insert_mirna(conn, cur, mirna_id, description):
    mirna_id = mirna_id.lower()
    print(mirna_id)
    cur.execute("SELECT COUNT(*) FROM mirnas WHERE mirna_id = %s", (mirna_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO mirnas (mirna_id, description) VALUES (%s, %s)", (mirna_id, description))
        conn.commit()
        print(f"{mirna_id} inserted successfully.")
    else:
        print(f"{mirna_id} already exists.")


def insert_pathway(conn, cur, pathway):
    print(pathway)
    cur.execute("SELECT COUNT(*) FROM pathways WHERE name = %s", (pathway,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO pathways (name) VALUES (%s)", (pathway,))
        conn.commit()
        print(f"{pathway} inserted successfully.")
    else:
        print(f"{pathway} already exists.")


def insert_gene(conn, cur, gene_id, description):
    gene_id = gene_id.upper()
    print(gene_id)
    cur.execute("SELECT COUNT(*) FROM genes WHERE gene_id = %s", (gene_id,))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO genes (gene_id, description) VALUES (%s, %s)", (gene_id, description))
        conn.commit()
        print(f"{gene_id} inserted successfully.")
    else:
        print(f"{gene_id} already exists.")


def insert_mirna_gene_interaction(conn, cur, mirna_id, gene_id, pathway_id):
    mirna_id = mirna_id.lower()
    gene_id = gene_id.upper()
    print(f"interaction: {mirna_id} - {gene_id} - {pathway_id}")
    cur.execute("SELECT COUNT(*) FROM mirna_gene_pathway WHERE mirna = %s AND gene = %s AND pathway = %s", (mirna_id, gene_id, pathway_id))
    record_count = cur.fetchone()[0]
    
    if record_count == 0:
        # Insert the record if it doesn't exist
        cur.execute("INSERT INTO mirna_gene_pathway (mirna, gene, pathway) VALUES (%s, %s, %s)", (mirna_id, gene_id, pathway_id))
        conn.commit()
        print(f"{mirna_id} - {gene_id} - {pathway_id} inserted successfully.")
    else:
        print(f"{mirna_id} - {gene_id} - {pathway_id} already exists.")
