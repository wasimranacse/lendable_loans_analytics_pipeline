-- models/marts/fct_loans_analysis.sql

-- models/marts/fct_loans_analysis.sql

WITH customer_latest_score AS (
    SELECT
        c.customer_id,
        MAX(s.score_date) AS latest_score_date
    FROM {{ ref('stg_credit_scores') }} s
    JOIN {{ ref('stg_customers') }} c
        ON s.customer_id = c.customer_id
    GROUP BY c.customer_id
),

latest_credit_scores AS (
    SELECT
        s.customer_id,
        s.credit_score
    FROM {{ ref('stg_credit_scores') }} s
    JOIN customer_latest_score cls
        ON s.customer_id = cls.customer_id
        AND s.score_date = cls.latest_score_date
),

loans_summary AS (
    SELECT
        l.loan_id,
        l.customer_id,
        l.amount,
        l.interest_rate,
        l.term_months,
        l.application_date,
        l.status,
        l.total_amount_paid,
        l.total_principal_paid,
        l.total_interest_paid,
        l.last_payment_date
    FROM {{ ref('int_loans_summary') }} l
)

SELECT
    l.loan_id,
    l.customer_id,
    c.first_name,
    c.last_name,
    c.signup_date,
    c.email,
    cs.credit_score AS latest_credit_score,
    l.amount AS original_loan_amount,
    l.interest_rate,
    l.term_months,
    l.application_date,
    l.status,
    l.total_amount_paid,
    l.total_principal_paid,
    l.total_interest_paid,
    l.last_payment_date,
    CASE 
        WHEN l.total_principal_paid >= l.amount THEN 'Paid Off'
        WHEN l.status = 'ACTIVE' THEN 'Active'
        ELSE 'Other'
    END AS loan_status_group
FROM loans_summary l
JOIN {{ ref('stg_customers') }} c
    ON l.customer_id = c.customer_id
LEFT JOIN latest_credit_scores cs
    ON l.customer_id = cs.customer_id

