-- 1) Basic row counts
SELECT 'customers_clean' AS table_name, COUNT(*) AS row_count
FROM customers_clean;

SELECT 'customers_rejected' AS table_name, COUNT(*) AS row_count
FROM customers_rejected;


-- 2) Duplicate customer_id check (should return 0 rows)
SELECT customer_id, COUNT(*) AS cnt
FROM customers_clean
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 3) Mandatory field validation (should return 0 rows)
SELECT *
FROM customers_clean
WHERE full_name IS NULL;


-- 4) Email uniqueness check (should return 0 rows)
-- (UNIQUE constraint should prevent duplicates, but we validate anyway)
SELECT email, COUNT(*) AS cnt
FROM customers_clean
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;


-- 5) Key reconciliation sanity: total rows vs distinct keys (should match)
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT customer_id) AS distinct_customer_ids
FROM customers_clean;


-- 6) Date format sanity check (expect YYYY-MM-DD, very basic check)
-- SQLite stores DATE as TEXT often; so we do a format check
SELECT *
FROM customers_clean
WHERE signup_date IS NOT NULL
  AND signup_date NOT LIKE '____-__-__';


-- 7) Credit score range check (optional, returns bad rows if any)
SELECT *
FROM customers_clean
WHERE credit_score IS NOT NULL
  AND (credit_score < 300 OR credit_score > 850);


-- 8) Rejected records summary (audit report)
SELECT reject_reason, COUNT(*) AS cnt
FROM customers_rejected
GROUP BY reject_reason
ORDER BY cnt DESC;


-- 9) Rejected records sample (quick review)
SELECT *
FROM customers_rejected
ORDER BY reject_id
LIMIT 10;
