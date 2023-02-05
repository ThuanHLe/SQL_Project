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
                                                             -- Change 'Y' and 'N' to Yes and No in 'SoldAsVacant' field
SELECT Distinct(SoldAsvacant), COUNT(SoldAsvacant)
FROM Housing.NashvilleHouse
GROUP BY SoldAsvacant
ORDER BY SoldAsvacant;

SELECT SoldAsVacant,
CASE When SoldAsVacant = 'Y' THEN 'Yes'
	 When SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END
FROM Housing.NashvilleHouse;

Update NashvilleHouse
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	 When SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END;

--------------
-- Remove Duplicates
SELECT *
FROM Housing.NashvilleHouse;

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
    PARTITION BY ParcelID,
				 PropertyAddress,
                 SalePrice,
                 SaleDate,
                 LegalReference
				ORDER BY
                UniqueID) row_num
FROM Housing.NashvilleHouse
-- ORDER BY ParcelID
)
DELETE -- SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress;

SELECT *
FROM Housing.NashvilleHouse;

----------------------

-- Delete unused Columns

SELECT *
FROM Housing.NashvilleHouse;

ALTER TABLE Housing.NashvilleHouse
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress;
