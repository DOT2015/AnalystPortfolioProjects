Select * 
from PortfolioProjects..Covidvacination 
where continent is not null
order by 3, 4
--Select * from PortfolioProjects..Covidvacination order by 3, 4

Select location, date, total_cases, new_cases, total_deaths 
from PortfolioProjects..Covideath 
where continent is not null
order by 1,2

--looking at the Total Cases vs Total deaths
--shows the percentage that could die of covid
Select location, date, total_cases, total_deaths, ((total_deaths/total_cases)*100) AS percentagedeath
from PortfolioProjects..Covideath 
--where continent is not null
Where location = 'Eswatini'
order by 1,2

--Total cases vs Population
--showspopulation with covid
Select location, date, total_cases, population, ((total_cases/population)*100) AS populationAffected
from PortfolioProjects..Covideath 
Where location = 'Eswatini'
order by 1,2

--countries with the highest Infection Rate compared to population
Select location, population, MAX(total_cases) as HighestInfectedCountry,  MAX((total_cases/population)*100) AS percentageHighestInfectedCountry
from PortfolioProjects..Covideath 
--Where location = 'Eswatini'
Group by location, population
order by percentageHighestInfectedCountry desc


--countrieswith highest dath count rate
Select location, population, MAX(cast(total_deaths as int) )as HighestdeathCountry,  MAX((total_deaths/population)*100) AS percentageHighestDeathRateinCountry
from PortfolioProjects..Covideath 
where continent is not null
--Where location = 'Eswatini'
Group by location, population
order by HighestdeathCountry desc


--covid rate by lcation
Select location,  MAX(cast(total_deaths as int) )as HighestdeathCountry
from PortfolioProjects..Covideath 
where continent is null
--Where location = 'Eswatini'
Group by location
order by HighestdeathCountry desc



--continent with the highest death rate
Select continent,  MAX(cast(total_deaths as int) )as HighestdeathCountry
from PortfolioProjects..Covideath 
where continent is not null
--Where location = 'Eswatini'
Group by continent
order by HighestdeathCountry desc


--totalcases in the world
Select  SUM(total_cases) as TotalCase
from PortfolioProjects..Covideath 
--where continent is not null
--order by 1,2
--Group by location


--total Death in the world
Select  SUM(cast(total_deaths as int)) as TotalDeath
from PortfolioProjects..Covideath 
--where continent is not null
--order by 1,2
--Group by location


--total number of new cases/ country
Select  location, SUM(new_cases) as NewCases
from PortfolioProjects..Covideath 
where location is not null
--order by 1,2
Group by location
order by NewCases desc


--total number of new cases in the world
Select  SUM(new_cases) as NewCases
from PortfolioProjects..Covideath 
--where location is not null
--order by 1,2
--Group by location
order by NewCases desc


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location,
dea.date) as RollingVacination
from PortfolioProjects..Covideath dea
JOIN PortfolioProjects..Covidvacination vac
ON dea.location = vac.location
and dea.date  = vac.date
where dea.continent is not null
order by 2,3