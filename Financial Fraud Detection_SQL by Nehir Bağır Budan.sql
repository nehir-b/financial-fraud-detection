# 1. SQL Setup – Database Initialization
CREATE SCHEMA IF NOT EXISTS finance;
USE finance;

# 2. SQL Setup – Table Description 
Describe cc_data;
Describe location_data;

# 3. SQL Query – Total number of Transactions
Select Count(*) As total_transactions
From cc_data;

# 4. SQL Query – Top 10 Merchants by Transaction Volume
SELECT 
    REPLACE(merchant, 'fraud_', '') AS merchant_clean,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_transactions,
    COUNT(*) - SUM(is_fraud) AS non_fraud_transactions
FROM cc_data
GROUP BY merchant_clean
ORDER BY total_transactions DESC
LIMIT 10;

# 5. SQL Query – Average Transaction Amount by Category
SELECT 
    category,
    ROUND(AVG(amt), 2) AS avg_transaction_amount
FROM cc_data
GROUP BY category
ORDER BY avg_transaction_amount DESC;

# 6. SQL Query – Fraud Transactions and Percentage
SELECT 
    SUM(is_fraud) AS fraud_transactions,
    COUNT(*) AS total_transactions,
    ROUND(100 * SUM(is_fraud) / COUNT(*), 4) AS fraud_percentage
FROM cc_data;

# 7. SQL Query – Transaction Data with Location (Join on cc_num)
SELECT 
    c.cc_num,
    c.trans_date_trans_time,
    c.amt,
    l.lat,
    l.long
FROM cc_data c
JOIN location_data l
    ON c.cc_num = l.cc_num
LIMIT 10;

# 8. SQL Query – City with Highest Population
SELECT 
    city, 
    city_pop
FROM cc_data
ORDER BY city_pop DESC
LIMIT 1;

# 9. SQL Query – Earliest and Latest Transactions
SELECT 
    MIN(STR_TO_DATE(trans_date_trans_time, '%d-%m-%Y %H:%i')) AS earliest_transaction,
    MAX(STR_TO_DATE(trans_date_trans_time, '%d-%m-%Y %H:%i')) AS latest_transaction
FROM cc_data;

# 10. SQL Query – Total Amount Spent
SELECT 
    ROUND(SUM(amt), 2) AS total_amount_spent
FROM cc_data;

# 11. SQL Query – Number of Transactions by Category
SELECT 
    category,
    COUNT(*) AS transaction_count
FROM cc_data
GROUP BY category
ORDER BY transaction_count DESC;

# 12. SQL Query – Average Transaction Amount by Gender
SELECT 
    gender,
    ROUND(AVG(amt), 2) AS avg_transaction_amount
FROM cc_data
GROUP BY gender;

# 13. SQL Query – Average Transaction Amount by Day of the Week
SELECT 
    DAYNAME(STR_TO_DATE(trans_date_trans_time, '%d-%m-%Y %H:%i')) AS day_of_week,
    ROUND(AVG(amt), 2) AS avg_transaction_amount
FROM cc_data
GROUP BY day_of_week
ORDER BY avg_transaction_amount DESC;




