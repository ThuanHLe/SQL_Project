/*
Cleaning Data in SQL Queries
*/

SELECT * FROM Housing.NashvilleHouse;

--
-- Standardized Date Format

SELECT SaleDateConverted, Convert(SaleDate,Date)
FROM Housing.NashvilleHouse;

Update NashvilleHouse
SET SaleDate = Convert(SaleDate,Date);

ALTER TABLE NashvilleHouse
Add SaleDateConverted Date;

Update Nashvillehouse
SET SaleDateConverted = Convert(SaleDate,Date);

-- Populate Property Address data
SELECT *
FROM Housing.NashvilleHouse
-- WHERE PropertyAddress is null
ORDER BY ParcelID;

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Housing.NashvilleHouse a
JOIN Housing.NashvilleHouse b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is null;

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Housing.NashvilleHouse a
JOIN Housing.NashvilleHouse b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is null;

-------------
-- Breaking out Address into Separated Columns (Addess, City, State)

SELECT PropertyAddress
FROM Housing.NashvilleHouse;
-- WHERE PropertyAddress is null
-- ORDER BY ParcelID;

SELECT
SUBSTRING(PropertyAddress, 1, Charindex(',', PropertyAddress, -1 )) AS Address,
SUBSTRING(PropertyAddress, Charindex(',', PropertyAddress, +1, LEN(PropertyAddress))
FROM Housing.NashvilleHouse;

ALTER TABLE NashvilleHouse
Add PropertySplitAddress Nvarchar(255);

Update Nashvillehouse
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, Charindex(',', PropertyAddress, -1 ));

ALTER TABLE NashvilleHouse
Add PropertySplitCity Nvarchar(255);

Update Nashvillehouse
SET PropertySplitCity = SUBSTRING(PropertyAddress, Charindex(',', PropertyAddress, +1, LEN(PropertyAddress);

SELECT *
FROM Housing.NashvilleHouse;
