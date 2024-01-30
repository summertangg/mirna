select * from mirnas 
where disease = 'DLBCL'
order by mirna_id

select * 
--delete 
from mirnas where mirna_id = 'hsa-mir-1250'

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
SELECT mirna_id, * FROM mirnas
WHERE mirna_id IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')

ORDER BY mirna_id

delete
-- SELECT mirna, gene, target_score 
FROM mirdb_mirna_gene 
WHERE mirna IN ('hsa-mir-130a')
ORDER BY target_score desc

-- delete from david_mirna_pathway where mirna='hsa-let-7d' and pathway = 'hsa05200'

-- DELETE FROM genes
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


-- get all genes targetted by 54 miRNAs target_genes_of_mirna_biomarkers_54.csv
SELECT gene, COUNT(mirna) AS num_interactions, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna
FROM mirdb_mirna_gene i
WHERE target_score >= 97
  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
group by gene
-- HAVING COUNT(mirna) >= 2
ORDER BY num_interactions desc

-- get all genes targetted by a specific miRNAs
SELECT gene, COUNT(mirna) AS num_interactions, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna
FROM mirdb_mirna_gene i
WHERE target_score >= 97
  AND mirna IN ('hsa-mir-210') 
group by gene
ORDER BY gene

SELECT DISTINCT (mirna), m.disease
FROM mirdb_mirna_gene AS i
INNER JOIN mirnas AS m on m.mirna_id = i.mirna and m.disease is  NULL
order by mirna

select count(g.gene_id)
from genes as g

select m.*, d.name 
from david_mirna_pathway AS m
inner join david as d on m.pathway = d.pathway_id
where pathway ='hsa05200'
order by mirna, p_value

"hsa-mir-130a"
"hsa-mir-15a"
"hsa-mir-24"
"hsa-mir-27a"

-- Get pathways with the mirna involved
select m.pathway, d.name, STRING_AGG(DISTINCT mirna, ',') AS grouped_mirna, count(mirna) as num_mirna
from david_mirna_pathway AS m
inner join david as d on m.pathway = d.pathway_id
group by m.pathway, d.name
order by count(mirna) desc

select * from david
order by name

-- GET interactions of specif mirnas "mirdb_interactions_m54_training.csv"
SELECT COALESCE(i.mirna, 'mir-0') AS mirna, ge.gene_id, '1' AS is_target
FROM genes AS ge
LEFT JOIN mirdb_mirna_gene AS i ON ge.gene_id = i.gene AND i.target_score >=97 
  --AND i.mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
  --AND mirna IN ('hsa-mir-125b', 'hsa-mir-143', 'hsa-mir-451b', 'hsa-mir-145', 'hsa-mir-10b', 'hsa-mir-34a', 'hsa-mir-100', 'hsa-mir-9', 'hsa-mir-155', 'hsa-mir-21', 'hsa-mir-150', 'hsa-mir-363', 'hsa-mir-223', 'hsa-mir-584', 'hsa-mir-361', 'hsa-mir-625', 'hsa-mir-495', 'hsa-mir-181a')
  AND mirna IN ('hsa-mir-10b', 'hsa-mir-155', 'hsa-let-7c', 'hsa-let-7b', 'hsa-mir-130a', 'hsa-mir-24', 'hsa-mir-27a', 'hsa-mir-18a', 'hsa-mir-15a')
UNION
SELECT COALESCE(mp.mirna, 'mir-0') AS mirna, da.pathway_id, '1' AS is_target
FROM david AS da
LEFT JOIN david_mirna_pathway AS mp ON da.pathway_id = mp.pathway 
--  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
--AND mirna IN ('hsa-mir-125b', 'hsa-mir-143', 'hsa-mir-451b', 'hsa-mir-145', 'hsa-mir-10b', 'hsa-mir-34a', 'hsa-mir-100', 'hsa-mir-9', 'hsa-mir-155', 'hsa-mir-21', 'hsa-mir-150', 'hsa-mir-363', 'hsa-mir-223', 'hsa-mir-584', 'hsa-mir-361', 'hsa-mir-625', 'hsa-mir-495', 'hsa-mir-181a')
  AND mirna IN ('hsa-mir-10b', 'hsa-mir-155', 'hsa-let-7c', 'hsa-let-7b', 'hsa-mir-130a', 'hsa-mir-24', 'hsa-mir-27a', 'hsa-mir-18a', 'hsa-mir-15a')
ORDER BY gene_id desc

SELECT * FROM genes
WHERE gene_id = 'PLACEHOLDER'

