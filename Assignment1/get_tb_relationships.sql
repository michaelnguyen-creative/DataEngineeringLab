--MSSQL
SELECT
    s.name  AS schema_name,
    t.name  AS table_name,

    /* Incoming FKs: other tables reference this table */
    COUNT(DISTINCT fk_in.object_id)  AS incoming_fk_count,

    /* Outgoing FKs: this table references others */
    COUNT(DISTINCT fk_out.object_id) AS outgoing_fk_count

FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id

/* Incoming FKs */
LEFT JOIN sys.foreign_keys fk_in
    ON fk_in.referenced_object_id = t.object_id

/* Outgoing FKs */
LEFT JOIN sys.foreign_keys fk_out
    ON fk_out.parent_object_id = t.object_id

GROUP BY
    s.name,
    t.name

ORDER BY
    incoming_fk_count DESC,
    outgoing_fk_count DESC;
