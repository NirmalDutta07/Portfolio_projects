

Select location , date,
nullif (total_cases,0) as total_cases,
nullif(total_deaths,0)as total_deaths,
(nullif(total_deaths,0)/nullif(total_cases,0))*100 as death_percentage
from PortfolioProject..CovidDeaths
--where location like '%asia%'
order by 1,2 

select location , population , MAX (total_cases)as HighestInfectionCount,max((total_cases/ population))*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
group by location  ,population
order by  PercentagePopulationInfected desc

--Showing continents with the highest death count per population
select continent,max(cast(total_deaths as int))as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

--Showing countries with the highest death count per population
select location,max(cast(total_deaths as int))as TotalDeathCount
from PortfolioProject..CovidDeaths
where location is not null
group by location

--UPDATE PortfolioProject..CovidDeaths
--SET 
--    new_cases = NULL
--WHERE 
--    new_cases = 0

--UPDATE PortfolioProject..CovidDeaths
--SET 
--    new_deaths = NULL
--WHERE 
--    new_deaths = 0
update PortfolioProject..CovidDeaths
set new_cases = null
where new_cases = 0

update PortfolioProject..CovidDeaths
set new_deaths = null
where new_deaths = 0

-- Global Numbers
select date, sum(new_cases)as TotalCases,sum(cast(new_deaths as int))as TotalDeaths, sum(cast( new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
 group by date

order by 4 desc


--looking at total pop vs vaccination
 select dea.continent , dea.location, dea.date,dea.population,vac.new_vaccinations,
 sum(cast(vac.new_vaccinations as int))over(partition by dea.location order by dea.location,dea.date )total_vac 
 from PortfolioProject..CovidDeaths dea
 join PortfolioProject..CovidVaccinations vac
 on dea.location =vac.location
 and dea.date = vac.date 
 where dea.continent is not null
 order by 1,2

 --viewing percentage of people  vaccinated
  create view PercentagePeopleVaccinated as
 select dea.continent , dea.location, dea.date,dea.population,vac.new_vaccinations,
 sum(cast(vac.new_vaccinations as int))over(partition by dea.location order by dea.location,dea.date )total_vac 
 from PortfolioProject..CovidDeaths dea
 join PortfolioProject..CovidVaccinations vac
 on dea.location =vac.location
 and dea.date = vac.date 
 where dea.continent is not null
 --order by 1,2
 




 
