--Get table's comments aka. descriptions (MS_Description)
-- Check for extended properties on "Status" column
SELECT 
    objname AS ColumnName,
    value AS Description
FROM sys.fn_listextendedproperty(
    'MS_Description', 
    'SCHEMA', '<SchemaName: Sales>', 
    'TABLE', '<TableName: SalesOrderHeader>', 
    'COLUMN', '<ColumnName: Status>'
);
