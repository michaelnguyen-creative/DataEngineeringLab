# **Project 1: Enterprise Data Warehouse**
## **Assignment Requirements**

---

## **📋 Project Overview**

### **Context**
You have inherited the AdventureWorks2022 OLTP database - a fully operational transactional system supporting a bicycle manufacturing and sales company. The system handles Sales, Purchasing, Manufacturing, Inventory, and HR operations.

### **Challenge**
The business needs analytical capabilities to support strategic decision-making, but the OLTP system is optimized for transactions, not analytics. Your task is to build an enterprise data warehouse following industry-standard methodologies.

### **Objective**
Design and implement a production-ready data warehouse that:
1. Analyzes the existing OLTP system to understand business processes
2. Plans enterprise architecture using dimensional modeling principles
3. Implements a dimensional data mart for the highest-priority business process
4. Demonstrates measurable improvement over querying OLTP directly
5. Creates a foundation for future enterprise data warehouse expansion

### **Timeline**
7 days intensive (40-50 hours total effort)

### **Outcome**
Portfolio-ready GitHub repository demonstrating enterprise data warehouse capabilities suitable for data engineering roles.

---

## **🎯 Learning Objectives**

**You will demonstrate mastery of**:

**Enterprise Analysis**:
- Reverse-engineering business processes from existing database schemas
- Systematic business process prioritization using quantitative criteria
- Data quality assessment and profiling
- Enterprise architecture planning

**Data Warehouse Methodologies**:
- Kimball's Bus Matrix and conformed dimension architecture
- Kimball's 4-step dimensional design process
- Understanding of Inmon vs. Kimball approaches
- Slowly Changing Dimension (SCD) patterns

**Technical Implementation**:
- Star schema design with proper grain declaration
- ETL development for dimension and fact loading
- Data validation and reconciliation
- Query performance optimization

**Professional Practices**:
- Design documentation with clear justification
- Reproducible technical artifacts
- Strategic thinking and trade-off analysis
- Communication of technical work to business stakeholders

---

## **📦 Required Deliverables**

### **Phase 0: Enterprise Analysis & Planning**

#### **D1: OLTP System Analysis** (`docs/oltp_analysis.md`)

**Requirement**: Analyze AdventureWorks OLTP to identify business processes and assess data readiness.

**Must Include**:
- **Schema exploration**: Document all major schema areas (Sales, Purchasing, Production, etc.)
- **Business process identification**: List 5-7 distinct transactional processes with descriptions
- **Table mapping**: Map each process to its source tables
- **Data profiling results**: Record counts, date ranges, data quality assessment
- **Master data inventory**: List key entities (Customer, Product, Employee, etc.) with row counts

**Success Criteria**:
- All major business processes identified from schema analysis
- Each process has clear transactional event description
- Data quality issues documented with evidence (queries/screenshots)
- Quantitative metrics provided (row counts, date ranges, completeness %)

---

#### **D2: Enterprise Data Warehouse Bus Matrix** (`docs/bus_matrix.md`)

**Requirement**: Create Kimball bus matrix showing dimensional integration across business processes.

**Must Include**:
- **Conformed dimension definitions**: Table of 8-12 dimensions with grain and source
- **Bus matrix**: Grid showing which dimensions apply to which processes
- **Conformity analysis**: Identify highly conformed vs. process-specific dimensions
- **Integration opportunities**: Document how dimensions enable cross-process analysis

**Success Criteria**:
- Matrix covers all identified business processes
- Dimensions defined at consistent grain across processes
- Conformed dimensions explicitly identified
- Analysis explains which dimensions have highest strategic value

---

#### **D3: Business Process Prioritization** (`docs/prioritization.md`)

**Requirement**: Systematically rank processes to determine implementation priority.

**Must Include**:
- **Scoring matrix**: Rate each process on 5 criteria (1-5 scale each)
  - Business Impact
  - Data Readiness  
  - Feasibility
  - Stakeholder Demand
  - Architectural Value
- **Detailed justification**: Paragraph explaining each score with evidence
- **Recommendation**: Clear statement of which process to build first
- **Trade-off analysis**: What you're NOT building and why

