USE [master]
GO
/****** Object:  Database [DeptMgtSystem]    Script Date: 6/24/2023 4:44:43 PM ******/
CREATE DATABASE [DeptMgtSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DeptMgtSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DeptMgtSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DeptMgtSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DeptMgtSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DeptMgtSystem] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DeptMgtSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DeptMgtSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DeptMgtSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DeptMgtSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DeptMgtSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DeptMgtSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [DeptMgtSystem] SET  MULTI_USER 
GO
ALTER DATABASE [DeptMgtSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DeptMgtSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DeptMgtSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DeptMgtSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DeptMgtSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DeptMgtSystem] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DeptMgtSystem', N'ON'
GO
ALTER DATABASE [DeptMgtSystem] SET QUERY_STORE = ON
GO
ALTER DATABASE [DeptMgtSystem] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DeptMgtSystem]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAccRankByFNameScalar]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[fnGetAccRankByFNameScalar]
(@FName varchar(50))
returns varchar(50)
Begin
Declare @AccRank varchar(50)
 Select @AccRank=AccRank
from AccRank AR
join Personel P
On P.RankId=AR.RankID
Where FName=@FName
Return @AccRank 
end
GO
/****** Object:  Table [dbo].[Personel]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personel](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FName] [varchar](50) NULL,
	[LName] [varchar](50) NULL,
	[Gender] [varchar](50) NOT NULL,
	[StaffID] [int] NULL,
	[Email] [varchar](50) NULL,
	[DateOfEmployment] [date] NOT NULL,
	[RankId] [int] NULL,
	[specializationID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specializations]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specializations](
	[SpecializationID] [int] IDENTITY(1,1) NOT NULL,
	[Specialization] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecializationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetINstrBySpeclzn]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[fnGetINstrBySpeclzn]
(@Specialization varchar(50))
returns table
As
Return (Select p.FName,p.LName,p.Gender 
from Personel P
join Specializations S
On S.SpecializationID=P.specializationID
Where Specialization=@Specialization)
GO
/****** Object:  Table [dbo].[AccRank]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccRank](
	[RankID] [int] IDENTITY(1,1) NOT NULL,
	[AccRank] [varchar](50) NULL,
	[Salary] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[RankID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetStaffByAccRank]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[fnGetStaffByAccRank]
(@accrank varchar(50))
returns table
As
Return (Select p.FName,p.LName,p.Gender,AR.Salary 
from Personel P
join AccRank AR
On P.RankId=AR.RankID
Where @accrank=accrank)
GO
/****** Object:  Table [dbo].[Campuses]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campuses](
	[CampusID] [int] IDENTITY(1,1) NOT NULL,
	[CampusName] [varchar](50) NOT NULL,
	[Location] [varchar](50) NULL,
	[DistanceFromMainCampus] [decimal](3, 1) NULL,
PRIMARY KEY CLUSTERED 
(
	[CampusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colleges]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colleges](
	[CollegeID] [int] IDENTITY(1,1) NOT NULL,
	[CaampusID] [int] NOT NULL,
	[CollegeName] [varchar](50) NOT NULL,
	[Dean] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CollegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DeptID] [int] IDENTITY(1,1) NOT NULL,
	[CollegeID] [int] NOT NULL,
	[DEPTName] [varchar](50) NOT NULL,
	[DeptHead] [varchar](50) NOT NULL,
	[DeptSecretary] [varchar](50) NOT NULL,
	[PhoneNo] [varchar](50) NOT NULL,
	[Storekeeper] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwMgtLevel]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[VwMgtLevel]
As 
Select D.dEPTName,D.DeptHead,C.CollegeName,C.Dean,Ca.CampusName
From Departments D
Inner join Colleges C
on D.CollegeID=C.CollegeID
inner join Campuses Ca
on C.CaampusID=Ca.CampusID
GO
/****** Object:  Table [dbo].[Recruitment]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recruitment](
	[RecruitmentID] [int] IDENTITY(1,1) NOT NULL,
	[FName] [varchar](50) NULL,
	[LName] [varchar](50) NULL,
	[FieldID] [int] NULL,
	[UGCGPA] [decimal](3, 2) NULL,
	[presentation] [decimal](4, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecruitmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwRecruitmentResult]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vwRecruitmentResult]
 AS
 Select R.FName,R.LName, S.Specialization, Result=Cast(UGCGPA*30/4 +[Presentation] as float)
 from Recruitment R
 Join Specializations S
 On R.FieldID=S.SpecializationID
GO
/****** Object:  View [dbo].[vwStaffProfile]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vwStaffProfile]
AS
Select S.Specialization,AR.AccRank,
Count(P.specializationID) As Subtot
from Personel p
inner join AccRank AR
On P.RankId=AR.RankID
inner join Specializations S
On S.SpecializationID=P.specializationID
Group by Specialization,AccRank
GO
/****** Object:  View [dbo].[vwTotalSalaryBySpclznAndAccRank]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vwTotalSalaryBySpclznAndAccRank]
as
Select S.Specialization,AR.AccRank,TotalSubTotalSalary=Sum(Salary)
from Personel P
join Specializations S
On P.specializationID=S.SpecializationID
join AccRank AR
on AR.RankID=P.RankId
Group by Specialization,AccRank with RollUp

Union all

Select S.Specialization,Null, TotalSubTotalSalary=Sum(Salary)
from Personel P
join Specializations S
On P.specializationID=S.SpecializationID
join AccRank AR
on AR.RankID=P.RankId
Group by Specialization with RollUp


GO
/****** Object:  Table [dbo].[Committee]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Committee](
	[CommitteeID] [int] IDENTITY(1,1) NOT NULL,
	[Committee] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CommitteeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseOffering]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseOffering](
	[InstructorID] [int] NOT NULL,
	[CourseCode] [varchar](50) NOT NULL,
	[InfoID] [int] NOT NULL,
	[NoOfSectionsAssigned] [int] NULL,
	[CommitteeID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseCode] [varchar](50) NOT NULL,
	[CourseTitle] [varchar](50) NOT NULL,
	[CrHr] [int] NOT NULL,
	[ModuleCode] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gradesubmission]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gradesubmission](
	[InstructorID] [int] NULL,
	[CourseCode] [varchar](50) NULL,
	[Gradesubmitted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Modules]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modules](
	[ModuleCode] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ModuleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personel_Audit]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personel_Audit](
	[EmpID] [int] NULL,
	[Fname] [varchar](50) NULL,
	[Lname] [varchar](50) NULL,
	[StaffID] [int] NULL,
	[DateOfEmployment] [date] NULL,
	[RankID] [int] NULL,
	[Audit_Action] [varchar](100) NULL,
	[Audit_Timestamp] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Programs]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programs](
	[ProgramID] [int] IDENTITY(1,1) NOT NULL,
	[Program] [varchar](50) NULL,
	[ProgramCoordinator] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProgramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recruitment_Audit]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recruitment_Audit](
	[Fname] [varchar](50) NULL,
	[UGCGPA] [decimal](3, 2) NULL,
	[Presentation] [int] NULL,
	[Audit_Action] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[StaffCategory] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentsInfo]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentsInfo](
	[InfoID] [int] IDENTITY(1,1) NOT NULL,
	[ProgramID] [int] NULL,
	[StDeptIDID] [int] NULL,
	[ClassYear] [int] NOT NULL,
	[NoOfSections] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AccRank] ON 

INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (1, N'GA I', 4300.0000)
INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (2, N'GA II', 5100.0000)
INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (3, N'AssLec', 7200.0000)
INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (4, N'Lec', 9800.0000)
INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (5, N'AssProf', 10500.0000)
INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (6, N'Prof', 12000.0000)
INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (7, N'AssoProf', 13400.0000)
INSERT [dbo].[AccRank] ([RankID], [AccRank], [Salary]) VALUES (8, N'NA', NULL)
SET IDENTITY_INSERT [dbo].[AccRank] OFF
GO
SET IDENTITY_INSERT [dbo].[Campuses] ON 

INSERT [dbo].[Campuses] ([CampusID], [CampusName], [Location], [DistanceFromMainCampus]) VALUES (1, N'AdiHaki', N'Hawelti', CAST(6.8 AS Decimal(3, 1)))
INSERT [dbo].[Campuses] ([CampusID], [CampusName], [Location], [DistanceFromMainCampus]) VALUES (2, N'Arid', N'Endayesus', CAST(0.0 AS Decimal(3, 1)))
INSERT [dbo].[Campuses] ([CampusID], [CampusName], [Location], [DistanceFromMainCampus]) VALUES (3, N'Ayder', N'3', CAST(7.5 AS Decimal(3, 1)))
INSERT [dbo].[Campuses] ([CampusID], [CampusName], [Location], [DistanceFromMainCampus]) VALUES (4, N'Kalamino', N'17', CAST(5.4 AS Decimal(3, 1)))
INSERT [dbo].[Campuses] ([CampusID], [CampusName], [Location], [DistanceFromMainCampus]) VALUES (5, N'MIT', N'Aynalem', CAST(2.6 AS Decimal(3, 1)))
SET IDENTITY_INSERT [dbo].[Campuses] OFF
GO
SET IDENTITY_INSERT [dbo].[Colleges] ON 

INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (1, 2, N'CNCS', N'HABTU')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (2, 1, N'CSS', N'TAREKEGN')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (3, 2, N'EIT', N'SOLOMON')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (4, 1, N'CBE', N'ZAID')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (5, 4, N'CVM', N'AHMED')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (6, 1, N'CLG', N'GIRMA')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (7, 3, N'CPH', N'LEMMA')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (8, 2, N'CDLANR', N'BERIHU')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (9, 2, N'IPS', N'MENGIE')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (10, 2, N'IWT', N'DANIEL')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (11, 5, N'MIT', N'MELESE')
INSERT [dbo].[Colleges] ([CollegeID], [CaampusID], [CollegeName], [Dean]) VALUES (12, 3, N'CM', N'ASRAT')
SET IDENTITY_INSERT [dbo].[Colleges] OFF
GO
SET IDENTITY_INSERT [dbo].[Committee] ON 

INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (1, N'StCase')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (2, N'Promotion')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (3, N'Research')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (4, N'ComService')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (5, N'Social')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (6, N'Recruit')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (7, N'StCase')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (8, N'Promotion')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (9, N'Research')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (10, N'ComService')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (11, N'Social')
INSERT [dbo].[Committee] ([CommitteeID], [Committee]) VALUES (12, N'Recruit')
SET IDENTITY_INSERT [dbo].[Committee] OFF
GO
INSERT [dbo].[CourseOffering] ([InstructorID], [CourseCode], [InfoID], [NoOfSectionsAssigned], [CommitteeID]) VALUES (20, N'CENG432', 1, 1, 3)
GO
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'CENG432', N'Num Cvl', 4, 2)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH121
', N'Fund Of Alg
', 3, 1)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH122
', N'Linear Alg
', 3, 1)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH130
', N'Fond of Geom
', 3, 8)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH131
', N'Solid Geom
', 2, 8)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH132
', N'Transf Geo
', 3, 8)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH151
', N'Opt I', 3, 3)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH152', N'Opt II', 3, 3)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH153', N'Math Model', 4, 3)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH161
', N'Calc I', 4, 5)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH162
', N'Calc II', 4, 5)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH181
', N'App I', 4, 6)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH182', N'App II', 4, 6)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH223
', N'Abstra Alg
', 4, 1)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH224
', N'Modern Alg
', 3, 1)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH241
', N'Num I', 3, 2)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH242', N'Num II', 3, 2)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH264
', N'Calc For Chem', 4, 7)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH281', N'App III', 4, 6)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH301', N'Prob & Stat', 4, 5)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH361', N'Sev Var', 4, 5)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH405', N'Combinat', 3, 7)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH461
', N'Diff Calc I', 4, 4)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH462', N'Diff Calc II', 4, 4)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH463', N'Complex var', 4, 4)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH761', N'Num PG', 4, 9)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH771', N'Num II PG', 3, 9)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH840', N'Diff PG', 4, 9)
INSERT [dbo].[Courses] ([CourseCode], [CourseTitle], [CrHr], [ModuleCode]) VALUES (N'MATH851', N'Difff II  PG', 4, 9)
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (1, 1, N'Econ', N'Selomie', N'Hadas', N'0914757121', N'dere')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (2, 1, N'Geog', N'Seid', N'Hanas', N'0914748121', N'Barre')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (3, 1, N'Acc', N'Semma', N'Rhel', N'0912748121', N'Bahrua')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (4, 1, N'Marketing', N'Goshu', N'Almaz', N'0920448121', N'Bilewe')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (5, 2, N'Math', N'Yohans', N'Helen', N'0914742921', N'Birhane')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (6, 2, N'Phys', N'Gg', N'Blen', N'0919542921', N'Tewelde')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (7, 2, N'Chem', N'Tsega', N'Asqual', N'0920742921', N'Bire')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (8, 2, N'Geol', N'Kinfe', N'Muna', N'0914745721', N'Negae')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (9, 2, N'Civil', N'Thomas', N'Ribka', N'0922742921', N'Genene')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (10, 2, N'Mech', N'Gere', N'Ruta', N'0915742921', N'Muhe')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (11, 2, N'Ind', N'Kasa', N'Kiros', N'0916742921', N'Lemlem')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (12, 2, N'ELT', N'Weyni', N'Turye', N'0911742921', N'Birara')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (13, 2, N'Irr', N'Lukas', N'Eleni', N'0923742921', N'Saba')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (14, 2, N'Urban', N'Kono', N'menen', N'0914742491', N'Birhanu')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (15, 2, N'CS', N'Abiot', N'Titi', N'0921742921', N'hanebal')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (16, 2, N'Larmep', N'Yonas', N'Helu', N'0911742921', N'Jemal')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (17, 2, N'AgroEcon', N'Mulus', N'Rodas', N'0919742921', N'Bilal')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (18, 2, N'Heritage', N'Werkie', N'Hadera', N'0922742921', N'Aleme')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (19, 3, N'Pharm', N'Yorganos', N'Chuchu', N'0921742521', N'Lwam')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (20, 3, N'Math', N'Derese', N'Hirut', N'0914768987', N'rannu')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (21, 4, N'VM', N'Nasir', N'beti', N'0913742921', N'Ababa')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (22, 4, N'AS', N'Minas', N'Ayto', N'0914572921', N'Argaw')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (23, 5, N'IT', N'Rakev', N'Bisrat', N'0912742901', N'Aberu')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (24, 5, N'EEE', N'Smret', N'Tamru', N'0910749921', N'Teka')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (25, 5, N'CSE', N'Maaza', N'Netsanet', N'0914747896', N'Aregu')
INSERT [dbo].[Departments] ([DeptID], [CollegeID], [DEPTName], [DeptHead], [DeptSecretary], [PhoneNo], [Storekeeper]) VALUES (26, 5, N'BT', N'Belay', N'Hailu', N'0916254521', N'Biniam')
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
INSERT [dbo].[Gradesubmission] ([InstructorID], [CourseCode], [Gradesubmitted]) VALUES (20, N'CENG432', 1)
GO
SET IDENTITY_INSERT [dbo].[Modules] ON 

INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (1, N'Algebra')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (2, N'Numerical')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (3, N'Optimization')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (4, N'Differential')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (5, N'Basic')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (6, N'Common')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (7, N'Supportive')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (8, N'Geometry')
INSERT [dbo].[Modules] ([ModuleCode], [ModuleName]) VALUES (9, N'PG')
SET IDENTITY_INSERT [dbo].[Modules] OFF
GO
SET IDENTITY_INSERT [dbo].[Personel] ON 

INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (5, N'Alem', N'Abebe', N'F', 1, N'Alem@gmail.com', CAST(N'2013-07-23' AS Date), 1, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (6, N'Alemtsehay', N'Shedo', N'F', 1, N'Alemtse@gmail.com', CAST(N'2013-04-24' AS Date), 1, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (7, N'Abate', N'Kisho', N'M', 1, N'Abate@gmail.com', CAST(N'2013-09-16' AS Date), 1, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (8, N'Mammo', N'Gari', N'M', 1, N'Mammo@gmail.com', CAST(N'2013-09-16' AS Date), 2, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (9, N'Debela', N'Dinsa', N'M', 1, N'Debela@gmail.com', CAST(N'2011-01-01' AS Date), 2, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (10, N'Zenu', N'Akal', N'F', 1, N'Zenu@gmail.com', CAST(N'2011-01-01' AS Date), 2, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (11, N'Abiy', N'Ahmed', N'M', 1, N'Abiy@gmail.com', CAST(N'2009-08-06' AS Date), 3, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (12, N'Adanech', N'Abebie', N'F', 1, N'Adanech@gmail.com', CAST(N'2009-08-06' AS Date), 3, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (13, N'Shime', N'Kerk', N'M', 1, N'Shime@gmail.com', CAST(N'2009-08-06' AS Date), 3, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (14, N'Kefe', N'Chekuagnu', N'M', 1, N'Kefe@gmail.com', CAST(N'2009-08-06' AS Date), 3, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (15, N'Kiitaw', N'Mengie', N'M', 1, N'Kiitaw@gmail.com', CAST(N'2008-03-10' AS Date), 3, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (16, N'Wubua', N'Eth', N'F', 1, N'Wubua@gmail.com', CAST(N'1999-12-08' AS Date), 3, 7)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (17, N'Tilahun', N'Ali', N'M', 1, N'Tilahun@gmail.com', CAST(N'2010-07-23' AS Date), 4, 1)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (18, N'Sisay', N'Shediye', N'M', 1, N'Sisay@gmail.com', CAST(N'2011-01-03' AS Date), 4, 1)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (19, N'Zeru', N'Molla', N'M', 1, N'Zeru@gmail.com', CAST(N'1998-04-19' AS Date), 4, 1)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (20, N'Shu', N'Ale', N'M', 1, N'Shu@gmail.com', CAST(N'2006-06-10' AS Date), 4, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (21, N'Fele', N'Get', N'M', 1, N'Fele@gmail.com', CAST(N'2001-01-03' AS Date), 4, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (22, N'Yishak', N'Bir', N'M', 1, N'Yishak@gmail.com', CAST(N'2008-04-25' AS Date), 4, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (23, N'Teme', N'Abera', N'M', 1, N'Teme@gmail.com', CAST(N'2008-04-25' AS Date), 4, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (25, N'Almi', N'Kuku', N'F', 1, N'Almi@gmail.com', CAST(N'2008-04-25' AS Date), 4, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (26, N'Hailu', N'Cheberie', N'M', 1, N'Hailu@gmail.com', CAST(N'2007-02-06' AS Date), 4, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (27, N'Tina', N'Tufa', N'F', 1, N'Tina@gmail.com', CAST(N'2011-02-11' AS Date), 4, 3)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (28, N'Lili', N'Kasa', N'F', 1, N'Lili@gmail.com', CAST(N'1998-03-20' AS Date), 4, 3)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (29, N'Chalie', N'Pet', N'M', 1, N'Chalie@gmail.com', CAST(N'1997-10-16' AS Date), 4, 3)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (30, N'Daniel', N'Tes', N'M', 1, N'Daniel@gmail.com', CAST(N'1999-09-12' AS Date), 4, 3)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (31, N'Get', N'Wale', N'M', 1, N'Get@gmail.com', CAST(N'2002-03-09' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (32, N'Tewedros', N'Chane', N'M', 1, N'Tewedros@gmail.com', CAST(N'2007-02-24' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (33, N'Gize', N'Kef', N'M', 1, N'Gize@gmail.com', CAST(N'2007-09-19' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (34, N'Yeshi', N'Gudu', N'F', 1, N'Yeshi@gmail.com', CAST(N'2002-03-21' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (35, N'Maasho', N'Hi', N'M', 1, N'Maasho@gmail.com', CAST(N'2001-06-27' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (36, N'Mollalgn', N'Arba', N'M', 1, N'Mollalgn@gmail.com', CAST(N'2003-07-15' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (37, N'Said', N'Moha', N'M', 1, N'Said@gmail.com', CAST(N'2005-11-06' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (38, N'Legesse', N'Wetro', N'M', 1, N'Legesse@gmail.com', CAST(N'2008-02-22' AS Date), 4, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (39, N'Thom', N'Cruz', N'M', 1, N'Thom@gmail.com', CAST(N'2010-01-03' AS Date), 4, 5)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (40, N'Gemie', N'Water', N'M', 1, N'Gemie@gmail.com', CAST(N'1999-03-15' AS Date), 4, 5)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (41, N'Atie', N'Abr', N'M', 1, N'Atie@gmail.com', CAST(N'2010-06-03' AS Date), 4, 6)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (42, N'Abrha', N'Tes', N'M', 1, N'Abrha@gmail.com', CAST(N'2004-01-31' AS Date), 4, 6)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (43, N'Helu', N'Atet', N'F', 1, N'Helu@gmail.com', CAST(N'2005-03-12' AS Date), 4, 6)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (44, N'Kassa', N'Lebaw', N'M', 1, N'Kassa@gmail.com', CAST(N'1996-12-26' AS Date), 4, 6)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (45, N'Weynua', N'Bela', N'F', 1, N'Weynua@gmail.com', CAST(N'2001-05-18' AS Date), 4, 6)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (46, N'Bio', N'Logy', N'F', 1, N'Bio@gmail.com', CAST(N'2006-02-27' AS Date), 5, 5)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (47, N'Chem', N'Story', N'M', 1, N'Chem@gmail.com', CAST(N'2008-01-18' AS Date), 5, 6)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (48, N'Phy', N'Kiss', N'M', 1, N'Phy@gmail.com', CAST(N'2006-04-28' AS Date), 5, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (49, N'Spor', N'Tegna', N'F', 1, N'Spor@gmail.com', CAST(N'2001-08-07' AS Date), 5, 6)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (50, N'Drmoron', N'Reas', N'M', 1, N'Drmoron@gmail.com', CAST(N'2010-01-29' AS Date), 6, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (51, N'Drbichegr', N'DD', N'M', 1, N'Drbichegr@gmail.com', CAST(N'1999-10-12' AS Date), 6, 3)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (52, N'Dryazu', N'TT', N'M', 1, N'Dryazu@gmail.com', CAST(N'2005-02-18' AS Date), 6, 3)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (53, N'Drkk', N'Done', N'F', 1, N'Drkk@gmail.com', CAST(N'2000-03-07' AS Date), 6, 4)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (54, N'ProRam', N'Indi', N'M', 1, N'ProRam@gmail.com', CAST(N'2009-11-13' AS Date), 7, 1)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (55, N'ProfShish', N'Nemo', N'F', 1, N'ProfShish@gmail.com', CAST(N'2014-09-28' AS Date), 7, 2)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (56, N'PrDud', N'Zewd', N'M', 1, N'PrDud@gmail.com', CAST(N'2011-04-11' AS Date), 7, 5)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (57, N'Gera', N'Wor', N'M', 1, N'Gera@gmail.com', CAST(N'2009-07-11' AS Date), 4, 9)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (58, N'Semma', N'Zel', N'M', 1, N'Semma@gmail.com', CAST(N'2005-12-14' AS Date), 4, 9)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (59, N'Guesh', N'Ter', N'M', 1, N'Guesh@gmail.com', CAST(N'2011-03-12' AS Date), 3, 9)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (60, N'Aberash', N'Kecho', N'F', 3, N'Aberash@yahoo.com', CAST(N'1997-08-19' AS Date), 8, 8)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (61, N'Tsir', N'Fendas', N'F', 2, N'Tsir@yahoo.com', CAST(N'1999-10-12' AS Date), 8, 8)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (62, N'Wendu', N'Sett', N'F', 3, N'Wendu@yahoo.com', CAST(N'2010-02-14' AS Date), 8, 8)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (63, N'Andn', N'Senef', N'M', 3, N'Andn@yahoo.com', CAST(N'2000-08-09' AS Date), 8, 8)
INSERT [dbo].[Personel] ([EmployeeID], [FName], [LName], [Gender], [StaffID], [Email], [DateOfEmployment], [RankId], [specializationID]) VALUES (119, N'FLebaAuudit', N'LLeba', N'F', 1, N'leleba@gmail.com', CAST(N'2018-10-20' AS Date), 1, 7)
SET IDENTITY_INSERT [dbo].[Personel] OFF
GO
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (5, N'Alem', N'Abebe', 1, NULL, 1, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.180' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (6, N'Alemtse', N'Shedo', 1, NULL, 1, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.183' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (7, N'Abate', N'Kisho', 1, NULL, 1, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.190' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (8, N'Mammo', N'Gari', 1, NULL, 2, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.193' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (9, N'Debela', N'Dinsa', 1, NULL, 2, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.203' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (10, N'Zenu', N'Akal', 1, NULL, 2, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.220' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (11, N'Abiy', N'Ahmed', 1, NULL, 3, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.223' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (12, N'Adanech', N'Abebie', 1, NULL, 3, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.227' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (13, N'Shime', N'Kerk', 1, NULL, 3, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.230' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (14, N'Kefe', N'Chekuagnu', 1, NULL, 3, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.237' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (15, N'Kiitaw', N'Mengie', 1, NULL, 3, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.240' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (16, N'Wubua', N'Eth', 1, NULL, 3, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.243' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (17, N'Tilahun', N'Ali', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.247' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (18, N'Sisay', N'Shediye', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.250' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (19, N'Zeru', N'Molla', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.253' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (20, N'Shu', N'Ale', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.260' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (21, N'Fele', N'Get', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.260' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (22, N'Yishak', N'Bir', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.263' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (23, N'Teme', N'Abera', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.270' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (25, N'Almi', N'Kuku', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.277' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (26, N'Hailu', N'Cheberie', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.280' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (27, N'Tina', N'Tufa', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.283' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (28, N'Lili', N'Kasa', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.290' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (29, N'Chalie', N'Pet', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.293' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (30, N'Daniel', N'Tes', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.297' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (31, N'Get', N'Wale', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.300' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (32, N'Tewedros', N'Chane', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.303' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (33, N'Gize', N'Kef', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.307' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (34, N'Yeshi', N'Gudu', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.310' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (35, N'Maasho', N'Hi', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.313' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (36, N'Mollalgn', N'Arba', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.317' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (37, N'Said', N'Moha', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.320' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (38, N'Legesse', N'Wetro', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.323' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (39, N'Thom', N'Cruz', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.330' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (40, N'Gemie', N'Water', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.333' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (41, N'Atie', N'Abr', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.337' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (42, N'Abrha', N'Tes', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.340' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (43, N'Helu', N'Atet', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.347' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (44, N'Kassa', N'Lebaw', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.350' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (45, N'Weynua', N'Bela', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.353' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (46, N'Bio', N'Logy', 1, NULL, 5, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.360' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (47, N'Chem', N'Story', 1, NULL, 5, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.363' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (48, N'Phy', N'Kiss', 1, NULL, 5, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.367' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (49, N'Spor', N'Tegna', 1, NULL, 5, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.370' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (50, N'Drmoron', N'Reas', 1, NULL, 6, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.373' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (51, N'Drbichegr', N'DD', 1, NULL, 6, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.380' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (52, N'Dryazu', N'TT', 1, NULL, 6, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.383' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (53, N'Drkk', N'Done', 1, NULL, 6, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.387' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (54, N'ProRam', N'Indi', 1, NULL, 7, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.390' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (55, N'ProfShish', N'Nemo', 1, NULL, 7, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.393' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (56, N'PrDud', N'Zewd', 1, NULL, 7, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.397' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (57, N'Gera', N'Wor', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.400' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (58, N'Semma', N'Zel', 1, NULL, 4, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.403' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (59, N'Guesh', N'Ter', 1, NULL, 3, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:33:04.407' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (60, N'Aberash', N'Kecho', 3, NULL, 8, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:36:30.923' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (61, N'Tsir', N'Fendas', 2, NULL, 8, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:36:30.940' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (62, N'Wendu', N'Sett', 3, NULL, 8, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:36:30.963' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (63, N'Andn', N'Senef', 3, NULL, 8, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-22T01:36:30.967' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (119, N'FLebaAuudit', N'LLeba', 1, NULL, 1, N'Inserted Record -- After Insert Trigger.', CAST(N'2023-06-24T16:23:19.810' AS DateTime))
INSERT [dbo].[Personel_Audit] ([EmpID], [Fname], [Lname], [StaffID], [DateOfEmployment], [RankID], [Audit_Action], [Audit_Timestamp]) VALUES (6, N'Alemtsehay', N'Shedo', 1, NULL, 1, N'updated Record.', CAST(N'2023-06-24T16:28:20.703' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Programs] ON 

INSERT [dbo].[Programs] ([ProgramID], [Program], [ProgramCoordinator]) VALUES (1, N'Regular', N'DepHd')
INSERT [dbo].[Programs] ([ProgramID], [Program], [ProgramCoordinator]) VALUES (2, N'Exte', N'Mngr')
INSERT [dbo].[Programs] ([ProgramID], [Program], [ProgramCoordinator]) VALUES (3, N'Summer', N'ContEd')
INSERT [dbo].[Programs] ([ProgramID], [Program], [ProgramCoordinator]) VALUES (4, N'PG', N'Coll')
SET IDENTITY_INSERT [dbo].[Programs] OFF
GO
SET IDENTITY_INSERT [dbo].[Recruitment] ON 

INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (4, N'Alataw', N'Mehari', 2, CAST(3.15 AS Decimal(3, 2)), CAST(40.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (5, N'Getu', N'Zenebe', 1, CAST(3.40 AS Decimal(3, 2)), CAST(48.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (6, N'Summere', N'Aklil', 3, CAST(3.20 AS Decimal(3, 2)), CAST(34.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (7, N'Dibaba', N'Gashaw', 1, CAST(2.90 AS Decimal(3, 2)), CAST(40.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (8, N'Abebaw', N'Mehari', 2, CAST(3.15 AS Decimal(3, 2)), CAST(40.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (9, N'Gemedu', N'Zenebe', 1, CAST(4.00 AS Decimal(3, 2)), CAST(49.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (10, N'Taye', N'kelil', 3, CAST(3.50 AS Decimal(3, 2)), CAST(47.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (11, N'Zafu', N'Gashaw', 1, CAST(2.79 AS Decimal(3, 2)), CAST(32.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (12, N'Chane', N'Mehari', 5, CAST(3.15 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (13, N'Gullie', N'Zenebe', 1, CAST(4.00 AS Decimal(3, 2)), CAST(46.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (14, N'Mammiee', N'Aklil', 3, CAST(3.20 AS Decimal(3, 2)), CAST(44.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (15, N'Eyob', N'Gashaw', 1, CAST(2.90 AS Decimal(3, 2)), CAST(40.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (16, N'Wari', N'Aklil', 3, CAST(3.20 AS Decimal(3, 2)), CAST(43.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (17, N'Dori', N'shawul', 1, CAST(2.90 AS Decimal(3, 2)), CAST(40.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (18, N'Abebaw', N'Mammo', 2, CAST(3.25 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (19, N'Gemedu', N'Abera', 1, CAST(2.80 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (20, N'Taye', N'kelil', 3, CAST(3.60 AS Decimal(3, 2)), CAST(48.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (21, N'Zafu', N'Gashaw', 1, CAST(2.79 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (22, N'Chalew', N'Mehari', 5, CAST(3.14 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (23, N'Nega', N'Ahmed', 1, CAST(2.76 AS Decimal(3, 2)), CAST(39.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (24, N'Solomon', N'seid', 1, CAST(2.99 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (25, N'Genene', N'Meri', 4, CAST(3.15 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (26, N'Gulma', N'Zena', 1, CAST(4.00 AS Decimal(3, 2)), CAST(48.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (27, N'Mana', N'Aklilu', 3, CAST(3.20 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (28, N'Eyob', N'Zewdu', 6, CAST(2.90 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (29, N'SAba', N'Aklil', 3, CAST(3.40 AS Decimal(3, 2)), CAST(41.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (30, N'Pol', N'Rawul', 1, CAST(2.90 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (31, N'Abeba', N'Shewaye', 2, CAST(3.05 AS Decimal(3, 2)), CAST(42.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (32, N'Gemechu', N'Abrham', 1, CAST(2.80 AS Decimal(3, 2)), CAST(38.00 AS Decimal(4, 2)))
INSERT [dbo].[Recruitment] ([RecruitmentID], [FName], [LName], [FieldID], [UGCGPA], [presentation]) VALUES (33, N'Taye', N'seboka', 3, CAST(3.60 AS Decimal(3, 2)), CAST(44.00 AS Decimal(4, 2)))
SET IDENTITY_INSERT [dbo].[Recruitment] OFF
GO
SET IDENTITY_INSERT [dbo].[Specializations] ON 

INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (1, N'Algebra')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (2, N'Numerical')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (3, N'Optimization')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (4, N'Differential')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (5, N'Computitional')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (6, N'Educ')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (7, N'UG')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (8, N'NAcc')
INSERT [dbo].[Specializations] ([SpecializationID], [Specialization]) VALUES (9, N'Geom')
SET IDENTITY_INSERT [dbo].[Specializations] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([StaffID], [StaffCategory]) VALUES (1, N'Acc')
INSERT [dbo].[Staff] ([StaffID], [StaffCategory]) VALUES (2, N'Admin')
INSERT [dbo].[Staff] ([StaffID], [StaffCategory]) VALUES (3, N'Supp')
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentsInfo] ON 

INSERT [dbo].[StudentsInfo] ([InfoID], [ProgramID], [StDeptIDID], [ClassYear], [NoOfSections]) VALUES (1, 1, 5, 2, 3)
INSERT [dbo].[StudentsInfo] ([InfoID], [ProgramID], [StDeptIDID], [ClassYear], [NoOfSections]) VALUES (2, 1, 5, 3, 2)
INSERT [dbo].[StudentsInfo] ([InfoID], [ProgramID], [StDeptIDID], [ClassYear], [NoOfSections]) VALUES (3, 1, 5, 1, 3)
INSERT [dbo].[StudentsInfo] ([InfoID], [ProgramID], [StDeptIDID], [ClassYear], [NoOfSections]) VALUES (4, 2, 5, 1, 2)
INSERT [dbo].[StudentsInfo] ([InfoID], [ProgramID], [StDeptIDID], [ClassYear], [NoOfSections]) VALUES (5, 3, 5, 4, 1)
INSERT [dbo].[StudentsInfo] ([InfoID], [ProgramID], [StDeptIDID], [ClassYear], [NoOfSections]) VALUES (6, 1, 9, 2, 6)
SET IDENTITY_INSERT [dbo].[StudentsInfo] OFF
GO
/****** Object:  Index [UK_Personel_Email]    Script Date: 6/24/2023 4:44:43 PM ******/
ALTER TABLE [dbo].[Personel] ADD  CONSTRAINT [UK_Personel_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccRank] ADD  DEFAULT ('Lecturer') FOR [AccRank]
GO
ALTER TABLE [dbo].[Programs] ADD  CONSTRAINT [DF_Coordinator]  DEFAULT ('DeptHead') FOR [ProgramCoordinator]
GO
ALTER TABLE [dbo].[Colleges]  WITH CHECK ADD FOREIGN KEY([CaampusID])
REFERENCES [dbo].[Campuses] ([CampusID])
GO
ALTER TABLE [dbo].[CourseOffering]  WITH CHECK ADD FOREIGN KEY([CommitteeID])
REFERENCES [dbo].[Committee] ([CommitteeID])
GO
ALTER TABLE [dbo].[CourseOffering]  WITH CHECK ADD FOREIGN KEY([CourseCode])
REFERENCES [dbo].[Courses] ([CourseCode])
GO
ALTER TABLE [dbo].[CourseOffering]  WITH CHECK ADD FOREIGN KEY([InfoID])
REFERENCES [dbo].[StudentsInfo] ([InfoID])
GO
ALTER TABLE [dbo].[CourseOffering]  WITH CHECK ADD FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Personel] ([EmployeeID])
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([ModuleCode])
REFERENCES [dbo].[Modules] ([ModuleCode])
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD FOREIGN KEY([CollegeID])
REFERENCES [dbo].[Colleges] ([CollegeID])
GO
ALTER TABLE [dbo].[Gradesubmission]  WITH CHECK ADD FOREIGN KEY([CourseCode])
REFERENCES [dbo].[Courses] ([CourseCode])
GO
ALTER TABLE [dbo].[Gradesubmission]  WITH CHECK ADD FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Personel] ([EmployeeID])
GO
ALTER TABLE [dbo].[Personel]  WITH CHECK ADD FOREIGN KEY([RankId])
REFERENCES [dbo].[AccRank] ([RankID])
GO
ALTER TABLE [dbo].[Personel]  WITH CHECK ADD FOREIGN KEY([specializationID])
REFERENCES [dbo].[Specializations] ([SpecializationID])
GO
ALTER TABLE [dbo].[Personel]  WITH CHECK ADD FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Recruitment]  WITH CHECK ADD FOREIGN KEY([FieldID])
REFERENCES [dbo].[Specializations] ([SpecializationID])
GO
ALTER TABLE [dbo].[StudentsInfo]  WITH CHECK ADD FOREIGN KEY([ProgramID])
REFERENCES [dbo].[Programs] ([ProgramID])
GO
ALTER TABLE [dbo].[StudentsInfo]  WITH CHECK ADD FOREIGN KEY([StDeptIDID])
REFERENCES [dbo].[Departments] ([DeptID])
GO
ALTER TABLE [dbo].[Campuses]  WITH CHECK ADD  CONSTRAINT [CK_Campuses_Distance] CHECK  (([DistanceFromMainCampus]>=(0) AND [DistanceFromMainCampus]<=(12.0)))
GO
ALTER TABLE [dbo].[Campuses] CHECK CONSTRAINT [CK_Campuses_Distance]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD CHECK  (([phoneNo] like '09[1-2][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Recruitment]  WITH CHECK ADD CHECK  (([UGCGPA]>=(2.75)))
GO
/****** Object:  StoredProcedure [dbo].[spAssignInstructorsForCoursesBySpecializations]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spAssignInstructorsForCoursesBySpecializations]
@InstructorID int,
@CourseCode varchar(50),
@InfoID int,
@NoOfSectionsAssigned int,
@CommitteeID int

as
If @CourseCode like 'Math%0%' and @InstructorID in (Select EmployeeID from Personel where specializationID in (1,5,6))
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else
If @CourseCode like 'Math%2%' and @InstructorID in (Select EmployeeID from Personel where specializationID =1)
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else 
If @CourseCode like 'Math13%' and @InstructorID in (Select EmployeeID from Personel where specializationID=9)
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else
If @CourseCode like 'Math24%' or @CourseCode like 'CENG%'and @InstructorID in (Select EmployeeID from Personel where specializationID=2)
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else
If @CourseCode like 'Math15%' and @InstructorID in (Select EmployeeID from Personel where specializationID=3)
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else 
If @CourseCode like 'Math%6%' or @CourseCode like 'Math%8%' and @InstructorID in (Select EmployeeID from Personel where specializationID in (1,2,3,4))
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else
If @CourseCode like 'Math7%' and @InstructorID in ((Select EmployeeID from Personel where specializationID=2) intersect (Select RankID from AccRank where RankID in (7,8,6)))
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else
If @CourseCode like 'Math8%' and @InstructorID in (Select EmployeeID from Personel where specializationID=4 intersect Select RankID from AccRank where RankID in (7,8,6))
Insert  CourseOffering
Values (@InstructorID,@CourseCode,@InfoID,@NoOfSectionsAssigned,@CommitteeID)
Else
print 'The Course is Not in his/her specialization or check CourseCode & Acc Rank requremnts'
GO
/****** Object:  StoredProcedure [dbo].[spCountbySpclzn]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spCountbySpclzn]
@SpeciacizationID int
As
select count(EmployeeID) as NoOfStaffs from Personel where specializationID=@SpeciacizationID

GO
/****** Object:  StoredProcedure [dbo].[spGeCourseInstruAndStudInfo]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGeCourseInstruAndStudInfo]
@CourseCode nvarchar(25)
As
Select P.FName,P.LName,P.Email,SI.ClassYear,Si.StDeptIDID,SI.ProgramID
From CourseOffering CO
join Personel P
on P.EmployeeID=CO.InstructorID
join StudentsInfo SI
On SI.InfoID=CO.InfoID
Where CourseCode=@CourseCode
GO
/****** Object:  StoredProcedure [dbo].[SpGetAccRankByFNameScalar]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[SpGetAccRankByFNameScalar]
(@FName varchar(50))
AS
 Select P.FName,P.LName,P.Gender,S.specialization,AR.AccRank
from AccRank AR
join Personel P
On P.RankId=AR.RankID
join Specializations S
on S.SpecializationID=P.specializationID
Where FName=@FName
GO
/****** Object:  StoredProcedure [dbo].[SpGetCountInstrByGender1]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SpGetCountInstrByGender1]
@Gender nvarchar(20),
@InstrCount int output
As
Begin
Select  @InstrCount=count(InstrID) from tblInstructors where Gender=@Gender
End
GO
/****** Object:  StoredProcedure [dbo].[spGetDeptHaedAndDean]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spGetDeptHaedAndDean]
@DeptName varchar(50)
As
Select D.DeptHead,D.DeptSecretary,D.PhoneNo,C.Dean
From Departments D
join Colleges C
on D.CollegeID=C.CollegeID
Where dEPTName=@DeptName
GO
/****** Object:  StoredProcedure [dbo].[spGetServiceYrs]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spGetServiceYrs]
 (@FName varchar(50),
 @LName varchar(50))
 As  
 Select Datediff(year,DateOfEmployment,Getdate()) as YearsOfServices
 From personel
 Where FName=@FName and LName=@LName

GO
/****** Object:  StoredProcedure [dbo].[spGetTopYrsOfServiceBySpclzn]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spGetTopYrsOfServiceBySpclzn]
 @Specialization varchar(50)
 as
 With TopNServiceYears (FName,LName,Specialization, YearsOfServices,DRank)
 As
 (
 Select FName,LName,Specialization,
 YearsOfServices=Cast(DateDiff(month,P.DateOfEmployment,Getdate()) as float)/Cast(12 as float),
 Dense_Rank() over (Order by Cast(DateDiff(month,P.DateOfEmployment,Getdate()) as float)/Cast(12 as float) desc) as DRank
 From Personel P
 join Specializations S
 on P.specializationID=S.SpecializationID
 )
 Select top 1 YearsOfServices,FName,LName,Specialization
  from TopNServiceYears
 Where TopNServiceYears.DRank=4 and Specialization=@Specialization

GO
/****** Object:  StoredProcedure [dbo].[spGetTopYrsOfServiceBySpclzn ?????????]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spGetTopYrsOfServiceBySpclzn ?????????]
 @Specialization varchar(50)
 as
 With TopNServiceYears (FName,LName,Specialization, YearsOfServices,DRank)
 As
 (
 Select FName,LName,Specialization,
 YearsOfServices=Cast(DateDiff(month,P.DateOfEmployment,Getdate()) as float)/Cast(12 as float),
 Dense_Rank() over (Order by Cast(DateDiff(month,P.DateOfEmployment,Getdate()) as float)/Cast(12 as float) desc) as DRank
 From Personel P
 join Specializations S
 on P.specializationID=S.SpecializationID
 )
 Select top 1 YearsOfServices,FName,LName,Specialization
  from TopNServiceYears
 Where TopNServiceYears.DRank=4 and Specialization=@Specialization

GO
/****** Object:  StoredProcedure [dbo].[spGetTotalLoadByFName]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetTotalLoadByFName]
(@FName varchar(50))
as
select P.FName,sum(CO.NoOfSectionsAssigned*C.CrHr) as TotalLoad
from CourseOffering CO
join Courses C
On C.CourseCode=CO.CourseCode
join Personel P
on P.EmployeeID=CO.InstructorID
Group by FName
Having FName=@FName
GO
/****** Object:  StoredProcedure [dbo].[spRecruited]    Script Date: 6/24/2023 4:44:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spRecruited]
 @Specialization varchar(50)
As 
 select top 1 Result,FName,LName from vwRecruitmentResult
 Where Specialization=@Specialization


GO
USE [master]
GO
ALTER DATABASE [DeptMgtSystem] SET  READ_WRITE 
GO
