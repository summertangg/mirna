CREATE TABLE miRNAs (
  mirna_id VARCHAR(20) PRIMARY KEY,
  description VARCHAR(500)
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