INSERT INTO genes (gene_id, description, kegg_id) VALUES ('PLACEHOLDER', 'a placeholder for mirnas without genes score >= 97', null)

SELECT *
FROM mirdb_mirna_gene
WHERE mirna IN ('hsa-mir-1250', 'hsa-mir-1915', 'hsa-mir-3912', 'hsa-mir-4804', 'hsa-mir-6782', 'hsa-mir-6822', 'hsa-mir-887')

INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-1250', 'PLACEHOLDER', 100);
INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-1915', 'PLACEHOLDER', 100);
INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-3912', 'PLACEHOLDER', 100);
INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-4804', 'PLACEHOLDER', 100);
INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-6782', 'PLACEHOLDER', 100);
INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-6822', 'PLACEHOLDER', 100);
INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-887', 'PLACEHOLDER', 100);

INSERT INTO mirdb_mirna_gene (mirna, gene, target_score) VALUES ('hsa-mir-100', 'PLACEHOLDER', 100);


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
  AND pg.pathway_id = 7
group by mg.gene, pg.gene, g.kegg_id
ORDER BY count(mg.mirna) desc, mg.gene

-- get mirna targeting genes in a pathway (m54) 
SELECT mirna, STRING_AGG(DISTINCT mg.gene, ',') AS grouped_gene, count(mg.gene) as num_gene --,
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
  AND mirna IN ('hsa-let-7d', 'hsa-let-7e', 'hsa-let-7g', 'hsa-mir-106a', 'hsa-mir-106b', 'hsa-mir-143', 'hsa-mir-146a', 'hsa-mir-146b', 'hsa-mir-150', 'hsa-mir-155', 'hsa-mir-15a', 'hsa-mir-16-1', 'hsa-mir-17', 'hsa-mir-182', 'hsa-mir-18a', 'hsa-mir-18b', 'hsa-mir-199a', 'hsa-mir-19a', 'hsa-mir-19b', 'hsa-mir-20a', 'hsa-mir-21', 'hsa-mir-210', 'hsa-mir-221', 'hsa-mir-24', 'hsa-mir-30b', 'hsa-mir-320a', 'hsa-mir-328', 'hsa-mir-139', 'hsa-mir-34a', 'hsa-mir-34b', 'hsa-mir-365a', 'hsa-mir-451b', 'hsa-mir-485', 'hsa-mir-9', 'hsa-mir-92a', 'hsa-mir-93', 'hsa-mir-181a', 'hsa-mir-217', 'hsa-mir-361', 'hsa-mir-363', 'hsa-let-7f', 'hsa-mir-20b', 'hsa-mir-26a', 'hsa-mir-26b', 'hsa-mir-29b', 'hsa-mir-29c', 'hsa-mir-125b', 'hsa-mir-145', 'hsa-mir-223', 'hsa-mir-301a', 'hsa-mir-23a', 'hsa-mir-23b', 'hsa-mir-27a', 'hsa-mir-27b')
WHERE mg.target_score >= 97
  AND pg.pathway_id = 7
group by mirna
HAVING count(mg.gene) >= 2
ORDER BY mirna

-- get mirna targeting genes in a pathway (mlawrie table 1)
SELECT mirna, STRING_AGG(DISTINCT mg.gene, ',') AS grouped_gene, count(mg.gene) as num_gene --,
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
AND mirna IN ('hsa-mir-125b', 'hsa-mir-143', 'hsa-mir-451b', 'hsa-mir-145', 'hsa-mir-10b', 'hsa-mir-34a', 'hsa-mir-100', 'hsa-mir-9', 'hsa-mir-155', 'hsa-mir-21', 'hsa-mir-150', 'hsa-mir-363', 'hsa-mir-223', 'hsa-mir-584', 'hsa-mir-361', 'hsa-mir-625', 'hsa-mir-495', 'hsa-mir-181a')
WHERE mg.target_score >= 97
  AND pg.pathway_id = 7
group by mirna
HAVING count(mg.gene) >= 2
ORDER BY mirna

-- get mirna targeting genes in a pathway (mlawrie table 2)
SELECT mirna, STRING_AGG(DISTINCT mg.gene, ',') AS grouped_gene, count(mg.gene) as num_gene --,
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
AND mirna IN ('hsa-mir-200c', 'hsa-mir-518a', 'hsa-mir-199a', 'hsa-mir-93', 'hsa-mir-22', 'hsa-mir-34a', 'hsa-mir-362', 'hsa-mir-206', 'hsa-mir-451b', 'hsa-mir-636', 'hsa-mir-92a', 'hsa-mir-27b', 'hsa-mir-199b', 'hsa-mir-27a', 'hsa-mir-24', 'hsa-mir-106a', 'hsa-mir-20a', 'hsa-mir-19b', 'hsa-mir-99a', 'hsa-mir-18b', 'hsa-mir-100')
WHERE mg.target_score >= 97
  AND pg.pathway_id = 7
