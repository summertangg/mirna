CREATE TABLE miRNAs (
  mirna_id VARCHAR(20) PRIMARY KEY,
  description VARCHAR(500),
  disease VARCHAR(20)
);

CREATE TABLE genes (
  gene_id VARCHAR(20) PRIMARY KEY,
  description VARCHAR(200)
);

CREATE TABLE pathways (
  pathway_id smallint PRIMARY KEY,
  name VARCHAR(255)
);


CREATE TABLE mirna_gene_pathway (
  mirna VARCHAR(20),
  gene VARCHAR(20),
  pathway smallint,
  PRIMARY KEY (mirna, gene, pathway),
  FOREIGN KEY (mirna) REFERENCES mirnas (mirna_id),
  FOREIGN KEY (gene) REFERENCES genes (gene_id),
  FOREIGN KEY (pathway) REFERENCES pathways (pathway_id)
);

CREATE INDEX idx_mirnas_mirna_id ON mirnas (mirna_id);
CREATE INDEX idx_genes_gene_id ON genes (gene_id);
CREATE INDEX idx_pathways_pathway_name ON pathways (name);

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM pg_extension WHERE extname = 'tablefunc';

-- Create a table to save mirna:gene interactions from miRDB
CREATE TABLE mirdb_mirna_gene (
  mirna VARCHAR(20),
  gene VARCHAR(20),
  target_score smallint,
  PRIMARY KEY (mirna, gene),
  FOREIGN KEY (mirna) REFERENCES mirnas (mirna_id),
  FOREIGN KEY (gene) REFERENCES genes (gene_id)
);

-- Create a table to save pathway:gene interactions from KEGG
CREATE TABLE pathway_gene (
  pathway_id smallint,
  gene VARCHAR(20),
  PRIMARY KEY (pathway_id, gene),
  FOREIGN KEY (gene) REFERENCES genes (gene_id),
  FOREIGN KEY (pathway_id) REFERENCES pathways (pathway_id)
);

-- Create a table to save colors to render targetted genes depending on the number of interactions
CREATE TABLE interaction_colors (
  num_interactions smallint,
  color VARCHAR(20),
  PRIMARY KEY (num_interactions)
);

INSERT INTO interaction_colors (num_interactions, color) VALUES (1, '#FFE4E1,black');
INSERT INTO interaction_colors (num_interactions, color) VALUES (2, '#FFB6C1,black');
INSERT INTO interaction_colors (num_interactions, color) VALUES (3, '#FA8072,black');
INSERT INTO interaction_colors (num_interactions, color) VALUES (4, '#CD5C5C,black');
INSERT INTO interaction_colors (num_interactions, color) VALUES (5, '#DC143C,black');

INSERT INTO pathways (pathway_id, name) VALUES (7, 'Pathways in cancer');
INSERT INTO pathways (pathway_id, name) VALUES (8, 'Estrogen signaling pathway');
INSERT INTO pathways (pathway_id, name) VALUES (9, 'cAMP signaling pathway');
INSERT INTO pathways (pathway_id, name) VALUES (10, 'Wnt signaling pathway');
INSERT INTO pathways (pathway_id, name) VALUES (11, 'TGF-beta signaling pathway');
INSERT INTO pathways (pathway_id, name) VALUES (12, 'ECM-receptor interaction');
INSERT INTO pathways (pathway_id, name) VALUES (13, 'JAK-STAT signaling pathway');
INSERT INTO pathways (pathway_id, name) VALUES (14, 'mTOR signaling pathway');
INSERT INTO pathways (pathway_id, name) VALUES (15, 'Cytokine-cytokine receptor interaction');