**Success Criteria**:
- All processes scored with transparent methodology
- Scores justified with specific evidence from OLTP analysis
- Decision is data-driven, not assumed
- Runner-up options acknowledged
- Links architectural value to bus matrix (conformed dimensions)

---

#### **D4: Architecture Decision** (`docs/architecture.md`)

**Requirement**: Define data warehouse architecture approach.

**Must Include**:
- **Approach selection**: Pure Kimball / Pure Inmon / Hybrid (choose and justify)
- **Architecture diagram**: Show data flow from OLTP → DW → Analytics
- **Layer definitions**: Explain each layer's purpose (staging, integration, dimensional, etc.)
- **Database design**: Schema organization or multi-database strategy
- **Methodology rationale**: Why this approach for this project

**Success Criteria**:
- Explicit architecture choice with clear justification
- Diagram shows complete data flow
- Aligns with stated Inmon/Kimball principles
- Scope is realistic for 1-week implementation
- Acknowledges production vs. learning trade-offs

---

### **Phase 1: Dimensional Model Design**

#### **D5: Dimensional Model Specification** (`docs/dimensional_design.md`)

**Requirement**: Apply Kimball's 4-step process to design dimensional model for selected business process.

**Must Include**:

**Step 1 - Business Process**:
- Process name and scope
- Source tables from OLTP
- Business questions this warehouse will answer (minimum 5)

**Step 2 - Grain Declaration**:
- Explicit grain statement: "One row represents [specific event]"
- Justification: Why this grain? What does it enable/prevent?
- Grain validation: Confirm all facts align with declared grain

**Step 3 - Dimensions** (minimum 5):
- Table listing each dimension with:
  - Purpose in business terms
  - Grain level
  - Key attributes (minimum 5 per dimension)
  - SCD Type (with justification)
  - Source table mapping
- Detailed design for each dimension (attributes, data types, hierarchies)
- Identification of which dimensions are conformed (per bus matrix)

**Step 4 - Facts** (minimum 5):
- Table listing each measure with:
  - Business meaning
  - Data type
  - Additivity classification (additive/semi-additive/non-additive)
  - Source column/calculation
- Degenerate dimensions (transaction IDs for drill-through)

**Supporting Artifacts**:
- **Star schema diagram**: ERD showing fact center with radiating dimensions
  - Tool options: DBML, Mermaid, draw.io, Lucidchart
  - Must show: primary keys, foreign keys, key attributes
- **Design validation**: Demonstrate model answers all business questions

**Success Criteria**:
- All 4 Kimball steps explicitly completed
- Grain is atomic (lowest reasonable detail level)
- Minimum 5 dimensions, each with 5+ business-meaningful attributes
- SCD type justified for each dimension (not arbitrary)
- Facts correctly classified by additivity
- Star schema diagram clear and accurate
- Conformed dimensions link to bus matrix
- Model demonstrably answers business requirements

---

### **Phase 2: Physical Implementation**

#### **D6: Database Schema** (`schema/*.sql`)

**Requirement**: Create physical database objects for dimensional model.

**Must Include**:
- **DDL for all dimension tables**:
  - Surrogate primary keys (system-generated)
  - Natural/business keys preserved
  - SCD Type 2 columns where applicable (EffectiveDate, ExpirationDate, IsCurrent)
  - Appropriate data types and constraints
  - Indexes on foreign key and frequently filtered columns
  
- **DDL for fact table(s)**:
  - Foreign keys to all dimensions
  - Fact measures (no NULLs in measures)
  - Degenerate dimensions
  - Computed columns where appropriate
  - Covering indexes for common query patterns

**Success Criteria**:
- Schema matches dimensional design specification
- All constraints defined (PK, FK, NOT NULL, CHECK)
- Indexing strategy supports analytical queries
- Code is well-commented explaining design decisions
- Scripts are executable and idempotent (can run repeatedly)

---

#### **D7: ETL Processes** (`etl/*.sql`)

**Requirement**: Build data loading processes from OLTP to dimensional warehouse.

