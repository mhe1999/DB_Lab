SELECT d.Name, d.ID, d.Budget, d.Category 
FROM Students as s inner join Departments as d on(s.DepartmentID = d.ID)
WHERE s.StudentNumber = '123';

SELECT StudentID, CourseID, Semester, Year, Grade + 1 as [Grade Plus One]
FROM Taken_Courses

SELECT *
FROM Students
WHERE Students.StudentNumber not in(SELECT T.StudentID
									FROM Taken_Courses as T inner join Courses as C on (T.CourseID = C.ID)
									WHERE C.Title = 'DB') 