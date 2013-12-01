-- From the chapter introduction, for extra practice

CREATE TABLE Teachers(
  Id INTEGER PRIMARY KEY,
  Name TEXT NOT NULL
);

CREATE TABLE Students(
  Id INTEGER PRIMARY KEY,
  Name TEXT NOT NULL
);

CREATE TABLE Courses(
  Id INTEGER PRIMARY KEY,
  Name TEXT NOT NULL,
  TeacherId INTEGER NOT NULL,

  FOREIGN KEY(TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE StudentCourses(
  CourseId INTEGER NOT NULL,
  StudentId INTEGER NOT NULL,

  FOREIGN KEY(CourseId) REFERENCES Courses(Id),
  FOREIGN KEY(StudentId) REFERENCES Students(Id)
);

INSERT INTO Teachers(Name) VALUES ('a'), ('b'), ('c');

INSERT INTO Students(Name) VALUES ('z'), ('y'), ('x'), ('w'), ('v');

INSERT INTO Courses(Name, TeacherId) VALUES ('big', 1),
                                            ('dum', 1),
                                            ('stuff', 2),
                                            ('skewl', 2);

INSERT INTO StudentCourses(CourseId, StudentId) VALUES (1, 1),
                                                       (2, 1),
                                                       (3, 2),
                                                       (4, 2),
                                                       (2, 3),
                                                       (3, 3);

SELECT Students.Id, Students.Name, IFNULL(CoursesPerStudent.Amount, 0)
FROM Students
LEFT JOIN
  (SELECT StudentCourses.StudentId AS Student, COUNT(*) AS Amount
   FROM StudentCourses
   GROUP BY StudentCourses.StudentId) CoursesPerStudent ON (Students.Id = CoursesPerStudent.Student);

SELECT Teachers.Id, Teachers.Name, IFNULL(StudentsPerTeacher.Amount, 0)
FROM Teachers
LEFT JOIN
  (SELECT Courses.TeacherId AS Teacher, COUNT(*) AS Amount
   FROM Courses
   INNER JOIN StudentCourses ON (Courses.Id = StudentCourses.CourseId)
   GROUP BY Courses.TeacherId) StudentsPerTeacher ON (Teachers.Id = StudentsPerTeacher.Teacher);