**Must Include**:
- **Dimension loading scripts** (one per dimension):
  - Date dimension generation with calendar + fiscal attributes
  - SCD Type 1 implementation (update-in-place logic)
  - SCD Type 2 implementation (version history with effective dates)
  - Data transformations (denormalization, calculated fields, lookups)
  - NULL handling and data cleansing
  
- **Fact loading script**:
  - Surrogate key lookups to dimensions
  - SCD Type 2 temporal joins (correct historical version)
  - Business rule calculations
  - Degenerate dimension population
  - Error handling for missing dimension lookups

**Success Criteria**:
- All dimensions successfully populated from OLTP
- SCD Type 1 correctly overwrites on change
- SCD Type 2 creates new versions with proper date tracking
- Fact table has no orphaned foreign keys
- Data reconciles with source (see D8)
- Code handles edge cases (NULLs, missing lookups, data type issues)

---

### **Phase 3: Analytics & Validation**

#### **D8: Data Validation Report** (`docs/validation.md`)

**Requirement**: Prove data warehouse integrity and accuracy.

**Must Include**:
- **Row count reconciliation**: Source vs. target for all tables
- **Measure reconciliation**: Sum of facts matches OLTP (to the penny)
- **Referential integrity check**: No orphaned foreign keys
- **SCD Type 2 validation**: No duplicate "current" versions per natural key
- **Data quality assessment**: NULL analysis, invalid values, business rule compliance
- **Validation queries**: SQL scripts with results documented

**Success Criteria**:
- 100% row count match for initial load (or discrepancies explained)
- Revenue/quantity totals reconcile exactly with OLTP
- Zero referential integrity violations
- All SCD Type 2 dimensions pass uniqueness test
- Data quality issues documented with remediation approach

---

#### **D9: Analytical Queries** (`analytics/business_queries.sql`)

**Requirement**: Demonstrate warehouse value through analytical SQL.

**Must Include Minimum 5 Queries Covering**:
1. **Time series analysis**: Trends over periods (monthly/quarterly sales)
2. **Ranking/Top N**: Best performers (products, customers, territories)
3. **Comparative analysis**: Year-over-year, territory vs. territory
4. **Drill-down**: Category → Subcategory → Product detail
5. **Calculated metrics**: Growth rates, running totals, moving averages

**Each Query Must Have**:
- Business question as comment header
- Clear, readable SQL with meaningful aliases
- Results in business-friendly format
- Demonstrates star schema efficiency (≤3 table joins)

**Success Criteria**:
- All 5 analytical patterns represented
- Queries answer business questions from requirements
- Results validate against business logic (no anomalies)
- SQL demonstrates dimensional model advantages over OLTP
- Code is production-quality (formatted, commented)

---

#### **D10: Performance Benchmark** (`docs/performance.md`)

**Requirement**: Quantify DW performance improvement over OLTP queries.

**Must Include**:
- **Test query selection**: Same analytical question answered both ways
- **OLTP query**: Normalized schema with multiple joins
- **DW query**: Star schema with simple joins
- **Metrics comparison**:
  - Execution time (milliseconds)
  - Logical reads (I/O operations)
  - CPU time
  - Query plan complexity (number of operators, join types)
- **Execution plans**: Actual query plans analyzed (seek vs. scan, join types)
- **Analysis**: Explanation of why DW is faster (fewer joins, denormalization, indexes)

**Success Criteria**:
- Same business question answered identically
- Results match exactly (validates correctness)
- Measurable performance improvement documented
- Metrics captured with evidence (SQL Server statistics, screenshots)
- Analysis explains root causes, not just symptoms

---

### **Phase 4: Documentation & Polish**

#### **D11: Project README** (`README.md`)

**Requirement**: Portfolio-ready project overview.

**Must Include**:
- **Business context**: Problem statement and solution overview
- **Architecture diagram**: Visual or text-based data flow
- **Key features**: Highlights (SCD types, conformed dimensions, performance gains)
- **Quick start guide**: Setup instructions enabling reproduction
- **Sample queries**: 2-3 query examples with business context
- **Performance highlights**: Key metrics in summary table
- **Data model summary**: Link to detailed design docs
- **Project structure**: Directory tree with descriptions
- **Extensions**: Future enhancement ideas
- **References**: Methodologies, tools, data sources
- **Author/Contact**: Professional links (LinkedIn, portfolio, email)

