CREATE TABLE loan_data (
    id SERIAL PRIMARY KEY,
    address_state VARCHAR(2),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(100),
    grade CHAR(1),
    home_ownership VARCHAR(50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(50),
    next_payment_date DATE,
    member_id INT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(5),
    term VARCHAR(50),
    verification_status VARCHAR(50),
    annual_income NUMERIC(10, 2),
    dti NUMERIC(10, 4),
    installment NUMERIC(10, 2),
    int_rate NUMERIC(5, 4),
    loan_amount INT,
    total_acc INT,
    total_payment INT
);


SELECT* FROM loan_data

SELECT COUNT(id) AS Total_Loan_Applications FROM loan_data

SELECT COUNT(id) AS MTD_Total_Applications FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021

SELECT COUNT(id) AS PMTD_Total_Applications FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM loan_data

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11

SELECT SUM(total_payment) AS Total_Amount_Collected FROM loan_data

SELECT SUM(total_payment) AS MTD_Total_Amount_Collected FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12

SELECT SUM(total_payment) AS PMTD_Total_Amount_Collected FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11

SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM loan_data

SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12

SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11

SELECT AVG(dti)*100 AS Avg_DTI FROM loan_data

SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12

SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11

SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM loan_data

SELECT COUNT(id) AS Good_Loan_Applications FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT SUM(total_payment) AS Good_Loan_amount_received FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM loan_data

SELECT COUNT(id) AS Bad_Loan_Applications FROM loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM loan_data
WHERE loan_status = 'Charged Off'

SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        loan_data
    GROUP BY
        loan_status
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 
GROUP BY loan_status

SELECT 
    EXTRACT(MONTH FROM issue_date) AS month_number,
    TO_CHAR(issue_date, 'Month') AS month_name, 
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_amount_received
FROM 
    loan_data
GROUP BY 
    month_number, month_name
ORDER BY 
    month_number;

SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY address_state
ORDER BY address_state

SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY term
ORDER BY term

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY emp_length
ORDER BY emp_length

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY purpose
ORDER BY purpose

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY home_ownership
ORDER BY home_ownership

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose











