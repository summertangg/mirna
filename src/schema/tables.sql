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

CREATE TABLE DAVID (
  pathway_id VARCHAR(20) PRIMARY KEY,
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
INSERT INTO david (pathway_id, name) VALUES ('hsa05414', 'Dilated cardiomyopathy');
INSERT INTO david (pathway_id, name) VALUES ('hsa05207', 'Chemical carcinogenesis - receptor activation');
INSERT INTO david (pathway_id, name) VALUES ('hsa05017', 'Spinocerebellar ataxia');
INSERT INTO david (pathway_id, name) VALUES ('hsa05143', 'African trypanosomiasis');
INSERT INTO david (pathway_id, name) VALUES ('hsa05330', 'Allograft rejection');
INSERT INTO david (pathway_id, name) VALUES ('hsa04940', 'Type I diabetes mellitus');
INSERT INTO david (pathway_id, name) VALUES ('hsa05200', 'Pathways in cancer');
INSERT INTO david (pathway_id, name) VALUES ('hsa04215', 'Apoptosis - multiple species');
INSERT INTO david (pathway_id, name) VALUES ('hsa04150', 'mTOR signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa04713', 'Circadian entrainment');
INSERT INTO david (pathway_id, name) VALUES ('hsa04974', 'Protein digestion and absorption');
INSERT INTO david (pathway_id, name) VALUES ('hsa04510', 'Focal adhesion');
INSERT INTO david (pathway_id, name) VALUES ('hsa04933', 'AGE-RAGE signaling pathway in diabetic complications');
INSERT INTO david (pathway_id, name) VALUES ('hsa04926', 'Relaxin signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa05165', 'Human papillomavirus infection');
INSERT INTO david (pathway_id, name) VALUES ('hsa00310', 'Lysine degradation');
INSERT INTO david (pathway_id, name) VALUES ('hsa05415', 'Diabetic cardiomyopathy');
INSERT INTO david (pathway_id, name) VALUES ('hsa05218', 'Melanoma');
INSERT INTO david (pathway_id, name) VALUES ('hsa05214', 'Glioma');
INSERT INTO david (pathway_id, name) VALUES ('hsa01521', 'EGFR tyrosine kinase inhibitor resistance');
INSERT INTO david (pathway_id, name) VALUES ('hsa04512', 'ECM-receptor interaction');
INSERT INTO david (pathway_id, name) VALUES ('hsa05222', 'Small cell lung cancer');
INSERT INTO david (pathway_id, name) VALUES ('hsa05215', 'Prostate cancer');
INSERT INTO david (pathway_id, name) VALUES ('hsa05146', 'Amoebiasis');
INSERT INTO david (pathway_id, name) VALUES ('hsa04611', 'Platelet activation');
INSERT INTO david (pathway_id, name) VALUES ('hsa04068', 'FoxO signaling pathway');
INSERT INTO david (pathway_id, name) VALUES ('hsa04360', 'Axon guidance');
INSERT INTO david (pathway_id, name) VALUES ('hsa05168', 'Herpes simplex virus 1 infection');
INSERT INTO david (pathway_id, name) VALUES ('hsa04916', 'Melanogenesis');

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-let-7d', 'hsa05206', 0.00450);
INSERT INTO DAVID_mirna_pathway (mirna, pathway) VALUES ('hsa-let-7e', 'hsa05206');
INSERT INTO DAVID_mirna_pathway (mirna, pathway) VALUES ('hsa-let-7g', 'hsa05206');
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-let-7f', 'hsa05206', 0.0061);

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
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05169', 0.046);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05417', 0.049);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-146a', 'hsa05170', 0.048);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-155', 'hsa04550', 0.033);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa05226', 0.0079);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa04014', 0.036);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa04120', 0.039);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa04151', 0.041);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-15a', 'hsa05224', 0.043);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-17', 'hsa05219', 0.012);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-17', 'hsa04010', 0.032);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-19b', 'hsa05414', 0.020);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-19b', 'hsa05207', 0.032);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-19b', 'hsa05017', 0.047);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-20b', 'hsa05219', 0.012);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-20b', 'hsa04010', 0.032);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-21', 'hsa05143', 0.025);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-21', 'hsa05330', 0.026);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-21', 'hsa04940', 0.029);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-21', 'hsa05200', 0.048);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-24', 'hsa04215', 0.033);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-26a', 'hsa04150', 0.0052);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-26b', 'hsa04150', 0.0052);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-27b', 'hsa04722', 0.0079);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-27b', 'hsa04713', 0.044);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04974', 0.000);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04510', 0.00013);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04151', 0.0018);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04933', 0.002);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04926', 0.0041);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa05165', 0.0089);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa00310', 0.011);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa05415', 0.014);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa05218', 0.014);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa05214', 0.015);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa01521', 0.017);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04512', 0.021);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa05222', 0.023);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa05215', 0.025);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa05146', 0.027);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04611', 0.039);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29b', 'hsa04068', 0.043);


INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04974', 0.000);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04510', 0.00013);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04151', 0.0018);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04933', 0.002);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04926', 0.0041);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa05165', 0.0089);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa00310', 0.011);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa05415', 0.014);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa05218', 0.014);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa05214', 0.015);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa01521', 0.017);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04512', 0.021);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa05222', 0.023);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa05215', 0.025);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa05146', 0.027);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04611', 0.039);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-29c', 'hsa04068', 0.043);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-93', 'hsa05219', 0.012);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-93', 'hsa04010', 0.032);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-106a', 'hsa05219', 0.012);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-106a', 'hsa04010', 0.035);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-106b', 'hsa05219', 0.016);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-145', 'hsa04360', 0.00028);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-181a', 'hsa05168', 0.00053);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-182', 'hsa04916', 0.00029);

INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-182', 'hsa05168', 0.00053);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-182', 'hsa05168', 0.00053);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-182', 'hsa05168', 0.00053);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-182', 'hsa05168', 0.00053);
INSERT INTO DAVID_mirna_pathway (mirna, pathway, p_value) VALUES ('hsa-mir-182', 'hsa05168', 0.00053);









