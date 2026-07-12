-- Write your PostgreSQL query statement below
select sample_id, dna_sequence, species,
case when dna_sequence like 'ATG%' then 1 else 0 end as has_start,
case when dna_sequence like '%TAA'
    OR dna_sequence LIKE '%TAG'
    OR dna_sequence LIKE '%TGA' THEN 1 ELSE 0 end as has_stop,
 CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END AS has_atat,
       CASE WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 END AS has_ggg
FROM Samples;