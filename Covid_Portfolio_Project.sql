-- SELECT data that is going to be using

SELECT *
FROM Covid19.coviddeaths
WHERE continent is not null
ORDER BY location;

SELECT *
FROM Covid19.CovidVaccinations
ORDER BY date;