SELECT *
FROM PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 3,4


--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select Data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 1,2


-- Looking at total cases vs total deaths
-- Shows the liklihood of dying if you contract covid in your country

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE Location like '%states%'
ORDER BY 1,2

--Looking at the total cases vs population
--Shows what percentage of population got Covid

SELECT Location, date, population, total_cases, (total_cases/population)*100 as PercenPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE Location like '%states%'
ORDER BY 1,2


--Looking at countries with highest infection rate compared to population

SELECT Location, population, MAX(total_cases) AS  HighestInfectionCount, MAX((total_cases/population))*100 as PercenPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY Location, Population
ORDER BY PercenPopulationInfected desc


--Showing Countries with Highest Death Count per Population

SELECT Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc




--Breaking things down by continent


--Showing the continents with the highest death counts

SELECT continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc


-- Global Numbers

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


SELECT *
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
