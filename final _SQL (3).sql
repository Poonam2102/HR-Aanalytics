use hr;
--- 1, Total Employee attrition cont and active employee (attrition rate)

SELECT 
SUM(EmployeeCount) AS emp_count,
(SELECT SUM(EmployeeCount) AS att_count
FROM hr_data
WHERE Attrition = 'Yes') AS att_count,
SUM(EmployeeCount) -
(SELECT SUM(EmployeeCount)
FROM hr_data
WHERE Attrition = 'Yes') AS active_emp,
(SELECT SUM(EmployeeCount)
FROM hr_data
WHERE Attrition = 'Yes')/SUM(EmployeeCount) AS att_rate
FROM hr_data;


--  2, AVERAGE ATTRITION RATE OF ALL THE DEPARTMENTS

SELECT department, round(count(attrition)/(SELECT count(employeenumber) FROM hr_data)*100,2) AS "Attrition Rate" 
FROM hr_data WHERE attrition="yes"
GROUP BY Department;


-- 3, Job Role wise Overtime % of Employees

SELECT JobRole,SUM(overtime_per) AS overtime_percent
FROM (
SELECT 
JobRole,
EmployeeID,
(ROUND((SUM(DailyRate)/SUM(HourlyRate)),0) - (SELECT 8))/AVG(StandardHours) AS overtime_per
FROM hr_data
GROUP BY JobRole, EmployeeID
ORDER BY JobRole ASC) AS jobrole_overtime
WHERE overtime_per > 0
GROUP BY JobRole
ORDER BY SUM(overtime_per) DESC;


--- 4, department wise average by stockuoptionlevel, jobsatisfaction, worklifebalance, jobinvolvement

SELECT
Department,
AVG(StockOptionLevel) AS stockoptionlevel,
AVG(JobSatisfaction) AS jobsatisfaction,
AVG(WorkLifeBalance) AS woeklifebalance,
AVG(JobInvolvement) AS jobinvolvement,
AVG(RelationshipSatisfaction) AS relationshipsatisfaction 
FROM hr_data
GROUP BY Department;

---- 5, Attrition rate Vs Monthly income stats
 
 select department,
round(count(attrition)/(select count(employeenumber) from hr_data)*100,2) `Attrtion rate`,
round(avg(MonthlyIncome),2) as "average_income" from hr_data 
where attrition = 'Yes'
group by department;


-- 6. Average working years for each Department

select department,Round(avg(totalworkingyears),2) as "Average working years" from hr_data
group by department;


--- 7. Attrition by Education Field


SELECT educationfield, COUNT(attrition) AS attrition_count
FROM hr_data
WHERE attrition = 'yes'
GROUP BY educationfield;


--- 8. Job Role vs Work Life Balance


select jobrole, avg(worklifebalance) as avg_work_life_balance
from hr_data
group by jobrole;


----------------------------------   Thak you ------------------------------------