group by mirna
HAVING count(mg.gene) >= 2
ORDER BY mirna

-- get mirna targeting genes in a pathway (mlarrabeiti table 1)
SELECT mirna, STRING_AGG(DISTINCT mg.gene, ',') AS grouped_gene, count(mg.gene) as num_gene --,
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
AND mirna IN ('hsa-mir-210', 'hsa-mir-944', 'hsa-mir-12136', 'hsa-mir-3681', 'hsa-mir-378i', 'hsa-mir-4454', 'hsa-mir-1291', 'hsa-mir-7974', 'hsa-mir-183', 'hsa-mir-146a', 'hsa-mir-215', 'hsa-mir-150', 'hsa-mir-224', 'hsa-mir-194', 'hsa-mir-452', 'hsa-mir-335', 'hsa-mir-145', 'hsa-mir-139', 'hsa-mir-497', 'hsa-mir-10a')
WHERE mg.target_score >= 97
  AND pg.pathway_id = 7
group by mirna
HAVING count(mg.gene) >= 2
ORDER BY mirna

-- get mirna targeting genes in a pathway (beheshti fig 1)
SELECT mirna, STRING_AGG(DISTINCT mg.gene, ',') AS grouped_gene, count(mg.gene) as num_gene --,
FROM pathway_gene AS pg
INNER JOIN genes AS g ON g.gene_id = pg.gene
INNER JOIN mirdb_mirna_gene AS mg ON mg.gene = pg.gene
AND mirna IN ('hsa-mir-10b', 'hsa-mir-155', 'hsa-let-7c', 'hsa-let-7b', 'hsa-mir-130a', 'hsa-mir-24', 'hsa-mir-27a', 'hsa-mir-18a', 'hsa-mir-15a')
WHERE mg.target_score >= 97
  AND pg.pathway_id = 7
group by mirna
HAVING count(mg.gene) >= 2
ORDER BY mirna

select * from pathways

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
WHERE pg.pathway_id = 7
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
  AND pg.pathway_id = 7
group by mg.gene, pg.gene, g.kegg_id
ORDER BY count(mg.mirna) desc, mg.gene


delete from david_mirna_pathway where mirna='hsa-let-7d' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-let-7e' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-let-7f' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-let-7g' and pathway = 'hsa05200'
hsa-mir-106a - hsa05200 already exists.
hsa-mir-106b - hsa05200 already exists.
delete from david_mirna_pathway where mirna='hsa-mir-125b' and pathway = 'hsa05200'
hsa-mir-139 - hsa05200 already exists.
delete from david_mirna_pathway where mirna='hsa-mir-145' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-146a' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-146b' and pathway = 'hsa05200'
hsa-mir-15a - hsa05200 already exists.
hsa-mir-17 - hsa05200 already exists.
delete from david_mirna_pathway where mirna='hsa-mir-181a' and pathway = 'hsa05200'
hsa-mir-182 - hsa05200 already exists.
delete from david_mirna_pathway where mirna='hsa-mir-199a' and pathway = 'hsa05200'
hsa-mir-19a - hsa05200 already exists.
hsa-mir-19b - hsa05200 already exists.
hsa-mir-20a - hsa05200 already exists.
hsa-mir-20b - hsa05200 already exists.
hsa-mir-21 - hsa05200 already exists.
delete from david_mirna_pathway where mirna='hsa-mir-221' and pathway = 'hsa05200'
hsa-mir-23a - hsa05200 already exists.
hsa-mir-23b - hsa05200 already exists.
hsa-mir-24 - hsa05200 already exists.
hsa-mir-26a - hsa05200 already exists.
hsa-mir-26b - hsa05200 already exists.
hsa-mir-27a - hsa05200 already exists.
hsa-mir-27b - hsa05200 already exists.
hsa-mir-29b - hsa05200 already exists.
hsa-mir-29c - hsa05200 already exists.
hsa-mir-301a - hsa05200 already exists.
hsa-mir-30b - hsa05200 already exists.
hsa-mir-320a - hsa05200 already exists.
hsa-mir-34a - hsa05200 already exists.
delete from david_mirna_pathway where mirna='hsa-mir-34b' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-363' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-365a' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-451b' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-9' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-92a' and pathway = 'hsa05200'
delete from david_mirna_pathway where mirna='hsa-mir-130a' and pathway = 'hsa05200'




