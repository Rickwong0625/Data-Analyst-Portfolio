-- SQL Project - Exploratoy Data Analysis
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022


-- EDA
-- Here we are jsut going to explore the data and find trends 
-- or patterns or anything interesting like outliers

select *
from layoffs_staging2;

-- EASIER QUERIES

-- Looking at Percentage to see how big these layoffs were
select MAX(total_laid_off),MAX(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
WHERE percentage_laid_off = 1
order by funds_raised_millions desc;

select company,sum(total_laid_off) 
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging2;

select country,sum(total_laid_off) 
from layoffs_staging2
group by country
order by 2 desc;

select *
from layoffs_staging2;

select year(`date`),sum(total_laid_off) 
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select stage,sum(total_laid_off) 
from layoffs_staging2
group by stage
order by 1 desc;

select company,avg(percentage_laid_off) 
from layoffs_staging2
group by company
order by 2 desc;



select substring(`date`,1,7) as `MONTH`,SUM(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) IS not null
group by `MONTH`
order by 1 asc;

with Rolling_Total as
(
select substring(`date`,1,7) as `MONTH`,SUM(total_laid_off) AS total_off
from layoffs_staging2
where substring(`date`,1,7) IS not null
group by `MONTH`
order by 1 asc
)
select `MONTH`,total_off
,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
from Rolling_Total;



select company,sum(total_laid_off) 
from layoffs_staging2
group by company
order by 2 desc;

select company,year(`date`),sum(total_laid_off) 
from layoffs_staging2
group by company,year(`date`)
order by 3 DESC;

with Company_Year(company,years,total_laid_off) as
(
select company,year(`date`),sum(total_laid_off) 
from layoffs_staging2
group by company,year(`date`)
),Company_Year_Rank as(
select* , DENSE_RANK() OVER(partition by years order by total_laid_off DESC) as Ranking
from Company_Year
where years is not null)
select *
from Company_Year_Rank
where Ranking <= 5
;










