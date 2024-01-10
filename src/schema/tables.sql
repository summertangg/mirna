CREATE TABLE miRNAs (
  mirna_id VARCHAR(20) PRIMARY KEY,
  description VARCHAR(500),
  disease VARCHAR(20)
);

CREATE TABLE genes (
  gene_id VARCHAR(20) PRIMARY KEY,
  description VARCHAR(200)
);

CREATE TABLE DAVID (
  pathway_id VARCHAR(20) PRIMARY KEY,
  name VARCHAR(255)
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

-- Create a table to save mirna:pathway interactions from DAVID
CREATE TABLE DAVID_mirna_pathway (
  mirna VARCHAR(20),
  pathway VARCHAR(20),
  PRIMARY KEY (mirna, pathway),
  FOREIGN KEY (mirna) REFERENCES mirnas (mirna_id),
  FOREIGN KEY (pathway) REFERENCES DAVID (pathway_id)
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

INSERT INTO david (pathway_id, name) VALUES ('hsa05206', 'MicroRNAs in cancer');
INSERT INTO david (pathway_id, name) VALUES ('hsa05219', 'Bladder cancer');
INSERT INTO david (pathway_id, name) VALUES ('hsa04010', 'MAPK signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa05133', 'Pertussis');
INSERT INTO david (pathway_id, name) VALUES ('hsa05140', 'Leishmaniasis');
INSERT INTO david (pathway_id, name) VALUES ('hsa05142', 'Chagas disease');
INSERT INTO david (pathway_id, name) VALUES ('hsa04064', 'NF-kappa B signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa04620', 'Toll-like receptor signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa05145', 'Toxoplasmosis');
INSERT INTO david (pathway_id, name) VALUES ('hsa04722', 'Neurotrophin signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa05135', 'Yersinia infection');
INSERT INTO david (pathway_id, name) VALUES ('hsa05162', 'Measles');
INSERT INTO david (pathway_id, name) VALUES ('hsa04936', 'Alcoholic liver disease');
INSERT INTO david (pathway_id, name) VALUES ('hsa05161', 'Hepatitis B');
INSERT INTO david (pathway_id, name) VALUES ('hsa05152', 'Tuberculosis');
INSERT INTO david (pathway_id, name) VALUES ('hsa05130', 'Pathogenic Escherichia coli infection');
INSERT INTO david (pathway_id, name) VALUES ('hsa05169', 'Epstein-Barr virus infection');
INSERT INTO david (pathway_id, name) VALUES ('hsa05170', 'Human immunodeficiency virus 1 infection');
INSERT INTO david (pathway_id, name) VALUES ('hsa05417', 'Lipid and atherosclerosis');
INSERT INTO david (pathway_id, name) VALUES ('hsa04550', 'Signaling pathways regulating pluripotency of stem cells');
INSERT INTO david (pathway_id, name) VALUES ('hsa05226', 'Gastric cancer');
INSERT INTO david (pathway_id, name) VALUES ('hsa04014', 'Ras signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa04120', 'Ubiquitin mediated proteolysis');
INSERT INTO david (pathway_id, name) VALUES ('hsa04151', 'PI3K-Akt signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa05224', 'Breast cancer');

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-let-7d', 'hsa05206', 0.00450);
INSERT INTO DAVID_mirna_pathway (mirna, pathway) VALUES ('hsa-let-7e', 'hsa05206');
INSERT INTO DAVID_mirna_pathway (mirna, pathway) VALUES ('hsa-let-7g', 'hsa05206');
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-106a', 'hsa05219', 0.012);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-106a', 'hsa04010', 0.035);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-106b', 'hsa05219', 0.016);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05133', 0.018);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05140', 0.018);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05142', 0.023);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa04064', 0.024);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa04620', 0.025);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05145', 0.026);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa04722', 0.027);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05135', 0.031);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05162', 0.032);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa04936', 0.033);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05161', 0.037);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05152', 0.041);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05130', 0.045);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05170', 0.046);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05417', 0.049);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-155', 'hsa04550', 0.033);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa05226', 0.0079);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa04014', 0.036);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa04120', 0.039);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa04151', 0.041);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa05224', 0.043);





