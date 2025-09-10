# Nashville Housing – SQL Data Cleaning  

## 📌 Project Overview  
This project focuses on cleaning and transforming the **Nashville Housing dataset** using SQL Server.  
The goal was to improve **data quality, consistency, and usability**, making the dataset ready for further analysis and visualization.  

## 🛠️ Skills & Tools  
- SQL Server  
- Data Cleaning & Transformation  
- Common Table Expressions (CTEs)  
- Window Functions (`ROW_NUMBER`)  
- String Functions (`SUBSTRING`, `PARSENAME`)  

## 🔑 Key Steps  
1. **Standardized Date Format**  
   - Converted inconsistent `SaleDate` values into a uniform `DATE` format.  

2. **Populated Missing Property Addresses**  
   - Used self-joins and `ISNULL()` to fill in null property addresses from duplicate ParcelIDs.  

3. **Split Address Fields**  
   - Broke down property and owner addresses into **Street / City / State** columns using `SUBSTRING` and `PARSENAME`.  

4. **Unified Categorical Values**  
   - Changed `Y/N` values in *SoldAsVacant* field into `Yes/No` for better readability.  

5. **Removed Duplicates**  
   - Applied `ROW_NUMBER()` within a CTE to identify and delete duplicate records.  

6. **Dropped Unused Columns**  
   - Removed redundant columns (`OwnerAddress`, `TaxDistrict`, `PropertyAddress`, etc.) to optimize the dataset.
     
## ✅ Results

- Delivered a clean, consistent, and structured dataset.
- Improved usability of housing data for future analysis and visualization.

## 📊 Example SQL Query  
```sql
-- Identify and remove duplicates
WITH RowNumCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
               ORDER BY UniqueID
           ) row_num
    FROM NashvilleHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1;
