--MSSQL
-- Get comprehensive index inventory across all schemas
SELECT 
    SCHEMA_NAME(t.schema_id) AS SchemaName,
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique AS IsUnique,
    i.is_primary_key AS IsPrimaryKey,
    (ps.reserved_page_count * 8.0 / 1024) AS IndexSizeMB
FROM sys.indexes i
INNER JOIN sys.tables t ON i.object_id = t.object_id
INNER JOIN sys.dm_db_partition_stats ps ON i.object_id = ps.object_id 
    AND i.index_id = ps.index_id
WHERE t.is_ms_shipped = 0
ORDER BY SchemaName, TableName, i.index_id;
