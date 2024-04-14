create database ProjDA;
use ProjDA;


select * from finance_1;
select * from finance_2;

SELECT DATE_FORMAT(issue_d, '%Y-%m-%d') AS formatted_date FROM finance_1;
SELECT DATE_FORMAT(last_pymnt_d, '%Y-%m-%d') AS formatted_date FROM finance_2;

#KPI 1 :- Year wise loan amount Stats
SELECT 
    YEAR(issue_d) AS Year,
    concat('$',round(sum(loan_amnt)/1000000,2),'M') AS loan_amount
FROM 
    finance_1
GROUP BY 
   Year
ORDER BY 
    Year,
    loan_amount;
    
    
    
 
#KPI 2 :- Grade and sub grade wise revol_bal
select grade, sub_grade, concat('$',round(sum(revol_bal)/1000000,2),'M') as "Total Revolving balance"
from finance_1 f1
inner join finance_2 f2 
on f1.id = f2.id
group by f1.grade,f1. sub_grade
order by f1.grade,f1.sub_grade;



#KPI 3 :- Total Payment for Verified Status Vs Total Payment for Non Verified Status
select Verification_status ,concat('$',round(sum(annual_inc)/100000000,2),'M') as 'Total  Annual Income'
from finance_1
group by verification_status;

SELECT 
    CASE 
        WHEN Verification_status = 'Not Verified' THEN 'Not Verified'
        ELSE 'Verified'
    END AS Verification_status,
    CONCAT('$', ROUND(SUM(annual_inc) / 100000000, 2), 'M') AS 'Total Annual Income'
FROM 
    finance_1
GROUP BY 
    CASE 
        WHEN Verification_status = 'Not Verified' THEN 'Not Verified'
        ELSE 'Verified'
    END;

#KPI 4 :- State wise and month wise loan status
SELECT 
    addr_state,
    MONTHNAME(issue_d) AS loan_month, 
loan_status
FROM 
    finance_1
GROUP BY 
    addr_state, loan_month, loan_status
ORDER BY 
    addr_state, loan_month;
    
    
    
#KPI 5 :- Home ownership Vs last payment date stats
SELECT home_ownership, last_pymnt_d,concat('$',round(sum(last_pymnt_amnt)/10000,2),'K') as 'Total_Payment'
 FROM finance_1
INNER JOIN finance_2 ON (finance_1.id = finance_2.id)
GROUP BY
 home_ownership, last_pymnt_d
ORDER BY 
last_pymnt_d DESC, home_ownership DESC;




#KPI 6 :- Loan amount vs Loan_Purpose
SELECT
    YEAR(issue_d) AS loan_issued_year,
    purpose,
    concat('$',round(sum(funded_amnt)/10000,2),'K') AS total_funded_amount
FROM
    finance_1
GROUP BY
     YEAR(issue_d), purpose
ORDER BY
    YEAR(issue_d),total_funded_amount desc;
    