**Success Criteria**:
- Clear business value proposition stated upfront
- Technical and non-technical readers both served
- Setup instructions are complete and testable
- Professional presentation (formatting, visuals, organization)
- Demonstrates strategic thinking, not just coding

---

#### **D12: Reflection Essay** (`docs/reflection.md`)

**Requirement**: Document your learning journey and design decisions.

**Must Address**:

**OLTP Analysis**:
- What surprised you about AdventureWorks structure?
- Which processes were difficult to identify? Why?
- What data quality issues did you encounter?

**Bus Matrix & Prioritization**:
- Did systematic analysis change your initial assumptions?
- Which dimensions had the most strategic value?
- What trade-offs did prioritization force?

**Architecture Decision**:
- Why Kimball vs. Inmon vs. Hybrid for this project?
- How would this decision change in real enterprise?
- What did you sacrifice for learning value vs. production readiness?

**Dimensional Design**:
- Which SCD type decisions were hardest? Why?
- How does your design enable future processes?
- What would you do differently if starting over?

**Technical Challenges**:
- What ETL problems did you encounter? How solved?
- How did you validate correctness?
- What performance issues emerged?

**Business Value**:
- How does this DW actually help business users?
- What questions couldn't be answered before?
- How would you demonstrate ROI to executives?

**Length**: 3-5 pages (1,500-2,500 words)

**Success Criteria**:
- Demonstrates deep engagement with methodology, not surface application
- Shows critical thinking about design trade-offs
- Connects technical decisions to business outcomes
- Acknowledges both successes and challenges
- Professional writing quality

---

## **✅ Acceptance Criteria Summary**

### **Minimum Viable Deliverables** (Must Complete):
- [ ] OLTP analysis with 5+ business processes identified
- [ ] Bus matrix with 8+ conformed dimensions
- [ ] Prioritization matrix with justified scores
- [ ] Architecture decision documented
- [ ] Dimensional design following 4-step Kimball process
- [ ] Star schema diagram (ERD)
- [ ] Physical schema DDL scripts
- [ ] ETL scripts for all dimensions and facts
- [ ] Data validation report showing 100% reconciliation
- [ ] 5+ analytical queries demonstrating different patterns
- [ ] Performance benchmark (OLTP vs. DW)
- [ ] Professional README with setup instructions
- [ ] Reflection essay (3+ pages)

### **Quality Standards**:
- [ ] All design decisions justified with evidence/reasoning
- [ ] Code is production-quality (formatted, commented, error-handled)
- [ ] Documentation enables reproduction by another data professional
- [ ] Quantitative metrics support all claims (performance, data quality)
- [ ] Professional presentation suitable for portfolio/GitHub

### **Portfolio Differentiators** (Choose 2+):
- [ ] Interactive dashboard (Power BI, Tableau)
- [ ] dbt transformation layer with tests
- [ ] Docker containerization for reproducible environment
- [ ] CI/CD pipeline (GitHub Actions) with automated validation
- [ ] Multiple fact tables (2+ business processes)
- [ ] Advanced dimensional patterns (bridge tables, mini-dimensions)
- [ ] Blog post or video explaining design decisions
- [ ] Deployment to cloud platform (Azure SQL, Snowflake)

---

## **🛠 Technology Stack**

### **Required**:
- **Database Platform** (choose one):
  - SQL Server 2019+ (recommended - native AdventureWorks)
  - PostgreSQL 12+ (requires AdventureWorks port)
  - Azure SQL Database (cloud option)
- **SQL Development**: Any SQL IDE (SSMS, Azure Data Studio, DBeaver, pgAdmin)
- **Diagramming**: draw.io, Lucidchart, DBML, or Mermaid
- **Version Control**: Git + GitHub

### **Optional**:
- **BI Tools**: Power BI Desktop, Tableau Public
- **Modern ETL**: dbt (data build tool)
- **Containerization**: Docker + Docker Compose
- **Orchestration**: Apache Airflow, Prefect
- **Cloud Platforms**: Azure, AWS, GCP

