# Lendable Loans Analytics Pipeline

This is a mock analytics pipeline inspired by a real-world Senior Analytics Engineer interview at [Lendable](https://www.lendable.io/).

The goal was to showcase an end-to-end modern data pipeline using:
- **Snowflake** as cloud data warehouse
- **DBT Core** for data transformations
- **SQL** for analytics engineering best practices
- **GitHub** for version control & collaboration

---

## Project Structure

models/

    staging/ --> stg_ models (raw data cleaned & standardized)

    intermediate/ --> int_ models (business logic & aggregations)

    marts/ --> fct_ models (analytics-ready tables)

    schema.yml --> model documentation, tests & metadata

dbt_project.yml

## Data Sources

Mock data provided for:

- Customers
- Loans
- Loan payments
- Credit scores

---

## Key Outputs

### `fct_loans_analysis`

- Combines loans + payments + customer profile + latest credit scores
- Business-friendly columns for reporting & dashboards
- Example KPI field: `loan_status_group` (Paid Off, Active, Other)

---

## Why This Project?

✅ Demonstrates data modeling best practices: `stg_` → `int_` → `fct_`  
✅ Shows clean SQL style & modular transformations  
✅ Uses realistic FinTech use case: **consumer loans + credit risk analysis**  
✅ Follows dbt + GitHub industry standards → ready for production pipelines

---

## How to Run Locally

1️⃣ Clone the repo  
2️⃣ Set up Snowflake credentials in `profiles.yml`  
3️⃣ Run dbt:

```bash
dbt run
dbt docs generate
dbt docs serve

## Data Quality and Testing

This project includes comprehensive data quality checks implemented using dbt's built-in testing framework. 

### Tests Included:
- **Uniqueness** checks on primary key columns (e.g., `customer_id`, `loan_id`)
- **Not null** constraints to ensure critical fields are always populated
- **Referential integrity** tests to validate foreign key relationships between tables
- **Accepted values** validation for columns with controlled vocabularies (e.g., loan status)

Run the tests locally using:

```bash
dbt test





