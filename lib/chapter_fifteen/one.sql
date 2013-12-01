/*
  Write a SQL query to get a list of tenants who are renting more than
  one apartment.
*/

SELECT Tenants.Name
FROM Tenants
INNER JOIN
  (SELECT ApartmentTenants.TenantId AS TenantId
   FROM ApartmentTenants
   GROUP BY ApartmentTenants.TenantId
   HAVING COUNT(*) > 1) MultipleApartments
ON (MultipleApartments.TenantId = Tenants.Id);