### **Methodology References**:
- **Kimball**: "The Data Warehouse Toolkit" (3rd Edition) - Chapters 1-4
- **Inmon**: "Building the Data Warehouse" (4th Edition)
- **AdventureWorks**: Microsoft SQL Server sample database

---

## **📊 Project Structure**

**Recommended GitHub Repository Layout**:
```
adventure-works-dw/
├── README.md                           # Project overview & quick start
├── LICENSE                             # MIT or appropriate license
├── .gitignore                          # Exclude *.bak, *.log, credentials
│
├── docs/
│   ├── oltp_analysis.md               # D1: OLTP system analysis
│   ├── bus_matrix.md                  # D2: Enterprise bus matrix
│   ├── prioritization.md              # D3: Business process ranking
│   ├── architecture.md                # D4: Architecture decision
│   ├── dimensional_design.md          # D5: 4-step Kimball design
│   ├── validation.md                  # D8: Data quality report
│   ├── performance.md                 # D10: Benchmark results
│   ├── reflection.md                  # D12: Learning reflection
│   └── images/
│       ├── architecture_diagram.png
│       └── star_schema.png
│
├── schema/
│   ├── 01_create_dimensions.sql       # D6: Dimension DDL
│   ├── 02_create_facts.sql            # D6: Fact DDL
│   └── 99_drop_all.sql                # Cleanup script
│
├── etl/
│   ├── 01_load_dim_date.sql           # D7: Date dimension
│   ├── 02_load_dim_customer.sql       # D7: SCD Type 1 example
│   ├── 03_load_dim_product.sql        # D7: SCD Type 2 example
│   ├── 04_load_dim_territory.sql      # D7: Additional dimensions
│   ├── 05_load_dim_employee.sql
│   └── 06_load_fact_sales.sql         # D7: Fact loading
│
├── analytics/
│   ├── business_queries.sql           # D9: Analytical queries
│   └── validation_queries.sql         # D8: Validation SQL
│
└── [optional]/
    ├── powerbi/                        # Power BI files
    ├── dbt/                            # dbt project
    ├── docker/                         # Containerization
    └── .github/workflows/              # CI/CD pipelines
```

---

## **⚠️ Common Pitfalls to Avoid**

### **Phase 0 - Analysis**:
- ❌ Assuming Sales is the priority without systematic analysis
- ❌ Creating bus matrix after designing dimensional model
- ❌ Defining dimensions at inconsistent grains across processes
- ❌ Skipping data profiling (discovering quality issues during ETL)

### **Phase 1 - Design**:
- ❌ Grain too coarse (limits flexibility) or too fine (explosion)
- ❌ Mixing grains in same fact table
- ❌ Snowflaking dimensions (normalizing dimensional tables)
- ❌ Putting facts in dimensions or dimensions in facts
- ❌ Not specifying SCD type (defaulting to Type 1 everywhere)
- ❌ Choosing SCD types arbitrarily without business justification

### **Phase 2 - Implementation**:
- ❌ Skipping data validation until the end
- ❌ Not handling NULLs appropriately
- ❌ Orphaned foreign keys in fact tables
- ❌ SCD Type 2 with multiple "current" records per natural key
- ❌ Missing indexes on foreign keys
- ❌ Hardcoding values instead of parameterizing

### **Phase 3 - Analytics**:
- ❌ Queries don't actually use the dimensional model properly
- ❌ Comparing different questions in OLTP vs. DW benchmark
- ❌ Not validating that query results are actually correct
- ❌ Claiming performance improvements without evidence

### **Phase 4 - Documentation**:
- ❌ No design rationale (just "what" without "why")
- ❌ Assuming readers understand your thought process
- ❌ Missing reproduction instructions
- ❌ Not documenting known limitations
- ❌ Typos, formatting issues, broken links

---

## **🎓 Assessment Rubric**

