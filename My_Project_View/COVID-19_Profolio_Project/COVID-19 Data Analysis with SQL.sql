/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/
-- SELECT Data are Going to use 

select Location,date,total_cases,new_cases,total_deaths,population
from dataset_coviddeaths_csv
where continent is not null
order by 1,2;

/* Total Cases vs Total Deaths
 查找病例数与死亡人数（国家） 
*/
-- Show likelihood of dying if you contract covid in your country
-- 展示在你的国家感染新冠后的病死率。

select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from dataset_coviddeaths_csv
where location like '%malaysia%'
order by 1,2;

/* Looking at Total Cases vs Population	 
	病例总数与人口数量对比 
*/
-- Show what Percentage of Population got Covid
-- 显示感染新冠病毒的人口百分比

select Location,date,population,total_cases,(total_cases/population)*100 as PercentPopulationInfected
from dataset_coviddeaths_csv
where location like '%malaysia%'
order by 1,2;
    
/*Looking at Countries with Highest Infection Rate compared to Population
	查看看感染率最高的国家（按人口计算）
*/

select Location,population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as PercentPopulationInfected
from dataset_coviddeaths_csv
group by Location,population
order by PercentPopulationInfected desc;

/* Showing Countries with Highest Death Count Per Population 
	显示人口平均死亡人数最多的国家
*/
-- the total_deaths data type is varchar, so need to use CAST to Convert To INT

select Location,MAX(cast(total_deaths as UNSIGNED)) as TotalDeathCount
from dataset_coviddeaths_csv
where continent is not null
group by Location
order by TotalDeathCount desc;

-- Break Things Down By Continet 按大洲细分
-- Showing contintents with the highest death count per pepulation 

select continent,MAX(cast(total_deaths as UNSIGNED)) as TotalDeathCount
from dataset_coviddeaths_csv
where continent is not null
group by continent
order by TotalDeathCount desc;


-- GLOBAL NUMBERS

select date,SUM(new_cases) as total_cases, sum(cast(new_deaths as UNSIGNED)) as total_deaths, sum(cast(new_deaths as UNSIGNED))/sum(new_cases)*100 as deat
from dataset_coviddeaths_csv
where continent is not null
group by date
order by 1,2;

select SUM(new_cases) as total_cases, sum(cast(new_deaths as UNSIGNED)) as total_deaths, sum(cast(new_deaths as UNSIGNED))/sum(new_cases)*100 as deat
from dataset_coviddeaths_csv
where continent is not null
order by 1,2;


/*JOIN two Table*/

-- Looking at Total Population vs Vaccinations

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as unsigned)) over (partition by dea.location  order by dea.location,dea.date) 
as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
from dataset_coviddeaths_csv dea
join dataset_covidvaccinations_csv vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
order by 2,3;


-- use cte

with PopvsVac (Continent,Location,Date,Population,New_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as unsigned)) over (partition by dea.location  order by dea.location,dea.date) 
as RollingPeopleVaccinated
from dataset_coviddeaths_csv dea
join dataset_covidvaccinations_csv vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
)
select *,(RollingPeopleVaccinated/population)*100
from PopvsVac;


-- Using Temp Table to perform Calculation on Partition By in previous query
-- TEMP Table

-- DROP Table if exists #PercentPopulationVaccinated
CREATE TEMPORARY TABLE PercentPopulationVaccinated
(
  Continent VARCHAR(255),
  Location VARCHAR(255),
  Date DATETIME,
  Population DECIMAL(20,0),
  New_vaccinations DECIMAL(20,0),
  RollingPeopleVaccinated BIGINT
);

INSERT INTO PercentPopulationVaccinated
SELECT dea.continent,
       dea.location,
       dea.date,
       dea.population,
       vac.new_vaccinations,
       SUM(CAST(NULLIF(vac.new_vaccinations, '') AS UNSIGNED)) 
           OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM dataset_coviddeaths_csv dea
JOIN dataset_covidvaccinations_csv vac
  ON dea.location = vac.location
 AND dea.date = vac.date
WHERE dea.continent <> '';


SELECT *,(RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM PercentPopulationVaccinated;



-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
SELECT dea.continent,
       dea.location,
       dea.date,
       dea.population,
       vac.new_vaccinations,
       SUM(CAST(NULLIF(vac.new_vaccinations, '') AS UNSIGNED)) 
           OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM dataset_coviddeaths_csv dea
JOIN dataset_covidvaccinations_csv vac
  ON dea.location = vac.location
 AND dea.date = vac.date
WHERE dea.continent <> '';


