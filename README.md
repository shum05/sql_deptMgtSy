# sql_deptMgtSy
   -------Initial benefits from the DB ---------
-- A db consisting of tables to keep basic files of the department
--Records Job applicants if and only if they fulfil the minima
--select statement to show Staffs and their specialization
--View to show Dept through Campus R/S
--View and pivot function to report staff profile by spclzn and Acc Rank
--SP to get count of staff by specialization
-- A sp that accepts deptName and gives DeptHead info and college dean for that dept.
-- A sp that accepts CoCode and gives Instructor's and students' info
--Inline Table Valued function to get all instructors in a specialization
--table-valued function to get Staff by Acc. Rank
-- Scalar Fun to get  AccRank of an instructor with a given FName
--SP to get Acc Rank By FName
--SP to calculate yrs of Services of a staff
--SP to get Total load by FName
-- SP to assign Instructors for courses-Course Offering!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--View to show Sum of salary by Specialization and Rank
--SP using CTE and CAST to get top N Years of service
--view to calculate and show result for recruitment
--to list instructors who do not submit Grade 
--All about Triggers --Trigger to inform when Personel table is updated as it contains influential columns

------Test Scripts-------

--Staffs by specialization
Select p.FName,s.Specialization
from Personel p
inner join Specializations s
on p.specializationID=s.SpecializationID
order by s.SpecializationID

--View to show Dept through Campus R/S
       Select * from VwMgtLevel

	   --sp for count of staff by specialization
             exec spCountbySpclzn 5

	   --View and pivot function to report staff profile by spclzn and Acc Rank

 --Check
  select * from vwStaffProfile

-- A sp that accepts deptName and gives DeptHead info and college dean for that dept.
       spGetDeptHaedAndDean 'Math'

 -- A sp that accepts CoCode and gives Instructor's amd students info
     spGeCourseInstruAndStudInfo 'CENG432'

--Inline Table Valued function to get all instructors in a specialization

--Checked
Select * from fnGetINstrBySpeclzn('Algebra')

--table-valued function to get Staff by Acc. Rank

Select * from fnGetStaffByAccRank('AssoProf')

-- Scalar Fun to get  AccRank of an instructor with a given FName

     Select  dbo.fnGetAccRankByFNameScalar('Shu')

--SP to get Acc Rank By FName

      SpGetAccRankByFNameScalar 'Shu'

  --SP to calculate yrs of Services of a staff

      spGetServiceYrs 'Shu','Ale'

  --SP to get Total load by FName


Exec spGetTotalLoadByFName 'Shu'

-- SP to assign Instructors for courses-Course Offering

              Exec spAssignInstructorsForCoursesBySpecializations 20,'Math130',1,2,3
			  Exec spAssignInstructorsForCoursesBySpecializations 20,'CENG432',1,1,3
			   Exec spAssignInstructorsForCoursesBySpecializations 20,'MATH771',1,1,3
			  select * from CourseOffering

--View to show Sum of salary by Specialization and Rank

-- check
    Select * From vwTotalSalaryBySpclznAndAccRank

 --SP using CTE and CAST to get top N Years of service   ?????????????????????????

 
 spGetTopYrsOfServiceBySpclzn 'Differential' 

 --view to calculate and show result for recruitment


 Select * From vwRecruitmentResult
 Order by Specialization

 -- Proc that uses the above view to select Recr. winner by spclzn
 
 spRecruited 'Algebra'

 --- vw to get top 3 results by specs
 
 SELECT  *
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY specialization ORDER BY Result DESC) AS row_num
  FROM vwRecruitmentResult
) AS subquery
WHERE row_num <= 3;

 --Grade submission
 select InstructorID
 from Gradesubmission where Gradesubmitted = 1

        --All about Triggers 


--Trigger for insert action in Personel table

               Select * From Personel_Audit


	--Trigger to inform when Personel table is updated as it contains influential columns
