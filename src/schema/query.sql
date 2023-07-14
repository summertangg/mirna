select * from mirnas 
where mirna_id = 'hsa-mir-155-3p'

SELECT COUNT(*) FROM mirnas WHERE mirna_id = 'hsa-mir-155-3p'

insert into mirnas (mirna_id, description) values ('pigu','ligu')

-- update mirnas
-- set description='MIR19A (MicroRNA 19a) is an RNA Gene, and is affiliated with the miRNA class. Diseases associated with MIR19A include Thyroid Gland Anaplastic Carcinoma and Myeloma, Multiple. Among its related pathways are miRNA role in immune response in sepsis and miRNAs involved in DNA damage response.'
-- where mirna_id like 'hsa-mir-19a%'

select * from genes
where gene_id = 'DICER1'

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
SELECT mirna, gene, 1 AS is_target FROM mirdb_mirna_gene
ORDER BY gene


