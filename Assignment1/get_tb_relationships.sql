--MSSQL
--Purpose: (for each table)
-- Count incoming/outgoing fkeys
-- Count the number of rows
SELECT
    s.name  AS schema_name,
    t.name  AS table_name,

    /* Incoming FKs: other tables reference this table */
    COUNT(DISTINCT fk_in.object_id)  AS incoming_fk_count,

    /* Outgoing FKs: this table references others */
    COUNT(DISTINCT fk_out.object_id) AS outgoing_fk_count,

    /* Row counts */
    SUM(p.rows) AS row_count

FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
JOIN sys.partitions p
    ON t.object_id = p.object_id
/* Incoming FKs */
LEFT JOIN sys.foreign_keys fk_in
    ON fk_in.referenced_object_id = t.object_id

/* Outgoing FKs */
LEFT JOIN sys.foreign_keys fk_out
    ON fk_out.parent_object_id = t.object_id

WHERE p.index_id IN (0,1)   -- heap or clustered index

GROUP BY
    s.name,
    t.name

ORDER BY
    row_count DESC,
    incoming_fk_count DESC,
    outgoing_fk_count DESC;
