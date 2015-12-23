-- For use in problems 1 through 3

CREATE TABLE Apartments(
  Id INTEGER PRIMARY KEY,
  UnitNumber TEXT,
  BuildingId INTEGER NOT NULL,

  FOREIGN KEY(BuildingId) REFERENCES Buildings(Id)
);

CREATE TABLE Buildings(
  Id INTEGER PRIMARY KEY,
  Name TEXT,
  Address TEXT,
  ComplexId INTEGER NOT NULL,

  FOREIGN KEY(ComplexId) REFERENCES Complexes(Id)
);

CREATE TABLE Tenants(
  Id INTEGER PRIMARY KEY,
  Name TEXT
);

CREATE TABLE Complexes(
  Id INTEGER PRIMARY KEY,
  Name TEXT
);

CREATE TABLE ApartmentTenants(
  TenantId INTEGER NOT NULL,
  ApartmentId INTEGER NOT NULL,

  FOREIGN KEY(TenantId) REFERENCES Tenants(Id),
  FOREIGN KEY(ApartmentId) REFERENCES Apartments(Id)
);

CREATE TABLE Requests(
  Id INTEGER PRIMARY KEY,
  Status TEXT,
  ApartmentId INTEGER NOT NULL,
  Description TEXT,

  FOREIGN KEY(ApartmentId) REFERENCES Apartments(Id)
);

INSERT INTO Tenants(Name) VALUES ('Alice'),
                                 ('Bob'),
                                 ('Chris'),
                                 ('David'),
                                 ('Edward'),
                                 ('Frank');

INSERT INTO Complexes(Name) VALUES ('Lousy Housing'),
                                   ('Trump Tower'),
                                   ('This isnt a real place');

INSERT INTO Buildings(Name, Address, ComplexId) VALUES ('Smelly South Rise', '2 Stinky Street', 1),
                                                       ('Golden Latrines', '1 Wealthington Row', 2),
                                                       ('Doesnt exist!', '123 Fake Street', 3);

INSERT INTO Apartments(UnitNumber, BuildingId) VALUES ('A13', 1),
                                                      ('B02', 1),
                                                      ('C05', 1),
                                                      ('1000', 2),
                                                      ('2000', 2),
                                                      ('LOL', 3),
                                                      ('ROFL', 3);

INSERT INTO Requests(Status, ApartmentId, Description) VALUES ('Open', 1, ''),
                                                              ('Open', 2, ''),
                                                              ('Closed', 3, ''),
                                                              ('Closed', 4, ''),
                                                              ('Closed', 5, ''),
                                                              ('Closed', 6, ''),
                                                              ('Open', 7, '');

INSERT INTO ApartmentTenants(TenantId, ApartmentId) VALUES (1, 1),
                                                           (1, 2),
                                                           (2, 2),
                                                           (3, 4),
                                                           (3, 5),
                                                           (4, 5),
                                                           (5, 1),
                                                           (5, 2),
                                                           (6, 3);
