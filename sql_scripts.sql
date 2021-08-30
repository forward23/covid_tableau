--DATA ANALISIS PROJECT

select *
from covid c


select *
from covid
where continent is null

select "location", "date", total_cases, new_cases, total_deaths, population
from covid c


--Looking at Total Cases vs Total Deaths
select "location", "date", total_cases, total_deaths,
total_deaths / total_cases as deaths_vs_cases
from covid c


--Looking at Total Cases vs Population
select "location", "date", total_cases, population,
total_cases / population as cases_vs_population
from covid c


--Looking at countries with highest Infection Rate compared to Population
select "location",population, MAX(total_cases) as max_total_cases,
MAX(total_cases)/population as max_total_cases_vs_population
from covid c
where continent is not null
group by 1,2
having max(total_cases) is not null
order by 4 desc


--Looking at countries with highest Death Rate compared to Population
select "location",population, MAX(total_deaths) as max_total_deaths,
MAX(total_deaths)/population as max_total_deaths_vs_population
from covid c
where continent is not null
group by 1,2
having max(total_deaths) is not null
order by 3 desc


--Looking at Coninents with highest Death Rate compared to Population
select "location" , MAX(total_cases) as max_total_cases, MAX(total_deaths) as max_total_deaths
from covid c
where continent is null
group by 1
order by 2 desc


--Showing continents with the heighest death count per population
select continent, MAX(total_deaths) as max_total_deaths_vs_population
from covid c
where continent is not null
group by 1
order by 2 desc


-- Global numbers

--Looking at countries with highest Death Rate compared to Population
select date("date"), SUM(new_cases) as new_cases, SUM(new_deaths) as new_deaths, SUM(new_deaths)/ SUM(new_cases) as new_deaths_vs_new_cases
from covid c
where continent is not null
group by 1
order by 1


--Looking at Total Population vs Vaccionations
select continent, "location", "date", population, new_vaccinations,
sum(new_vaccinations) over (partition by "location" order by date) as rolling_vaccinations,
sum(new_vaccinations) over (partition by "location" order by date) /population as percent_vaccinations_vs_population
from covid c
where continent is not null
order by "location", "date"


--Creating view
create view PercentPopulationVaccionated as
select continent, "location", "date", population, new_vaccinations,
sum(new_vaccinations) over (partition by "location" order by date) as rolling_vaccinations,
sum(new_vaccinations) over (partition by "location" order by date) /population as percent_vaccinations_vs_population
from covid c
where continent is not null
order by "location", "date"