### **Phase 0: Enterprise Analysis (20%)**
- **Excellent (18-20)**: Comprehensive OLTP analysis, strategic bus matrix, quantitative prioritization with clear justification
- **Good (15-17)**: Solid analysis, bus matrix shows understanding, prioritization has some quantitative basis
- **Satisfactory (12-14)**: Basic process identification, bus matrix present but superficial, prioritization mostly qualitative
- **Needs Improvement (<12)**: Incomplete analysis, bus matrix missing/incorrect, no clear prioritization

### **Phase 1: Dimensional Design (25%)**
- **Excellent (23-25)**: All 4 Kimball steps rigorously applied, grain is atomic and justified, SCD types appropriately chosen, star schema accurate
- **Good (20-22)**: 4 steps completed, reasonable grain, SCD types mostly appropriate, minor schema issues
- **Satisfactory (16-19)**: 4 steps present but shallow, grain unclear, SCD types arbitrary, schema has issues
- **Needs Improvement (<16)**: Steps incomplete, grain missing/wrong, no SCD justification, schema doesn't match design

### **Phase 2: Implementation (25%)**
- **Excellent (23-25)**: Clean DDL, complete ETL with SCD handling, 100% data reconciliation, production-quality code
- **Good (20-22)**: Working schema, ETL mostly correct, minor reconciliation issues, good code quality
- **Satisfactory (16-19)**: Basic implementation, ETL has gaps, reconciliation incomplete, code needs polish
- **Needs Improvement (<16)**: Schema incomplete, ETL broken, validation missing, poor code quality

### **Phase 3: Analytics & Validation (20%)**
- **Excellent (18-20)**: 5+ diverse queries, measurable performance gains, comprehensive validation, clear analysis
- **Good (15-17)**: Required queries present, performance improvement shown, validation mostly complete
- **Satisfactory (12-14)**: Basic queries, some performance data, validation incomplete
- **Needs Improvement (<12)**: Insufficient queries, no performance benchmark, no validation

### **Phase 4: Documentation (10%)**
- **Excellent (9-10)**: Professional README, complete reflection, clear communication, portfolio-ready
- **Good (7-8)**: Good documentation, solid reflection, minor gaps
- **Satisfactory (5-6)**: Basic documentation, shallow reflection, needs polish
- **Needs Improvement (<5)**: Incomplete/unclear documentation, no reflection

---

## **🚀 Getting Started**

### **Day 1-2: Discovery Phase**
1. Install AdventureWorks2022 database
2. Explore schema using SQL queries and ER diagrams
3. Complete OLTP analysis document
4. Create bus matrix
5. Score and prioritize business processes
6. Make architecture decision

### **Day 3-4: Design Phase**
1. Apply Kimball's 4-step process to selected process
2. Design all dimensions with SCD types
3. Design fact table with measures
4. Create star schema diagram
5. Validate design against business questions

### **Day 5-6: Implementation Phase**
1. Write DDL for dimensions and facts
2. Implement dimension loading (including SCD logic)
3. Implement fact loading
4. Run validation queries
5. Write analytical queries
6. Benchmark performance

### **Day 7: Polish Phase**
1. Complete all documentation
2. Write reflection essay
3. Polish code (formatting, comments)
4. Test reproduction instructions
5. Create professional README
6. Final quality review

---

## **📚 Success Indicators**

**You know you've succeeded when**:
- ✅ Another data professional can reproduce your work from your README
- ✅ Your dimensional model answers all stated business questions
- ✅ Data reconciles 100% with source OLTP
- ✅ Performance benchmark shows measurable DW advantage
- ✅ Design decisions are clearly justified, not arbitrary
- ✅ You can explain trade-offs to technical and business audiences
- ✅ Your GitHub repository showcases employable skills
- ✅ You understand both the "how" and the "why" of dimensional modeling

---

## **💡 Final Notes**

**This is a learning project, not production software**. You should:
- Prioritize understanding over perfection
- Experiment with different approaches
- Document your mistakes and learnings
- Focus on demonstrating methodology comprehension
- Build something you're proud to show employers

**The deliverables are your guideposts, not handcuffs**. If you discover better ways to structure documentation or present findings, adapt accordingly. The goal is demonstrating data warehouse competency, not checkbox compliance.

**Good luck building!** 🚀
