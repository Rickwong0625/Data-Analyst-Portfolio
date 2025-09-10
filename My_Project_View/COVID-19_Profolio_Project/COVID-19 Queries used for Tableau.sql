/*
Queries used for Tableau Project
*/

-- 1. 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as unsigned)) as total_deaths, SUM(cast(new_deaths as unsigned))/SUM(New_Cases)*100 as DeathPercentage
From dataset_coviddeaths_csv
where continent is not null 
order by 1,2;

-- 2. 

-- European Union is part of Europe

Select location, SUM(cast(new_deaths as unsigned)) as TotalDeathCount
From dataset_coviddeaths_csv
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc;


-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From dataset_coviddeaths_csv
Group by Location, Population
order by PercentPopulationInfected desc;


-- 4.

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From dataset_coviddeaths_csv
Group by Location, Population, date
order by PercentPopulationInfected desc;