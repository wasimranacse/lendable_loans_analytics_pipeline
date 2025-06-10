-- models/intermediate/int_loans_summary.sql

WITH loan AS (
    SELECT
        l.loan_id,
        l.customer_id,
        l.amount,
        l.interest_rate,
        l.term_months,
        l.application_date,
        l.status
    FROM {{ ref('stg_loans') }} l
),

payments AS (
    SELECT
        p.loan_id,
        SUM(p.amount_paid) AS total_amount_paid,
        SUM(p.principal_paid) AS total_principal_paid,
        SUM(p.interest_paid) AS total_interest_paid,
        MAX(p.payment_date) AS last_payment_date
    FROM {{ ref('stg_payments') }} p
    GROUP BY p.loan_id
)

SELECT
    l.loan_id,
    l.customer_id,
    l.amount,
    l.interest_rate,
    l.term_months,
    l.application_date,
    l.status,
    p.total_amount_paid,
    p.total_principal_paid,
    p.total_interest_paid,
    p.last_payment_date
FROM loans l
LEFT JOIN payments p
    ON l.loan_id = p.loan_id