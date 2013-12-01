/*
  Building #11 is undergoing a major renovation. Implement a query to close
  all requests from apartments in this building.

  I'm not making 11 seed buildings for this so Building #11 is going to just
  have to be Building #1.
*/

UPDATE Requests
SET Status = 'Closed'
WHERE Id IN
  (SELECT Apartments.Id
   FROM Apartments
   WHERE Apartments.BuildingId = 1);
