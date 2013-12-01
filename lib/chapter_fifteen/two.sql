/*
  Write a SQL query to get a list of all buildings and the number of open
  requests (Requests in which status equals 'Open').
*/

SELECT Buildings.Name, IFNULL(OpenApartments.Amount, 0)
FROM Buildings
LEFT JOIN
  (SELECT Apartments.BuildingId AS BuildingId, COUNT(*) AS Amount
   FROM Apartments
   INNER JOIN Requests
   ON (Apartments.Id = Requests.ApartmentId)
   WHERE Requests.Status = 'Open'
   GROUP BY Apartments.BuildingId) OpenApartments
ON (Buildings.Id = OpenApartments.BuildingId)
