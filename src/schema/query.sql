select * from mirnas 
where disease = 'DLBCL'
order by mirna_id

--delete from mirnas where mirna_id = 'hsa-mir-585'

SELECT COUNT(*) FROM mirnas WHERE mirna_id = 'hsa-mir-155-3p'

insert into mirnas (mirna_id, description) values ('pigu','ligu')

-- update mirnas
-- set description='MIR19A (MicroRNA 19a) is an RNA Gene, and is affiliated with the miRNA class. Diseases associated with MIR19A include Thyroid Gland Anaplastic Carcinoma and Myeloma, Multiple. Among its related pathways are miRNA role in immune response in sepsis and miRNAs involved in DNA damage response.'
-- where mirna_id like 'hsa-mir-19a%'

select * from genes
where gene_id = 'TRIM25'

select * from pathways

select * from mirna_gene_pathway
order by gene


select mirna, gene from mirna_gene_pathway 
where mirna = 'hsa-mir-155-5p' and pathway < 1
group by mirna, gene
order by gene



select gene, count(mirna) as gene_count from mirna_gene_pathway 
group by gene order by gene_count desc


select count(*)
from genes

select g.gene_id, t.mirna, count(t.pathway)
from genes as g
left join mirna_gene_pathway as t
  on g.gene_id = t.gene and t.mirna = 'hsa-mir-17-3p'
group by g.gene_id, t.mirna
order by g.gene_id

-- get all gene:miRNA interactions 
-- and count could be the value of the gene descriptor
select gene, mirna, count(pathway)
from mirna_gene_pathway
group by gene, mirna
order by gene

-- get genes with the most interactions
SELECT gene, COUNT(mirna) AS num_interaction, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna,
  STRING_AGG(DISTINCT p.name, ',') AS grouped_pathways
  -- ARRAY_TO_STRING(ARRAY_AGG(DISTINCT pathway), ',') AS grouped_pathway
FROM mirna_gene_pathway AS t
LEFT JOIN pathways AS p on p.pathway_id = t.pathway and p.pathway_id > 0
GROUP BY gene
ORDER BY num_interaction DESC;

select * from mirna_gene_pathway
where gene = 'BCL2' and mirna = 'hsa-mir-17-5p'


-- get pathways with the most interactions
SELECT pathway, p.name, COUNT(gene) AS num_interaction, 
  COUNT(DISTINCT mirna) AS num_mirna, 
  STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna
FROM mirna_gene_pathway AS t
JOIN pathways AS p on p.pathway_id = t.pathway and p.pathway_id > 0
GROUP BY pathway, p.name
ORDER BY num_interaction DESC;


select gene, count(mirna) from mirna_gene_pathway
where pathway = 4
group by gene
order by gene


------------------
--	miRDB
------------------
SELECT mirna_id, disease FROM mirnas
ORDER BY mirna_id

SELECT mirna, gene, target_score 
FROM mirdb_mirna_gene 
WHERE mirna IN ('hsa-mir-215')
ORDER BY target_score desc

DELETE FROM genes
WHERE gene_id NOT IN (
	SELECT gene
	FROM mirdb_mirna_gene
	GROUP BY gene
	union
	SELECT gene
	FROM pathway_gene
	GROUP BY gene
	union
	select gene
	from mirna_gene_pathway
	group by gene
)

select count(gene_id)
from genes


-- delete FROM mirdb_mirna_gene
-- where mirna = 'hsa-mir-551b'


-- get all genes targetted by 54 miRNAs
SELECT gene, COUNT(mirna) AS num_interactions, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna
FROM mirdb_mirna_gene i
INNER JOIN mirnas AS m on m.mirna_id = i.mirna and m.disease is not NULL
WHERE target_score >= 97
  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
group by gene
ORDER BY num_interactions desc

SELECT DISTINCT (mirna) --, m.disease
FROM mirdb_mirna_gene AS i
INNER JOIN mirnas AS m on m.mirna_id = i.mirna and m.disease is  NULL
order by mirna

select count(g.gene_id)
from genes as g

-- GET interactions of specif mirnas
SELECT COALESCE(i.mirna, 'mir-0') AS mirna, ge.gene_id, '1' AS is_target
FROM genes AS ge
LEFT JOIN mirdb_mirna_gene AS i ON ge.gene_id = i.gene AND i.target_score >=97 
  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
ORDER BY ge.gene_id

select * from pathways

SELECT pathway_id, count(gene)
FROM pathway_gene
group by pathway_id

-- get pathway genes targeted by miRNAs 
SELECT g.kegg_id, mg.gene, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna, count(mg.mirna) as num_mirna --,
-- 	CASE
-- 	  WHEN count(mg.mirna) >= 10 THEN '#DC143C,black'
-- 	  WHEN count(mg.mirna) >= 6 AND count(mg.mirna) < 10 THEN '#CD5C5C,black'
-- 	  WHEN count(mg.mirna) >= 4 AND count(mg.mirna) < 6 THEN '#FA8072,black'
-- 	  WHEN count(mg.mirna) >= 2 AND count(mg.mirna) < 4 THEN '#FFB6C1,black'
-- 	  ELSE '#FFE4E1,black'
-- 	END AS color
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
INNER JOIN mirnas AS m on m.mirna_id = mg.mirna and m.disease is not NULL
WHERE mg.target_score >= 97
  AND pg.pathway_id = 3
group by mg.gene, pg.gene, g.kegg_id
ORDER BY count(mg.mirna) desc, mg.gene

SELECT t.kegg_id, c.color --t.* 
FROM interaction_colors AS c
INNER JOIN (
	SELECT g.kegg_id, mg.gene, count(mg.mirna) AS num_mirna, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna
	FROM pathway_gene AS pg
	INNER JOIN genes AS g ON g.gene_id = pg.gene
	INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
	INNER JOIN mirnas AS m on m.mirna_id = mg.mirna and m.disease is not NULL
	WHERE mg.target_score >= 97
	  AND pg.pathway_id = 1
	group by mg.gene, pg.gene, g.kegg_id
	ORDER BY num_mirna DESC
	) AS t ON c.num_interactions = t.num_mirna
order by t.num_mirna desc, t.gene

select * from interaction_colors

---------------------------------------------
-- find the mirnas in a pathway
SELECT mg.mirna, count(mg.gene) AS num_genes, min(pg.pathway_id)
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
  AND mg.target_score >= 97
WHERE pg.pathway_id = 15
GROUP BY mg.mirna
ORDER BY num_genes desc

-- find the genes targeted by miRNAs in a pathway
SELECT g.kegg_id, mg.gene, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna, count(mg.mirna) as num_mirna --,
-- 	CASE
-- 	  WHEN count(mg.mirna) >= 10 THEN '#DC143C,black'
-- 	  WHEN count(mg.mirna) >= 6 AND count(mg.mirna) < 10 THEN '#CD5C5C,black'
-- 	  WHEN count(mg.mirna) >= 4 AND count(mg.mirna) < 6 THEN '#FA8072,black'
-- 	  WHEN count(mg.mirna) >= 2 AND count(mg.mirna) < 4 THEN '#FFB6C1,black'
-- 	  ELSE '#FFE4E1,black'
-- 	END AS color
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
INNER JOIN mirnas AS m on m.mirna_id = mg.mirna and m.disease is not NULL
WHERE mg.target_score >= 97
  AND pg.pathway_id = 15
group by mg.gene, pg.gene, g.kegg_id
ORDER BY count(mg.mirna) desc, mg.gene



