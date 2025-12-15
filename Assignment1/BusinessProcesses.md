# Kimball: Identify business processes

structural data model (#: rows, fkeys etc. = "what tables exist") => transactional events (business process = "what business events happen")

Common pattern: 
- Header tables have high outgoing FK counts because they reference many dimensions (who, what, when, where)
- Detail tables (like SalesOrderDetail) are part of the process, not separate processes.

Process vs. Supporting data
TypeExamples from Your DataRoleTransactional ProcessesSales, Purchasing, Production.WorkOrderGenerate facts, have temporal events
Master/Reference DataPerson, Product, HumanResourcesProvide context, relatively static
Supporting/BridgeBusinessEntityAddress, ProductVendorLink entities, support processes but aren't themselves processes
