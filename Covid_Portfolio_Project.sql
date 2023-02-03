-- SELECT data that is going to be using

SELECT *
FROM Covid19.coviddeaths
WHERE continent is not null
ORDER BY location;

SELECT *
FROM Covid19.CovidVaccinations
ORDER BY date;

-- Comparing Total cases vs. Total deaths
-- The likelihood of dying when you get infected to Covid-19 in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM Covid19.coviddeaths
WHERE location LIKE '%state%'
ORDER BY location;

-- Looking at Total cases with Population
SELECT location, date, total_cases, population, (total_cases/population)*100 AS InfectionRate
FROM Covid19.coviddeaths
ORDER BY location;

-- Looking at country with highest Infection Rate compared to Population
SELECT location, MAX(total_cases) as HighestInfectionCount, population, MAX(total_cases/population)*100 AS Max_Infectionrate
FROM Covid19.coviddeaths
GROUP BY Location, population
ORDER BY Max_Infectionrate DESC;

-- Showing Countries with Highest Death Count per Population
-- Cast Total_deaths to INT, some location values appear as ASIA while the continent is NULL
SELECT location, MAX(cast(total_deaths as signed)) as TotalDeathCount
FROM Covid19.coviddeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount desc;

-- LET'S BREAK THINGS DOWN BY CONTINENT
-- Continent with the highest death count per population

SELECT continent, MAX(cast(total_deaths as signed)) as TotalDeathCount
FROM Covid19.coviddeaths
WHERE continent is not null
GROUP by continent
ORDER BY TotalDeathCount DESC;
