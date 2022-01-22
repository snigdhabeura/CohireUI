CREATE DATABASE [Cohire]
GO
USE [Cohire]
GO
CREATE FUNCTION [dbo].[udf_Split] (
    @String NVARCHAR(4000)
    ,@Delimiter CHAR(1)
    )
RETURNS @Results TABLE (Items NVARCHAR(4000))
AS
BEGIN
    DECLARE @Table AS TABLE (String NVARCHAR(max))

    INSERT INTO @Table
    SELECT @String

    INSERT INTO @Results
    SELECT Split.a.value('.', 'VARCHAR(1000)') AS String
    FROM (
        SELECT CAST('<S>' + REPLACE(String, @Delimiter, '</S><S>') + '</S>' AS XML) AS String
        FROM @Table
        ) AS A
    CROSS APPLY String.nodes('/S') AS Split(a)

    RETURN
END
GO
/****** Object:  Table [dbo].[Job_ByCity]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_ByCity](
	[JCId] [int] IDENTITY(1,1) NOT NULL,
	[CityId] [int] NULL,
	[City_Name] [varchar](150) NULL,
	[ChJobID] [varchar](250) NULL,
	[CategoryId] [int] NULL,
	[ExperineceId] [int] NULL,
	[EmploymentId] [int] NULL,
	[Serach_Instance] [varchar](max) NULL,
 CONSTRAINT [PK_Job_ByCity] PRIMARY KEY CLUSTERED 
(
	[JCId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job_Category]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Category_Name] [varchar](150) NULL,
	[Count_Of_Job] [int] NULL,
 CONSTRAINT [PK_Job_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job_City]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_City](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[City_Name] [varchar](150) NULL,
	[Count_Of_Job] [int] NULL,
	[Is_Fetaure] [int] NULL,
 CONSTRAINT [PK_Job_City] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job_EmploymentType]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_EmploymentType](
	[EmploymentId] [int] IDENTITY(1,1) NOT NULL,
	[Employment_Type] [varchar](300) NULL,
	[Count_Of_Job] [int] NULL,
 CONSTRAINT [PK_Job_EmploymentType] PRIMARY KEY CLUSTERED 
(
	[EmploymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job_Expernice]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_Expernice](
	[ExperineceId] [int] IDENTITY(1,1) NOT NULL,
	[Exp_Range] [varchar](150) NULL,
	[Count_Of_Job] [int] NULL,
 CONSTRAINT [PK_Job_Expernice] PRIMARY KEY CLUSTERED 
(
	[ExperineceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobPost]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPost](
	[JobID] [varchar](250) NOT NULL,
	[ChJobID] [varchar](250) NOT NULL,
	[CategoryId] [int] NULL,
	[EmploymentId] [int] NULL,
	[ExperineceId] [int] NULL,
	[PostedByID] [varchar](250) NULL,
	[JobJson] [varchar](max) NULL,
	[SearchInstance] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifyDate] [datetime] NULL,
	[Is_Job] [bit] NULL,
	[Like_Countq] [int] NULL,
	[Comment_Panel] [nvarchar](max) NULL,
 CONSTRAINT [PK_JobPost] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC,
	[ChJobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question_Master]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Master](
	[Question] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Master]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Master](
	[RoleName] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Skill_Master]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skill_Master](
	[SkillName] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Device_Tracking]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Device_Tracking](
	[Device_Track_ID] [int] IDENTITY(1,1) NOT NULL,
	[PostedByID] [varchar](250) NULL,
	[Is_Job] [bit] NULL,
	[ChJobID] [varchar](250) NULL,
	[Ip_Address] [nvarchar](250) NULL,
	[Device_Type] [nvarchar](250) NULL,
	[Action_DateTime] [datetime] NULL,
 CONSTRAINT [PK_User_Device_Tracking] PRIMARY KEY CLUSTERED 
(
	[Device_Track_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Job_ByCity] ON 
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1, NULL, N'bhubaneswar', N'CHJa0051e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (2, NULL, N'banagalore', N'CHJa0051e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (3, NULL, N'pune', N'CHJa0051e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (4, NULL, N'bhubaneswar', N'CHJ711703', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (5, NULL, N'banagalore', N'CHJ711703', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (6, NULL, N'pune', N'CHJ711703', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (7, NULL, N'bhubaneswar', N'CHJ7097d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (8, NULL, N'banagalore', N'CHJ7097d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (9, NULL, N'pune', N'CHJ7097d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (10, NULL, N'bhubaneswar', N'CHJ5244a9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (11, NULL, N'banagalore', N'CHJ5244a9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (12, NULL, N'pune', N'CHJ5244a9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (13, NULL, N'bhubaneswar', N'CHJc64754', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (14, NULL, N'banagalore', N'CHJc64754', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (15, NULL, N'pune', N'CHJc64754', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (16, NULL, N'bhubaneswar', N'CHJ4079f0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (17, NULL, N'banagalore', N'CHJ4079f0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (18, NULL, N'pune', N'CHJ4079f0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (19, NULL, N'bhubaneswar', N'CHJ401dee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (20, NULL, N'banagalore', N'CHJ401dee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (21, NULL, N'pune', N'CHJ401dee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (22, NULL, N'bhubaneswar', N'CHJ9037fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (23, NULL, N'banagalore', N'CHJ9037fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (24, NULL, N'pune', N'CHJ9037fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (25, NULL, N'bhubaneswar', N'CHJc8e348', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (26, NULL, N'banagalore', N'CHJc8e348', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (27, NULL, N'pune', N'CHJc8e348', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (28, NULL, N'bhubaneswar', N'CHJ3e0b73', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (29, NULL, N'banagalore', N'CHJ3e0b73', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (30, NULL, N'pune', N'CHJ3e0b73', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (31, NULL, N'bhubaneswar', N'CHJ161c4a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (32, NULL, N'banagalore', N'CHJ161c4a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (33, NULL, N'pune', N'CHJ161c4a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (34, NULL, N'bhubaneswar', N'CHJ329fb9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (35, NULL, N'banagalore', N'CHJ329fb9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (36, NULL, N'pune', N'CHJ329fb9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (37, NULL, N'bhubaneswar', N'CHJ59e996', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (38, NULL, N'banagalore', N'CHJ59e996', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (39, NULL, N'pune', N'CHJ59e996', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (40, NULL, N'bhubaneswar', N'CHJ17f806', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (41, NULL, N'banagalore', N'CHJ17f806', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (42, NULL, N'pune', N'CHJ17f806', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (43, NULL, N'bhubaneswar', N'CHJb07467', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (44, NULL, N'banagalore', N'CHJb07467', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (45, NULL, N'pune', N'CHJb07467', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (46, NULL, N'bhubaneswar', N'CHJ9e4f98', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (47, NULL, N'banagalore', N'CHJ9e4f98', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (48, NULL, N'pune', N'CHJ9e4f98', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (49, NULL, N'bhubaneswar', N'CHJaa7877', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (50, NULL, N'banagalore', N'CHJaa7877', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (51, NULL, N'pune', N'CHJaa7877', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (52, NULL, N'bhubaneswar', N'CHJ1f64a3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (53, NULL, N'banagalore', N'CHJ1f64a3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (54, NULL, N'pune', N'CHJ1f64a3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (55, NULL, N'bhubaneswar', N'CHJ00e9e6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (56, NULL, N'banagalore', N'CHJ00e9e6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (57, NULL, N'pune', N'CHJ00e9e6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (58, NULL, N'bhubaneswar', N'CHJ486863', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (59, NULL, N'banagalore', N'CHJ486863', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (60, NULL, N'pune', N'CHJ486863', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (61, NULL, N'bhubaneswar', N'CHJc99b0d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (62, NULL, N'banagalore', N'CHJc99b0d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (63, NULL, N'pune', N'CHJc99b0d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (64, NULL, N'bhubaneswar', N'CHJfd9c26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (65, NULL, N'banagalore', N'CHJfd9c26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (66, NULL, N'pune', N'CHJfd9c26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (67, NULL, N'bhubaneswar', N'CHJf85798', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (68, NULL, N'banagalore', N'CHJf85798', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (69, NULL, N'pune', N'CHJf85798', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (70, NULL, N'bhubaneswar', N'CHJ605d08', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (71, NULL, N'banagalore', N'CHJ605d08', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (72, NULL, N'pune', N'CHJ605d08', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (73, NULL, N'bhubaneswar', N'CHJe2700e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (74, NULL, N'banagalore', N'CHJe2700e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (75, NULL, N'pune', N'CHJe2700e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (76, NULL, N'bhubaneswar', N'CHJ82a65c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (77, NULL, N'banagalore', N'CHJ82a65c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (78, NULL, N'pune', N'CHJ82a65c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (79, NULL, N'bhubaneswar', N'CHJ758bb2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (80, NULL, N'banagalore', N'CHJ758bb2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (81, NULL, N'pune', N'CHJ758bb2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (82, NULL, N'bhubaneswar', N'CHJ8f4771', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (83, NULL, N'banagalore', N'CHJ8f4771', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (84, NULL, N'pune', N'CHJ8f4771', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (85, NULL, N'bhubaneswar', N'CHJ3805d8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (86, NULL, N'banagalore', N'CHJ3805d8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (87, NULL, N'pune', N'CHJ3805d8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (88, NULL, N'bhubaneswar', N'CHJcfa8be', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (89, NULL, N'banagalore', N'CHJcfa8be', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (90, NULL, N'pune', N'CHJcfa8be', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (91, NULL, N'bhubaneswar', N'CHJ61f3ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (92, NULL, N'banagalore', N'CHJ61f3ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (93, NULL, N'pune', N'CHJ61f3ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (94, NULL, N'bhubaneswar', N'CHJf19da2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (95, NULL, N'banagalore', N'CHJf19da2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (96, NULL, N'pune', N'CHJf19da2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (97, NULL, N'bhubaneswar', N'CHJ1731ed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (98, NULL, N'banagalore', N'CHJ1731ed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (99, NULL, N'pune', N'CHJ1731ed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (100, NULL, N'bhubaneswar', N'CHJbf52aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (101, NULL, N'banagalore', N'CHJbf52aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (102, NULL, N'pune', N'CHJbf52aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (103, NULL, N'bhubaneswar', N'CHJd2ed22', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (104, NULL, N'banagalore', N'CHJd2ed22', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (105, NULL, N'pune', N'CHJd2ed22', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (106, NULL, N'bhubaneswar', N'CHJd10edc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (107, NULL, N'banagalore', N'CHJd10edc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (108, NULL, N'pune', N'CHJd10edc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (109, NULL, N'bhubaneswar', N'CHJ0d6a58', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (110, NULL, N'banagalore', N'CHJ0d6a58', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (111, NULL, N'pune', N'CHJ0d6a58', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (112, NULL, N'bhubaneswar', N'CHJ1fa181', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (113, NULL, N'banagalore', N'CHJ1fa181', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (114, NULL, N'pune', N'CHJ1fa181', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (115, NULL, N'bhubaneswar', N'CHJc83baa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (116, NULL, N'banagalore', N'CHJc83baa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (117, NULL, N'pune', N'CHJc83baa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (118, NULL, N'bhubaneswar', N'CHJfdd752', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (119, NULL, N'banagalore', N'CHJfdd752', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (120, NULL, N'pune', N'CHJfdd752', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (121, NULL, N'bhubaneswar', N'CHJ9f66fd', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (122, NULL, N'banagalore', N'CHJ9f66fd', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (123, NULL, N'pune', N'CHJ9f66fd', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (124, NULL, N'bhubaneswar', N'CHJfd11fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (125, NULL, N'banagalore', N'CHJfd11fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (126, NULL, N'pune', N'CHJfd11fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (127, NULL, N'bhubaneswar', N'CHJ6b228a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (128, NULL, N'banagalore', N'CHJ6b228a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (129, NULL, N'pune', N'CHJ6b228a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (130, NULL, N'bhubaneswar', N'CHJd8729d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (131, NULL, N'banagalore', N'CHJd8729d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (132, NULL, N'pune', N'CHJd8729d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (133, NULL, N'bhubaneswar', N'CHJ3f781f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (134, NULL, N'banagalore', N'CHJ3f781f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (135, NULL, N'pune', N'CHJ3f781f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (136, NULL, N'bhubaneswar', N'CHJ6aa865', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (137, NULL, N'banagalore', N'CHJ6aa865', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (138, NULL, N'pune', N'CHJ6aa865', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (139, NULL, N'bhubaneswar', N'CHJc49aa9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (140, NULL, N'banagalore', N'CHJc49aa9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (141, NULL, N'pune', N'CHJc49aa9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (142, NULL, N'bhubaneswar', N'CHJe4f066', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (143, NULL, N'banagalore', N'CHJe4f066', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (144, NULL, N'pune', N'CHJe4f066', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (145, NULL, N'bhubaneswar', N'CHJ988b4c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (146, NULL, N'banagalore', N'CHJ988b4c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (147, NULL, N'pune', N'CHJ988b4c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (148, NULL, N'bhubaneswar', N'CHJb7329e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (149, NULL, N'banagalore', N'CHJb7329e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (150, NULL, N'pune', N'CHJb7329e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (151, NULL, N'bhubaneswar', N'CHJd69fe8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (152, NULL, N'banagalore', N'CHJd69fe8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (153, NULL, N'pune', N'CHJd69fe8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (154, NULL, N'bhubaneswar', N'CHJ79dfcb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (155, NULL, N'banagalore', N'CHJ79dfcb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (156, NULL, N'pune', N'CHJ79dfcb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (157, NULL, N'bhubaneswar', N'CHJc6c50f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (158, NULL, N'banagalore', N'CHJc6c50f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (159, NULL, N'pune', N'CHJc6c50f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (160, NULL, N'bhubaneswar', N'CHJa97d7d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (161, NULL, N'banagalore', N'CHJa97d7d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (162, NULL, N'pune', N'CHJa97d7d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (163, NULL, N'bhubaneswar', N'CHJ0e427f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (164, NULL, N'banagalore', N'CHJ0e427f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (165, NULL, N'pune', N'CHJ0e427f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (166, NULL, N'bhubaneswar', N'CHJ6b1ee3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (167, NULL, N'banagalore', N'CHJ6b1ee3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (168, NULL, N'pune', N'CHJ6b1ee3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (169, NULL, N'bhubaneswar', N'CHJ7e7cfa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (170, NULL, N'banagalore', N'CHJ7e7cfa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (171, NULL, N'pune', N'CHJ7e7cfa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (172, NULL, N'bhubaneswar', N'CHJa79b2b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (173, NULL, N'banagalore', N'CHJa79b2b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (174, NULL, N'pune', N'CHJa79b2b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (175, NULL, N'bhubaneswar', N'CHJ6e0e94', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (176, NULL, N'banagalore', N'CHJ6e0e94', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (177, NULL, N'pune', N'CHJ6e0e94', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (178, NULL, N'bhubaneswar', N'CHJ925d3c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (179, NULL, N'banagalore', N'CHJ925d3c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (180, NULL, N'pune', N'CHJ925d3c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (181, NULL, N'bhubaneswar', N'CHJ32d466', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (182, NULL, N'banagalore', N'CHJ32d466', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (183, NULL, N'pune', N'CHJ32d466', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (184, NULL, N'bhubaneswar', N'CHJ2aff66', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (185, NULL, N'banagalore', N'CHJ2aff66', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (186, NULL, N'pune', N'CHJ2aff66', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (187, NULL, N'bhubaneswar', N'CHJ53cbd8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (188, NULL, N'banagalore', N'CHJ53cbd8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (189, NULL, N'pune', N'CHJ53cbd8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (190, NULL, N'bhubaneswar', N'CHJ448cf5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (191, NULL, N'banagalore', N'CHJ448cf5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (192, NULL, N'pune', N'CHJ448cf5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (193, NULL, N'bhubaneswar', N'CHJfa9eea', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (194, NULL, N'banagalore', N'CHJfa9eea', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (195, NULL, N'pune', N'CHJfa9eea', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (196, NULL, N'bhubaneswar', N'CHJ0bb16f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (197, NULL, N'banagalore', N'CHJ0bb16f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (198, NULL, N'pune', N'CHJ0bb16f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (199, NULL, N'bhubaneswar', N'CHJ805498', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (200, NULL, N'banagalore', N'CHJ805498', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (201, NULL, N'pune', N'CHJ805498', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (202, NULL, N'bhubaneswar', N'CHJac3459', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (203, NULL, N'banagalore', N'CHJac3459', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (204, NULL, N'pune', N'CHJac3459', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (205, NULL, N'bhubaneswar', N'CHJc94465', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (206, NULL, N'banagalore', N'CHJc94465', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (207, NULL, N'pune', N'CHJc94465', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (208, NULL, N'bhubaneswar', N'CHJc8beef', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (209, NULL, N'banagalore', N'CHJc8beef', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (210, NULL, N'pune', N'CHJc8beef', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (211, NULL, N'bhubaneswar', N'CHJbe50f2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (212, NULL, N'banagalore', N'CHJbe50f2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (213, NULL, N'pune', N'CHJbe50f2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (214, NULL, N'bhubaneswar', N'CHJ8687db', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (215, NULL, N'banagalore', N'CHJ8687db', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (216, NULL, N'pune', N'CHJ8687db', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (217, NULL, N'bhubaneswar', N'CHJ1a5f88', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (218, NULL, N'banagalore', N'CHJ1a5f88', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (219, NULL, N'pune', N'CHJ1a5f88', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (220, NULL, N'bhubaneswar', N'CHJ7ee344', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (221, NULL, N'banagalore', N'CHJ7ee344', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (222, NULL, N'pune', N'CHJ7ee344', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (223, NULL, N'bhubaneswar', N'CHJ6b552a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (224, NULL, N'banagalore', N'CHJ6b552a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (225, NULL, N'pune', N'CHJ6b552a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (226, NULL, N'bhubaneswar', N'CHJ81f424', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (227, NULL, N'banagalore', N'CHJ81f424', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (228, NULL, N'pune', N'CHJ81f424', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (229, NULL, N'bhubaneswar', N'CHJa77020', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (230, NULL, N'banagalore', N'CHJa77020', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (231, NULL, N'pune', N'CHJa77020', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (232, NULL, N'bhubaneswar', N'CHJd4ce1f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (233, NULL, N'banagalore', N'CHJd4ce1f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (234, NULL, N'pune', N'CHJd4ce1f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (235, NULL, N'bhubaneswar', N'CHJ12faed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (236, NULL, N'banagalore', N'CHJ12faed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (237, NULL, N'pune', N'CHJ12faed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (238, NULL, N'bhubaneswar', N'CHJ17dfb4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (239, NULL, N'banagalore', N'CHJ17dfb4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (240, NULL, N'pune', N'CHJ17dfb4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (241, NULL, N'bhubaneswar', N'CHJ4d051f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (242, NULL, N'banagalore', N'CHJ4d051f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (243, NULL, N'pune', N'CHJ4d051f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (244, NULL, N'bhubaneswar', N'CHJee078d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (245, NULL, N'banagalore', N'CHJee078d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (246, NULL, N'pune', N'CHJee078d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (247, NULL, N'bhubaneswar', N'CHJ367023', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (248, NULL, N'banagalore', N'CHJ367023', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (249, NULL, N'pune', N'CHJ367023', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (250, NULL, N'bhubaneswar', N'CHJfd126c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (251, NULL, N'banagalore', N'CHJfd126c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (252, NULL, N'pune', N'CHJfd126c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (253, NULL, N'bhubaneswar', N'CHJb5628b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (254, NULL, N'banagalore', N'CHJb5628b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (255, NULL, N'pune', N'CHJb5628b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (256, NULL, N'bhubaneswar', N'CHJ2e9b3f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (257, NULL, N'banagalore', N'CHJ2e9b3f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (258, NULL, N'pune', N'CHJ2e9b3f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (259, NULL, N'bhubaneswar', N'CHJ91059c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (260, NULL, N'banagalore', N'CHJ91059c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (261, NULL, N'pune', N'CHJ91059c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (262, NULL, N'bhubaneswar', N'CHJf25789', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (263, NULL, N'banagalore', N'CHJf25789', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (264, NULL, N'pune', N'CHJf25789', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (265, NULL, N'bhubaneswar', N'CHJ91aece', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (266, NULL, N'banagalore', N'CHJ91aece', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (267, NULL, N'pune', N'CHJ91aece', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (268, NULL, N'bhubaneswar', N'CHJ0c334d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (269, NULL, N'banagalore', N'CHJ0c334d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (270, NULL, N'pune', N'CHJ0c334d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (271, NULL, N'bhubaneswar', N'CHJffe689', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (272, NULL, N'banagalore', N'CHJffe689', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (273, NULL, N'pune', N'CHJffe689', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (274, NULL, N'bhubaneswar', N'CHJa60cc6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (275, NULL, N'banagalore', N'CHJa60cc6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (276, NULL, N'pune', N'CHJa60cc6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (277, NULL, N'bhubaneswar', N'CHJ8f67ba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (278, NULL, N'banagalore', N'CHJ8f67ba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (279, NULL, N'pune', N'CHJ8f67ba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (280, NULL, N'bhubaneswar', N'CHJc2c20d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (281, NULL, N'banagalore', N'CHJc2c20d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (282, NULL, N'pune', N'CHJc2c20d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (283, NULL, N'bhubaneswar', N'CHJ1d2e36', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (284, NULL, N'banagalore', N'CHJ1d2e36', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (285, NULL, N'pune', N'CHJ1d2e36', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (286, NULL, N'bhubaneswar', N'CHJead7aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (287, NULL, N'banagalore', N'CHJead7aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (288, NULL, N'pune', N'CHJead7aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (289, NULL, N'bhubaneswar', N'CHJ4189a1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (290, NULL, N'banagalore', N'CHJ4189a1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (291, NULL, N'pune', N'CHJ4189a1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (292, NULL, N'bhubaneswar', N'CHJe82c13', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (293, NULL, N'banagalore', N'CHJe82c13', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (294, NULL, N'pune', N'CHJe82c13', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (295, NULL, N'bhubaneswar', N'CHJ58b223', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (296, NULL, N'banagalore', N'CHJ58b223', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (297, NULL, N'pune', N'CHJ58b223', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (298, NULL, N'bhubaneswar', N'CHJ8c2be8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (299, NULL, N'banagalore', N'CHJ8c2be8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (300, NULL, N'pune', N'CHJ8c2be8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (301, NULL, N'bhubaneswar', N'CHJe2ed22', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (302, NULL, N'banagalore', N'CHJe2ed22', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (303, NULL, N'pune', N'CHJe2ed22', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (304, NULL, N'bhubaneswar', N'CHJ9529df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (305, NULL, N'banagalore', N'CHJ9529df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (306, NULL, N'pune', N'CHJ9529df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (307, NULL, N'bhubaneswar', N'CHJ072e60', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (308, NULL, N'banagalore', N'CHJ072e60', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (309, NULL, N'pune', N'CHJ072e60', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (310, NULL, N'bhubaneswar', N'CHJ869d81', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (311, NULL, N'banagalore', N'CHJ869d81', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (312, NULL, N'pune', N'CHJ869d81', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (313, NULL, N'bhubaneswar', N'CHJ9a086a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (314, NULL, N'banagalore', N'CHJ9a086a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (315, NULL, N'pune', N'CHJ9a086a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (316, NULL, N'bhubaneswar', N'CHJc267df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (317, NULL, N'banagalore', N'CHJc267df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (318, NULL, N'pune', N'CHJc267df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (319, NULL, N'bhubaneswar', N'CHJ3c66ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (320, NULL, N'banagalore', N'CHJ3c66ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (321, NULL, N'pune', N'CHJ3c66ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (322, NULL, N'bhubaneswar', N'CHJ808df9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (323, NULL, N'banagalore', N'CHJ808df9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (324, NULL, N'pune', N'CHJ808df9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (325, NULL, N'bhubaneswar', N'CHJ9890d7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (326, NULL, N'banagalore', N'CHJ9890d7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (327, NULL, N'pune', N'CHJ9890d7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (328, NULL, N'bhubaneswar', N'CHJddaa23', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (329, NULL, N'banagalore', N'CHJddaa23', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (330, NULL, N'pune', N'CHJddaa23', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (331, NULL, N'bhubaneswar', N'CHJdad80b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (332, NULL, N'banagalore', N'CHJdad80b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (333, NULL, N'pune', N'CHJdad80b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (334, NULL, N'bhubaneswar', N'CHJ64d865', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (335, NULL, N'banagalore', N'CHJ64d865', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (336, NULL, N'pune', N'CHJ64d865', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (337, NULL, N'bhubaneswar', N'CHJc6cd1d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (338, NULL, N'banagalore', N'CHJc6cd1d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (339, NULL, N'pune', N'CHJc6cd1d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (340, NULL, N'bhubaneswar', N'CHJf049be', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (341, NULL, N'banagalore', N'CHJf049be', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (342, NULL, N'pune', N'CHJf049be', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (343, NULL, N'bhubaneswar', N'CHJ9d2512', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (344, NULL, N'banagalore', N'CHJ9d2512', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (345, NULL, N'pune', N'CHJ9d2512', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (346, NULL, N'bhubaneswar', N'CHJf4e886', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (347, NULL, N'banagalore', N'CHJf4e886', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (348, NULL, N'pune', N'CHJf4e886', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (349, NULL, N'bhubaneswar', N'CHJ654306', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (350, NULL, N'banagalore', N'CHJ654306', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (351, NULL, N'pune', N'CHJ654306', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (352, NULL, N'bhubaneswar', N'CHJ0638b8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (353, NULL, N'banagalore', N'CHJ0638b8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (354, NULL, N'pune', N'CHJ0638b8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (355, NULL, N'bhubaneswar', N'CHJ4fc625', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (356, NULL, N'banagalore', N'CHJ4fc625', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (357, NULL, N'pune', N'CHJ4fc625', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (358, NULL, N'bhubaneswar', N'CHJ95819b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (359, NULL, N'banagalore', N'CHJ95819b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (360, NULL, N'pune', N'CHJ95819b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (361, NULL, N'bhubaneswar', N'CHJc3b1fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (362, NULL, N'banagalore', N'CHJc3b1fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (363, NULL, N'pune', N'CHJc3b1fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (364, NULL, N'bhubaneswar', N'CHJ33e554', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (365, NULL, N'banagalore', N'CHJ33e554', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (366, NULL, N'pune', N'CHJ33e554', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (367, NULL, N'bhubaneswar', N'CHJb49e8b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (368, NULL, N'banagalore', N'CHJb49e8b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (369, NULL, N'pune', N'CHJb49e8b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (370, NULL, N'bhubaneswar', N'CHJea5270', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (371, NULL, N'banagalore', N'CHJea5270', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (372, NULL, N'pune', N'CHJea5270', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (373, NULL, N'bhubaneswar', N'CHJfbf05e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (374, NULL, N'banagalore', N'CHJfbf05e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (375, NULL, N'pune', N'CHJfbf05e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (376, NULL, N'bhubaneswar', N'CHJcf87e0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (377, NULL, N'banagalore', N'CHJcf87e0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (378, NULL, N'pune', N'CHJcf87e0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (379, NULL, N'bhubaneswar', N'CHJb615b4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (380, NULL, N'banagalore', N'CHJb615b4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (381, NULL, N'pune', N'CHJb615b4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (382, NULL, N'bhubaneswar', N'CHJb6723a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (383, NULL, N'banagalore', N'CHJb6723a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (384, NULL, N'pune', N'CHJb6723a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (385, NULL, N'bhubaneswar', N'CHJ7db283', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (386, NULL, N'banagalore', N'CHJ7db283', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (387, NULL, N'pune', N'CHJ7db283', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (388, NULL, N'bhubaneswar', N'CHJ3e278d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (389, NULL, N'banagalore', N'CHJ3e278d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (390, NULL, N'pune', N'CHJ3e278d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (391, NULL, N'bhubaneswar', N'CHJ5ce9df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (392, NULL, N'banagalore', N'CHJ5ce9df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (393, NULL, N'pune', N'CHJ5ce9df', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (394, NULL, N'bhubaneswar', N'CHJe2ef87', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (395, NULL, N'banagalore', N'CHJe2ef87', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (396, NULL, N'pune', N'CHJe2ef87', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (397, NULL, N'bhubaneswar', N'CHJdfc440', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (398, NULL, N'banagalore', N'CHJdfc440', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (399, NULL, N'pune', N'CHJdfc440', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (400, NULL, N'bhubaneswar', N'CHJb216c7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (401, NULL, N'banagalore', N'CHJb216c7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (402, NULL, N'pune', N'CHJb216c7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (403, NULL, N'bhubaneswar', N'CHJfc4b98', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (404, NULL, N'banagalore', N'CHJfc4b98', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (405, NULL, N'pune', N'CHJfc4b98', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (406, NULL, N'bhubaneswar', N'CHJ76f8c7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (407, NULL, N'banagalore', N'CHJ76f8c7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (408, NULL, N'pune', N'CHJ76f8c7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (409, NULL, N'bhubaneswar', N'CHJf3a441', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (410, NULL, N'banagalore', N'CHJf3a441', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (411, NULL, N'pune', N'CHJf3a441', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (412, NULL, N'bhubaneswar', N'CHJ0d82b6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (413, NULL, N'banagalore', N'CHJ0d82b6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (414, NULL, N'pune', N'CHJ0d82b6', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (415, NULL, N'bhubaneswar', N'CHJ3b1439', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (416, NULL, N'banagalore', N'CHJ3b1439', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (417, NULL, N'pune', N'CHJ3b1439', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (418, NULL, N'bhubaneswar', N'CHJecf581', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (419, NULL, N'banagalore', N'CHJecf581', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (420, NULL, N'pune', N'CHJecf581', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (421, NULL, N'bhubaneswar', N'CHJ40dfa3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (422, NULL, N'banagalore', N'CHJ40dfa3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (423, NULL, N'pune', N'CHJ40dfa3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (424, NULL, N'bhubaneswar', N'CHJc6906e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (425, NULL, N'banagalore', N'CHJc6906e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (426, NULL, N'pune', N'CHJc6906e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (427, NULL, N'bhubaneswar', N'CHJdd2d8e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (428, NULL, N'banagalore', N'CHJdd2d8e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (429, NULL, N'pune', N'CHJdd2d8e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (430, NULL, N'bhubaneswar', N'CHJ442354', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (431, NULL, N'banagalore', N'CHJ442354', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (432, NULL, N'pune', N'CHJ442354', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (433, NULL, N'bhubaneswar', N'CHJ5562a7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (434, NULL, N'banagalore', N'CHJ5562a7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (435, NULL, N'pune', N'CHJ5562a7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (436, NULL, N'bhubaneswar', N'CHJ8c2805', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (437, NULL, N'banagalore', N'CHJ8c2805', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (438, NULL, N'pune', N'CHJ8c2805', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (439, NULL, N'bhubaneswar', N'CHJ301f99', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (440, NULL, N'banagalore', N'CHJ301f99', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (441, NULL, N'pune', N'CHJ301f99', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (442, NULL, N'bhubaneswar', N'CHJ8b5aab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (443, NULL, N'banagalore', N'CHJ8b5aab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (444, NULL, N'pune', N'CHJ8b5aab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (445, NULL, N'bhubaneswar', N'CHJ2ca96a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (446, NULL, N'banagalore', N'CHJ2ca96a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (447, NULL, N'pune', N'CHJ2ca96a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (448, NULL, N'bhubaneswar', N'CHJ42b7f1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (449, NULL, N'banagalore', N'CHJ42b7f1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (450, NULL, N'pune', N'CHJ42b7f1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (451, NULL, N'bhubaneswar', N'CHJ0c3dba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (452, NULL, N'banagalore', N'CHJ0c3dba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (453, NULL, N'pune', N'CHJ0c3dba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (454, NULL, N'bhubaneswar', N'CHJ5f7f5e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (455, NULL, N'banagalore', N'CHJ5f7f5e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (456, NULL, N'pune', N'CHJ5f7f5e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (457, NULL, N'bhubaneswar', N'CHJc8dbca', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (458, NULL, N'banagalore', N'CHJc8dbca', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (459, NULL, N'pune', N'CHJc8dbca', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (460, NULL, N'bhubaneswar', N'CHJb59aad', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (461, NULL, N'banagalore', N'CHJb59aad', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (462, NULL, N'pune', N'CHJb59aad', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (463, NULL, N'bhubaneswar', N'CHJ110071', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (464, NULL, N'banagalore', N'CHJ110071', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (465, NULL, N'pune', N'CHJ110071', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (466, NULL, N'bhubaneswar', N'CHJ4168aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (467, NULL, N'banagalore', N'CHJ4168aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (468, NULL, N'pune', N'CHJ4168aa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (469, NULL, N'bhubaneswar', N'CHJ0f9e5d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (470, NULL, N'banagalore', N'CHJ0f9e5d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (471, NULL, N'pune', N'CHJ0f9e5d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (472, NULL, N'bhubaneswar', N'CHJ50b355', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (473, NULL, N'banagalore', N'CHJ50b355', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (474, NULL, N'pune', N'CHJ50b355', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (475, NULL, N'bhubaneswar', N'CHJ929d96', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (476, NULL, N'banagalore', N'CHJ929d96', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (477, NULL, N'pune', N'CHJ929d96', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (478, NULL, N'bhubaneswar', N'CHJ1acc42', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (479, NULL, N'banagalore', N'CHJ1acc42', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (480, NULL, N'pune', N'CHJ1acc42', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (481, NULL, N'bhubaneswar', N'CHJcb6582', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (482, NULL, N'banagalore', N'CHJcb6582', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (483, NULL, N'pune', N'CHJcb6582', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (484, NULL, N'bhubaneswar', N'CHJ5d9cf4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (485, NULL, N'banagalore', N'CHJ5d9cf4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (486, NULL, N'pune', N'CHJ5d9cf4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (487, NULL, N'bhubaneswar', N'CHJa7a157', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (488, NULL, N'banagalore', N'CHJa7a157', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (489, NULL, N'pune', N'CHJa7a157', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (490, NULL, N'bhubaneswar', N'CHJa1952c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (491, NULL, N'banagalore', N'CHJa1952c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (492, NULL, N'pune', N'CHJa1952c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (493, NULL, N'bhubaneswar', N'CHJ7b0505', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (494, NULL, N'banagalore', N'CHJ7b0505', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (495, NULL, N'pune', N'CHJ7b0505', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (496, NULL, N'bhubaneswar', N'CHJf0e577', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (497, NULL, N'banagalore', N'CHJf0e577', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (498, NULL, N'pune', N'CHJf0e577', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (499, NULL, N'bhubaneswar', N'CHJf4b5c4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (500, NULL, N'banagalore', N'CHJf4b5c4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (501, NULL, N'pune', N'CHJf4b5c4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (502, NULL, N'bhubaneswar', N'CHJc89ecf', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (503, NULL, N'banagalore', N'CHJc89ecf', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (504, NULL, N'pune', N'CHJc89ecf', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (505, NULL, N'bhubaneswar', N'CHJ901ab3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (506, NULL, N'banagalore', N'CHJ901ab3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (507, NULL, N'pune', N'CHJ901ab3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (508, NULL, N'bhubaneswar', N'CHJ07b510', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (509, NULL, N'banagalore', N'CHJ07b510', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (510, NULL, N'pune', N'CHJ07b510', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (511, NULL, N'bhubaneswar', N'CHJ037725', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (512, NULL, N'banagalore', N'CHJ037725', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (513, NULL, N'pune', N'CHJ037725', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (514, NULL, N'bhubaneswar', N'CHJd8e8fb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (515, NULL, N'banagalore', N'CHJd8e8fb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (516, NULL, N'pune', N'CHJd8e8fb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (517, NULL, N'bhubaneswar', N'CHJ481d9f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (518, NULL, N'banagalore', N'CHJ481d9f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (519, NULL, N'pune', N'CHJ481d9f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (520, NULL, N'bhubaneswar', N'CHJ4f9481', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (521, NULL, N'banagalore', N'CHJ4f9481', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (522, NULL, N'pune', N'CHJ4f9481', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (523, NULL, N'bhubaneswar', N'CHJ99a14a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (524, NULL, N'banagalore', N'CHJ99a14a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (525, NULL, N'pune', N'CHJ99a14a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (526, NULL, N'bhubaneswar', N'CHJe8320c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (527, NULL, N'banagalore', N'CHJe8320c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (528, NULL, N'pune', N'CHJe8320c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (529, NULL, N'bhubaneswar', N'CHJ9f3c46', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (530, NULL, N'banagalore', N'CHJ9f3c46', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (531, NULL, N'pune', N'CHJ9f3c46', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (532, NULL, N'bhubaneswar', N'CHJ1a81f5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (533, NULL, N'banagalore', N'CHJ1a81f5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (534, NULL, N'pune', N'CHJ1a81f5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (535, NULL, N'bhubaneswar', N'CHJ53ab67', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (536, NULL, N'banagalore', N'CHJ53ab67', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (537, NULL, N'pune', N'CHJ53ab67', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (538, NULL, N'bhubaneswar', N'CHJ792906', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (539, NULL, N'banagalore', N'CHJ792906', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (540, NULL, N'pune', N'CHJ792906', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (541, NULL, N'bhubaneswar', N'CHJcf568b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (542, NULL, N'banagalore', N'CHJcf568b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (543, NULL, N'pune', N'CHJcf568b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (544, NULL, N'bhubaneswar', N'CHJ0a675d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (545, NULL, N'banagalore', N'CHJ0a675d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (546, NULL, N'pune', N'CHJ0a675d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (547, NULL, N'bhubaneswar', N'CHJfb3899', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (548, NULL, N'banagalore', N'CHJfb3899', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (549, NULL, N'pune', N'CHJfb3899', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (550, NULL, N'bhubaneswar', N'CHJ101f7f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (551, NULL, N'banagalore', N'CHJ101f7f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (552, NULL, N'pune', N'CHJ101f7f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (553, NULL, N'bhubaneswar', N'CHJ620c5c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (554, NULL, N'banagalore', N'CHJ620c5c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (555, NULL, N'pune', N'CHJ620c5c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (556, NULL, N'bhubaneswar', N'CHJ62e7e9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (557, NULL, N'banagalore', N'CHJ62e7e9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (558, NULL, N'pune', N'CHJ62e7e9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (559, NULL, N'bhubaneswar', N'CHJ67aeb5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (560, NULL, N'banagalore', N'CHJ67aeb5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (561, NULL, N'pune', N'CHJ67aeb5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (562, NULL, N'bhubaneswar', N'CHJd27dc0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (563, NULL, N'banagalore', N'CHJd27dc0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (564, NULL, N'pune', N'CHJd27dc0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (565, NULL, N'bhubaneswar', N'CHJ604039', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (566, NULL, N'banagalore', N'CHJ604039', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (567, NULL, N'pune', N'CHJ604039', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (568, NULL, N'bhubaneswar', N'CHJfba321', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (569, NULL, N'banagalore', N'CHJfba321', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (570, NULL, N'pune', N'CHJfba321', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (571, NULL, N'bhubaneswar', N'CHJ54a9e1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (572, NULL, N'banagalore', N'CHJ54a9e1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (573, NULL, N'pune', N'CHJ54a9e1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (574, NULL, N'bhubaneswar', N'CHJ97a82a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (575, NULL, N'banagalore', N'CHJ97a82a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (576, NULL, N'pune', N'CHJ97a82a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (577, NULL, N'bhubaneswar', N'CHJa919fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (578, NULL, N'banagalore', N'CHJa919fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (579, NULL, N'pune', N'CHJa919fc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (580, NULL, N'bhubaneswar', N'CHJa8c311', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (581, NULL, N'banagalore', N'CHJa8c311', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (582, NULL, N'pune', N'CHJa8c311', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (583, NULL, N'bhubaneswar', N'CHJa8097f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (584, NULL, N'banagalore', N'CHJa8097f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (585, NULL, N'pune', N'CHJa8097f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (586, NULL, N'bhubaneswar', N'CHJb3212d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (587, NULL, N'banagalore', N'CHJb3212d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (588, NULL, N'pune', N'CHJb3212d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (589, NULL, N'bhubaneswar', N'CHJae2c5d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (590, NULL, N'banagalore', N'CHJae2c5d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (591, NULL, N'pune', N'CHJae2c5d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (592, NULL, N'bhubaneswar', N'CHJ8d2f6b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (593, NULL, N'banagalore', N'CHJ8d2f6b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (594, NULL, N'pune', N'CHJ8d2f6b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (595, NULL, N'bhubaneswar', N'CHJ3c8073', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (596, NULL, N'banagalore', N'CHJ3c8073', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (597, NULL, N'pune', N'CHJ3c8073', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (598, NULL, N'bhubaneswar', N'CHJ87d6b9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (599, NULL, N'banagalore', N'CHJ87d6b9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (600, NULL, N'pune', N'CHJ87d6b9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (601, NULL, N'bhubaneswar', N'CHJdf9637', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (602, NULL, N'banagalore', N'CHJdf9637', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (603, NULL, N'pune', N'CHJdf9637', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (604, NULL, N'bhubaneswar', N'CHJ4006a0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (605, NULL, N'banagalore', N'CHJ4006a0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (606, NULL, N'pune', N'CHJ4006a0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (607, NULL, N'bhubaneswar', N'CHJ75a17d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (608, NULL, N'banagalore', N'CHJ75a17d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (609, NULL, N'pune', N'CHJ75a17d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (610, NULL, N'bhubaneswar', N'CHJ56e38b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (611, NULL, N'banagalore', N'CHJ56e38b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (612, NULL, N'pune', N'CHJ56e38b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (613, NULL, N'bhubaneswar', N'CHJb75c46', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (614, NULL, N'banagalore', N'CHJb75c46', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (615, NULL, N'pune', N'CHJb75c46', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (616, NULL, N'bhubaneswar', N'CHJ2f6d79', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (617, NULL, N'banagalore', N'CHJ2f6d79', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (618, NULL, N'pune', N'CHJ2f6d79', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (619, NULL, N'bhubaneswar', N'CHJ7bd4c8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (620, NULL, N'banagalore', N'CHJ7bd4c8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (621, NULL, N'pune', N'CHJ7bd4c8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (622, NULL, N'bhubaneswar', N'CHJa74bcd', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (623, NULL, N'banagalore', N'CHJa74bcd', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (624, NULL, N'pune', N'CHJa74bcd', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (625, NULL, N'bhubaneswar', N'CHJ3d9916', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (626, NULL, N'banagalore', N'CHJ3d9916', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (627, NULL, N'pune', N'CHJ3d9916', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (628, NULL, N'bhubaneswar', N'CHJ7e8688', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (629, NULL, N'banagalore', N'CHJ7e8688', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (630, NULL, N'pune', N'CHJ7e8688', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (631, NULL, N'bhubaneswar', N'CHJ091a03', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (632, NULL, N'banagalore', N'CHJ091a03', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (633, NULL, N'pune', N'CHJ091a03', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (634, NULL, N'bhubaneswar', N'CHJ69e824', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (635, NULL, N'banagalore', N'CHJ69e824', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (636, NULL, N'pune', N'CHJ69e824', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (637, NULL, N'bhubaneswar', N'CHJ913204', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (638, NULL, N'banagalore', N'CHJ913204', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (639, NULL, N'pune', N'CHJ913204', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (640, NULL, N'bhubaneswar', N'CHJb74265', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (641, NULL, N'banagalore', N'CHJb74265', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (642, NULL, N'pune', N'CHJb74265', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (643, NULL, N'bhubaneswar', N'CHJeef28d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (644, NULL, N'banagalore', N'CHJeef28d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (645, NULL, N'pune', N'CHJeef28d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (646, NULL, N'bhubaneswar', N'CHJa17348', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (647, NULL, N'banagalore', N'CHJa17348', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (648, NULL, N'pune', N'CHJa17348', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (649, NULL, N'bhubaneswar', N'CHJb615b5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (650, NULL, N'banagalore', N'CHJb615b5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (651, NULL, N'pune', N'CHJb615b5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (652, NULL, N'bhubaneswar', N'CHJc2f3d8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (653, NULL, N'banagalore', N'CHJc2f3d8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (654, NULL, N'pune', N'CHJc2f3d8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (655, NULL, N'bhubaneswar', N'CHJ6864ba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (656, NULL, N'banagalore', N'CHJ6864ba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (657, NULL, N'pune', N'CHJ6864ba', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (658, NULL, N'bhubaneswar', N'CHJc5c278', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (659, NULL, N'banagalore', N'CHJc5c278', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (660, NULL, N'pune', N'CHJc5c278', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (661, NULL, N'bhubaneswar', N'CHJ34aadb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (662, NULL, N'banagalore', N'CHJ34aadb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (663, NULL, N'pune', N'CHJ34aadb', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (664, NULL, N'bhubaneswar', N'CHJ5f9687', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (665, NULL, N'banagalore', N'CHJ5f9687', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (666, NULL, N'pune', N'CHJ5f9687', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (667, NULL, N'bhubaneswar', N'CHJ3a1964', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (668, NULL, N'banagalore', N'CHJ3a1964', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (669, NULL, N'pune', N'CHJ3a1964', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (670, NULL, N'bhubaneswar', N'CHJe7c303', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (671, NULL, N'banagalore', N'CHJe7c303', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (672, NULL, N'pune', N'CHJe7c303', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (673, NULL, N'bhubaneswar', N'CHJf214a1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (674, NULL, N'banagalore', N'CHJf214a1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (675, NULL, N'pune', N'CHJf214a1', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (676, NULL, N'bhubaneswar', N'CHJ964a5b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (677, NULL, N'banagalore', N'CHJ964a5b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (678, NULL, N'pune', N'CHJ964a5b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (679, NULL, N'bhubaneswar', N'CHJc59b94', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (680, NULL, N'banagalore', N'CHJc59b94', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (681, NULL, N'pune', N'CHJc59b94', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (682, NULL, N'bhubaneswar', N'CHJ4b417f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (683, NULL, N'banagalore', N'CHJ4b417f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (684, NULL, N'pune', N'CHJ4b417f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (685, NULL, N'bhubaneswar', N'CHJ2e4ec0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (686, NULL, N'banagalore', N'CHJ2e4ec0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (687, NULL, N'pune', N'CHJ2e4ec0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (688, NULL, N'bhubaneswar', N'CHJ0b64ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (689, NULL, N'banagalore', N'CHJ0b64ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (690, NULL, N'pune', N'CHJ0b64ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (691, NULL, N'bhubaneswar', N'CHJ87cd6a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (692, NULL, N'banagalore', N'CHJ87cd6a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (693, NULL, N'pune', N'CHJ87cd6a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (694, NULL, N'bhubaneswar', N'CHJ3322a7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (695, NULL, N'banagalore', N'CHJ3322a7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (696, NULL, N'pune', N'CHJ3322a7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (697, NULL, N'bhubaneswar', N'CHJ0dadd9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (698, NULL, N'banagalore', N'CHJ0dadd9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (699, NULL, N'pune', N'CHJ0dadd9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (700, NULL, N'bhubaneswar', N'CHJ4b0b44', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (701, NULL, N'banagalore', N'CHJ4b0b44', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (702, NULL, N'pune', N'CHJ4b0b44', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (703, NULL, N'bhubaneswar', N'CHJdbef55', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (704, NULL, N'banagalore', N'CHJdbef55', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (705, NULL, N'pune', N'CHJdbef55', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (706, NULL, N'bhubaneswar', N'CHJ39680a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (707, NULL, N'banagalore', N'CHJ39680a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (708, NULL, N'pune', N'CHJ39680a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (709, NULL, N'bhubaneswar', N'CHJ6e42af', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (710, NULL, N'banagalore', N'CHJ6e42af', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (711, NULL, N'pune', N'CHJ6e42af', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (712, NULL, N'bhubaneswar', N'CHJe5f9c4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (713, NULL, N'banagalore', N'CHJe5f9c4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (714, NULL, N'pune', N'CHJe5f9c4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (715, NULL, N'bhubaneswar', N'CHJ43fc3a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (716, NULL, N'banagalore', N'CHJ43fc3a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (717, NULL, N'pune', N'CHJ43fc3a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (718, NULL, N'bhubaneswar', N'CHJe3b342', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (719, NULL, N'banagalore', N'CHJe3b342', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (720, NULL, N'pune', N'CHJe3b342', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (721, NULL, N'bhubaneswar', N'CHJ22c0ce', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (722, NULL, N'banagalore', N'CHJ22c0ce', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (723, NULL, N'pune', N'CHJ22c0ce', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (724, NULL, N'bhubaneswar', N'CHJ63ea43', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (725, NULL, N'banagalore', N'CHJ63ea43', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (726, NULL, N'pune', N'CHJ63ea43', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (727, NULL, N'bhubaneswar', N'CHJda7068', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (728, NULL, N'banagalore', N'CHJda7068', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (729, NULL, N'pune', N'CHJda7068', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (730, NULL, N'bhubaneswar', N'CHJa839e8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (731, NULL, N'banagalore', N'CHJa839e8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (732, NULL, N'pune', N'CHJa839e8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (733, NULL, N'bhubaneswar', N'CHJ04bc69', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (734, NULL, N'banagalore', N'CHJ04bc69', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (735, NULL, N'pune', N'CHJ04bc69', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (736, NULL, N'bhubaneswar', N'CHJ7ae73f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (737, NULL, N'banagalore', N'CHJ7ae73f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (738, NULL, N'pune', N'CHJ7ae73f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (739, NULL, N'bhubaneswar', N'CHJc902d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (740, NULL, N'banagalore', N'CHJc902d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (741, NULL, N'pune', N'CHJc902d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (742, NULL, N'bhubaneswar', N'CHJb093c3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (743, NULL, N'banagalore', N'CHJb093c3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (744, NULL, N'pune', N'CHJb093c3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (745, NULL, N'bhubaneswar', N'CHJ75c87c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (746, NULL, N'banagalore', N'CHJ75c87c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (747, NULL, N'pune', N'CHJ75c87c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (748, NULL, N'bhubaneswar', N'CHJfa0689', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (749, NULL, N'banagalore', N'CHJfa0689', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (750, NULL, N'pune', N'CHJfa0689', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (751, NULL, N'bhubaneswar', N'CHJc152ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (752, NULL, N'banagalore', N'CHJc152ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (753, NULL, N'pune', N'CHJc152ab', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (754, NULL, N'bhubaneswar', N'CHJ96fb8b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (755, NULL, N'banagalore', N'CHJ96fb8b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (756, NULL, N'pune', N'CHJ96fb8b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (757, NULL, N'bhubaneswar', N'CHJ4d1b16', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (758, NULL, N'banagalore', N'CHJ4d1b16', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (759, NULL, N'pune', N'CHJ4d1b16', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (760, NULL, N'bhubaneswar', N'CHJa13ea5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (761, NULL, N'banagalore', N'CHJa13ea5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (762, NULL, N'pune', N'CHJa13ea5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (763, NULL, N'bhubaneswar', N'CHJ7728ea', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (764, NULL, N'banagalore', N'CHJ7728ea', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (765, NULL, N'pune', N'CHJ7728ea', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (766, NULL, N'bhubaneswar', N'CHJ0fd23a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (767, NULL, N'banagalore', N'CHJ0fd23a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (768, NULL, N'pune', N'CHJ0fd23a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (769, NULL, N'bhubaneswar', N'CHJ9e3b52', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (770, NULL, N'banagalore', N'CHJ9e3b52', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (771, NULL, N'pune', N'CHJ9e3b52', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (772, NULL, N'bhubaneswar', N'CHJf73f65', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (773, NULL, N'banagalore', N'CHJf73f65', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (774, NULL, N'pune', N'CHJf73f65', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (775, NULL, N'bhubaneswar', N'CHJ270447', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (776, NULL, N'banagalore', N'CHJ270447', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (777, NULL, N'pune', N'CHJ270447', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (778, NULL, N'bhubaneswar', N'CHJ5ffab7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (779, NULL, N'banagalore', N'CHJ5ffab7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (780, NULL, N'pune', N'CHJ5ffab7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (781, NULL, N'bhubaneswar', N'CHJ5367b7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (782, NULL, N'banagalore', N'CHJ5367b7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (783, NULL, N'pune', N'CHJ5367b7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (784, NULL, N'bhubaneswar', N'CHJ944210', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (785, NULL, N'banagalore', N'CHJ944210', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (786, NULL, N'pune', N'CHJ944210', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (787, NULL, N'bhubaneswar', N'CHJ8e8abf', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (788, NULL, N'banagalore', N'CHJ8e8abf', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (789, NULL, N'pune', N'CHJ8e8abf', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (790, NULL, N'bhubaneswar', N'CHJ01e9b8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (791, NULL, N'banagalore', N'CHJ01e9b8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (792, NULL, N'pune', N'CHJ01e9b8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (793, NULL, N'bhubaneswar', N'CHJ6fa2ad', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (794, NULL, N'banagalore', N'CHJ6fa2ad', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (795, NULL, N'pune', N'CHJ6fa2ad', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (796, NULL, N'bhubaneswar', N'CHJ2a21ed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (797, NULL, N'banagalore', N'CHJ2a21ed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (798, NULL, N'pune', N'CHJ2a21ed', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (799, NULL, N'bhubaneswar', N'CHJ973b19', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (800, NULL, N'banagalore', N'CHJ973b19', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (801, NULL, N'pune', N'CHJ973b19', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (802, NULL, N'bhubaneswar', N'CHJ99c719', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (803, NULL, N'banagalore', N'CHJ99c719', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (804, NULL, N'pune', N'CHJ99c719', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (805, NULL, N'bhubaneswar', N'CHJ939b02', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (806, NULL, N'banagalore', N'CHJ939b02', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (807, NULL, N'pune', N'CHJ939b02', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (808, NULL, N'bhubaneswar', N'CHJaff344', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (809, NULL, N'banagalore', N'CHJaff344', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (810, NULL, N'pune', N'CHJaff344', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (811, NULL, N'bhubaneswar', N'CHJ4df043', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (812, NULL, N'banagalore', N'CHJ4df043', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (813, NULL, N'pune', N'CHJ4df043', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (814, NULL, N'bhubaneswar', N'CHJca51ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (815, NULL, N'banagalore', N'CHJca51ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (816, NULL, N'pune', N'CHJca51ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (817, NULL, N'bhubaneswar', N'CHJ170c1c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (818, NULL, N'banagalore', N'CHJ170c1c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (819, NULL, N'pune', N'CHJ170c1c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (820, NULL, N'bhubaneswar', N'CHJ03ddd7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (821, NULL, N'banagalore', N'CHJ03ddd7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (822, NULL, N'pune', N'CHJ03ddd7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (823, NULL, N'bhubaneswar', N'CHJeee5af', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (824, NULL, N'banagalore', N'CHJeee5af', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (825, NULL, N'pune', N'CHJeee5af', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (826, NULL, N'bhubaneswar', N'CHJ9b199b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (827, NULL, N'banagalore', N'CHJ9b199b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (828, NULL, N'pune', N'CHJ9b199b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (829, NULL, N'bhubaneswar', N'CHJbebd03', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (830, NULL, N'banagalore', N'CHJbebd03', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (831, NULL, N'pune', N'CHJbebd03', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (832, NULL, N'bhubaneswar', N'CHJd63a97', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (833, NULL, N'banagalore', N'CHJd63a97', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (834, NULL, N'pune', N'CHJd63a97', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (835, NULL, N'bhubaneswar', N'CHJ0911d2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (836, NULL, N'banagalore', N'CHJ0911d2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (837, NULL, N'pune', N'CHJ0911d2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (838, NULL, N'bhubaneswar', N'CHJd8a89d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (839, NULL, N'banagalore', N'CHJd8a89d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (840, NULL, N'pune', N'CHJd8a89d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (841, NULL, N'bhubaneswar', N'CHJ46354d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (842, NULL, N'banagalore', N'CHJ46354d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (843, NULL, N'pune', N'CHJ46354d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (844, NULL, N'bhubaneswar', N'CHJ70928a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (845, NULL, N'banagalore', N'CHJ70928a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (846, NULL, N'pune', N'CHJ70928a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (847, NULL, N'bhubaneswar', N'CHJ5fe642', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (848, NULL, N'banagalore', N'CHJ5fe642', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (849, NULL, N'pune', N'CHJ5fe642', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (850, NULL, N'bhubaneswar', N'CHJ826d7b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (851, NULL, N'banagalore', N'CHJ826d7b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (852, NULL, N'pune', N'CHJ826d7b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (853, NULL, N'bhubaneswar', N'CHJ58369c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (854, NULL, N'banagalore', N'CHJ58369c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (855, NULL, N'pune', N'CHJ58369c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (856, NULL, N'bhubaneswar', N'CHJ64c1e4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (857, NULL, N'banagalore', N'CHJ64c1e4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (858, NULL, N'pune', N'CHJ64c1e4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (859, NULL, N'bhubaneswar', N'CHJcbc5ff', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (860, NULL, N'banagalore', N'CHJcbc5ff', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (861, NULL, N'pune', N'CHJcbc5ff', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (862, NULL, N'bhubaneswar', N'CHJf69c81', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (863, NULL, N'banagalore', N'CHJf69c81', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (864, NULL, N'pune', N'CHJf69c81', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (865, NULL, N'bhubaneswar', N'CHJ50bb4c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (866, NULL, N'banagalore', N'CHJ50bb4c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (867, NULL, N'pune', N'CHJ50bb4c', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (868, NULL, N'bhubaneswar', N'CHJ1631b2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (869, NULL, N'banagalore', N'CHJ1631b2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (870, NULL, N'pune', N'CHJ1631b2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (871, NULL, N'bhubaneswar', N'CHJ758b26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (872, NULL, N'banagalore', N'CHJ758b26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (873, NULL, N'pune', N'CHJ758b26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (874, NULL, N'bhubaneswar', N'CHJ6221fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (875, NULL, N'banagalore', N'CHJ6221fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (876, NULL, N'pune', N'CHJ6221fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (877, NULL, N'bhubaneswar', N'CHJ7cd283', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (878, NULL, N'banagalore', N'CHJ7cd283', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (879, NULL, N'pune', N'CHJ7cd283', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (880, NULL, N'bhubaneswar', N'CHJ3f9bec', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (881, NULL, N'banagalore', N'CHJ3f9bec', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (882, NULL, N'pune', N'CHJ3f9bec', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (883, NULL, N'bhubaneswar', N'CHJe01c3f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (884, NULL, N'banagalore', N'CHJe01c3f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (885, NULL, N'pune', N'CHJe01c3f', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (886, NULL, N'bhubaneswar', N'CHJ86aed2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (887, NULL, N'banagalore', N'CHJ86aed2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (888, NULL, N'pune', N'CHJ86aed2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (889, NULL, N'bhubaneswar', N'CHJ8673a9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (890, NULL, N'banagalore', N'CHJ8673a9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (891, NULL, N'pune', N'CHJ8673a9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (892, NULL, N'bhubaneswar', N'CHJ726e40', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (893, NULL, N'banagalore', N'CHJ726e40', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (894, NULL, N'pune', N'CHJ726e40', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (895, NULL, N'bhubaneswar', N'CHJeee5d9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (896, NULL, N'banagalore', N'CHJeee5d9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (897, NULL, N'pune', N'CHJeee5d9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (898, NULL, N'bhubaneswar', N'CHJ950868', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (899, NULL, N'banagalore', N'CHJ950868', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (900, NULL, N'pune', N'CHJ950868', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (901, NULL, N'bhubaneswar', N'CHJdff645', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (902, NULL, N'banagalore', N'CHJdff645', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (903, NULL, N'pune', N'CHJdff645', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (904, NULL, N'bhubaneswar', N'CHJ9d588d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (905, NULL, N'banagalore', N'CHJ9d588d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (906, NULL, N'pune', N'CHJ9d588d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (907, NULL, N'bhubaneswar', N'CHJ6c7598', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (908, NULL, N'banagalore', N'CHJ6c7598', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (909, NULL, N'pune', N'CHJ6c7598', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (910, NULL, N'bhubaneswar', N'CHJ6ef3d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (911, NULL, N'banagalore', N'CHJ6ef3d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (912, NULL, N'pune', N'CHJ6ef3d0', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (913, NULL, N'bhubaneswar', N'CHJ6f6db8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (914, NULL, N'banagalore', N'CHJ6f6db8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (915, NULL, N'pune', N'CHJ6f6db8', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (916, NULL, N'bhubaneswar', N'CHJ557a36', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (917, NULL, N'banagalore', N'CHJ557a36', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (918, NULL, N'pune', N'CHJ557a36', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (919, NULL, N'bhubaneswar', N'CHJ2f3f26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (920, NULL, N'banagalore', N'CHJ2f3f26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (921, NULL, N'pune', N'CHJ2f3f26', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (922, NULL, N'bhubaneswar', N'CHJ0d968a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (923, NULL, N'banagalore', N'CHJ0d968a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (924, NULL, N'pune', N'CHJ0d968a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (925, NULL, N'bhubaneswar', N'CHJ997b8d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (926, NULL, N'banagalore', N'CHJ997b8d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (927, NULL, N'pune', N'CHJ997b8d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (928, NULL, N'bhubaneswar', N'CHJ0522ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (929, NULL, N'banagalore', N'CHJ0522ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (930, NULL, N'pune', N'CHJ0522ee', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (931, NULL, N'bhubaneswar', N'CHJ010943', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (932, NULL, N'banagalore', N'CHJ010943', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (933, NULL, N'pune', N'CHJ010943', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (934, NULL, N'bhubaneswar', N'CHJ47650a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (935, NULL, N'banagalore', N'CHJ47650a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (936, NULL, N'pune', N'CHJ47650a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (937, NULL, N'bhubaneswar', N'CHJbe1a8a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (938, NULL, N'banagalore', N'CHJbe1a8a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (939, NULL, N'pune', N'CHJbe1a8a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (940, NULL, N'bhubaneswar', N'CHJ05b442', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (941, NULL, N'banagalore', N'CHJ05b442', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (942, NULL, N'pune', N'CHJ05b442', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (943, NULL, N'bhubaneswar', N'CHJe70107', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (944, NULL, N'banagalore', N'CHJe70107', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (945, NULL, N'pune', N'CHJe70107', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (946, NULL, N'bhubaneswar', N'CHJa37ca5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (947, NULL, N'banagalore', N'CHJa37ca5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (948, NULL, N'pune', N'CHJa37ca5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (949, NULL, N'bhubaneswar', N'CHJ87a1db', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (950, NULL, N'banagalore', N'CHJ87a1db', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (951, NULL, N'pune', N'CHJ87a1db', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (952, NULL, N'bhubaneswar', N'CHJ3f9055', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (953, NULL, N'banagalore', N'CHJ3f9055', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (954, NULL, N'pune', N'CHJ3f9055', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (955, NULL, N'bhubaneswar', N'CHJfbf645', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (956, NULL, N'banagalore', N'CHJfbf645', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (957, NULL, N'pune', N'CHJfbf645', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (958, NULL, N'bhubaneswar', N'CHJ9fe4da', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (959, NULL, N'banagalore', N'CHJ9fe4da', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (960, NULL, N'pune', N'CHJ9fe4da', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (961, NULL, N'bhubaneswar', N'CHJ740c18', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (962, NULL, N'banagalore', N'CHJ740c18', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (963, NULL, N'pune', N'CHJ740c18', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (964, NULL, N'bhubaneswar', N'CHJ26383a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (965, NULL, N'banagalore', N'CHJ26383a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (966, NULL, N'pune', N'CHJ26383a', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (967, NULL, N'bhubaneswar', N'CHJ9cc6e9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (968, NULL, N'banagalore', N'CHJ9cc6e9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (969, NULL, N'pune', N'CHJ9cc6e9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (970, NULL, N'bhubaneswar', N'CHJ00b5d5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (971, NULL, N'banagalore', N'CHJ00b5d5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (972, NULL, N'pune', N'CHJ00b5d5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (973, NULL, N'bhubaneswar', N'CHJ4fc559', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (974, NULL, N'banagalore', N'CHJ4fc559', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (975, NULL, N'pune', N'CHJ4fc559', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (976, NULL, N'bhubaneswar', N'CHJ903c37', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (977, NULL, N'banagalore', N'CHJ903c37', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (978, NULL, N'pune', N'CHJ903c37', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (979, NULL, N'bhubaneswar', N'CHJ25ee9e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (980, NULL, N'banagalore', N'CHJ25ee9e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (981, NULL, N'pune', N'CHJ25ee9e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (982, NULL, N'bhubaneswar', N'CHJ542d5e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (983, NULL, N'banagalore', N'CHJ542d5e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (984, NULL, N'pune', N'CHJ542d5e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (985, NULL, N'bhubaneswar', N'CHJd0707d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (986, NULL, N'banagalore', N'CHJd0707d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (987, NULL, N'pune', N'CHJd0707d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (988, NULL, N'bhubaneswar', N'CHJe91aa9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (989, NULL, N'banagalore', N'CHJe91aa9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (990, NULL, N'pune', N'CHJe91aa9', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (991, NULL, N'bhubaneswar', N'CHJ73a726', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (992, NULL, N'banagalore', N'CHJ73a726', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (993, NULL, N'pune', N'CHJ73a726', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (994, NULL, N'bhubaneswar', N'CHJfb7cd7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (995, NULL, N'banagalore', N'CHJfb7cd7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (996, NULL, N'pune', N'CHJfb7cd7', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (997, NULL, N'bhubaneswar', N'CHJcc30b5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (998, NULL, N'banagalore', N'CHJcc30b5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (999, NULL, N'pune', N'CHJcc30b5', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1000, NULL, N'bhubaneswar', N'CHJ34923b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1001, NULL, N'banagalore', N'CHJ34923b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1002, NULL, N'pune', N'CHJ34923b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1003, NULL, N'bhubaneswar', N'CHJb678a4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1004, NULL, N'banagalore', N'CHJb678a4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1005, NULL, N'pune', N'CHJb678a4', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1006, NULL, N'bhubaneswar', N'CHJ5a48a3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1007, NULL, N'banagalore', N'CHJ5a48a3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1008, NULL, N'pune', N'CHJ5a48a3', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1009, NULL, N'bhubaneswar', N'CHJ6c40f2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1010, NULL, N'banagalore', N'CHJ6c40f2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1011, NULL, N'pune', N'CHJ6c40f2', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1012, NULL, N'bhubaneswar', N'CHJ0687ff', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1013, NULL, N'banagalore', N'CHJ0687ff', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1014, NULL, N'pune', N'CHJ0687ff', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1015, NULL, N'bhubaneswar', N'CHJ758727', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1016, NULL, N'banagalore', N'CHJ758727', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1017, NULL, N'pune', N'CHJ758727', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1018, NULL, N'bhubaneswar', N'CHJ94b019', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1019, NULL, N'banagalore', N'CHJ94b019', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1020, NULL, N'pune', N'CHJ94b019', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1021, NULL, N'bhubaneswar', N'CHJ46a26b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1022, NULL, N'banagalore', N'CHJ46a26b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1023, NULL, N'pune', N'CHJ46a26b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1024, NULL, N'bhubaneswar', N'CHJ843a09', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1025, NULL, N'banagalore', N'CHJ843a09', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1026, NULL, N'pune', N'CHJ843a09', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1027, NULL, N'bhubaneswar', N'CHJa935fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1028, NULL, N'banagalore', N'CHJa935fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1029, NULL, N'pune', N'CHJa935fa', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1030, NULL, N'bhubaneswar', N'CHJd1f869', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1031, NULL, N'banagalore', N'CHJd1f869', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1032, NULL, N'pune', N'CHJd1f869', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1033, NULL, N'bhubaneswar', N'CHJ076954', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1034, NULL, N'banagalore', N'CHJ076954', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1035, NULL, N'pune', N'CHJ076954', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1036, NULL, N'bhubaneswar', N'CHJ274a3d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1037, NULL, N'banagalore', N'CHJ274a3d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1038, NULL, N'pune', N'CHJ274a3d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1039, NULL, N'bhubaneswar', N'CHJ76093d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1040, NULL, N'banagalore', N'CHJ76093d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1041, NULL, N'pune', N'CHJ76093d', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1042, NULL, N'bhubaneswar', N'CHJ859b8e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1043, NULL, N'banagalore', N'CHJ859b8e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1044, NULL, N'pune', N'CHJ859b8e', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1045, NULL, N'bhubaneswar', N'CHJa6a439', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1046, NULL, N'banagalore', N'CHJa6a439', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1047, NULL, N'pune', N'CHJa6a439', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1048, NULL, N'bhubaneswar', N'CHJ327bae', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1049, NULL, N'banagalore', N'CHJ327bae', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1050, NULL, N'pune', N'CHJ327bae', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1051, NULL, N'bhubaneswar', N'CHJ5e754b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1052, NULL, N'banagalore', N'CHJ5e754b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1053, NULL, N'pune', N'CHJ5e754b', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1054, NULL, N'bhubaneswar', N'CHJ0291ca', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1055, NULL, N'banagalore', N'CHJ0291ca', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1056, NULL, N'pune', N'CHJ0291ca', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1057, NULL, N'bhubaneswar', N'CHJ0b7539', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1058, NULL, N'banagalore', N'CHJ0b7539', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1059, NULL, N'pune', N'CHJ0b7539', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1060, NULL, N'bhubaneswar', N'CHJ803798', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1061, NULL, N'banagalore', N'CHJ803798', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1062, NULL, N'pune', N'CHJ803798', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1063, NULL, N'bhubaneswar', N'CHJ456924', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1064, NULL, N'banagalore', N'CHJ456924', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1065, NULL, N'pune', N'CHJ456924', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1066, NULL, N'bhubaneswar', N'CHJ4722cc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1067, NULL, N'banagalore', N'CHJ4722cc', 2, 2, 1, NULL)
GO
INSERT [dbo].[Job_ByCity] ([JCId], [CityId], [City_Name], [ChJobID], [CategoryId], [ExperineceId], [EmploymentId], [Serach_Instance]) VALUES (1068, NULL, N'pune', N'CHJ4722cc', 2, 2, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Job_ByCity] OFF
GO
SET IDENTITY_INSERT [dbo].[Job_Category] ON 
GO
INSERT [dbo].[Job_Category] ([CategoryId], [Category_Name], [Count_Of_Job]) VALUES (1, N'IT', NULL)
GO
INSERT [dbo].[Job_Category] ([CategoryId], [Category_Name], [Count_Of_Job]) VALUES (2, N'Software Engineering', NULL)
GO
SET IDENTITY_INSERT [dbo].[Job_Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Job_EmploymentType] ON 
GO
INSERT [dbo].[Job_EmploymentType] ([EmploymentId], [Employment_Type], [Count_Of_Job]) VALUES (1, N'Remote', NULL)
GO
INSERT [dbo].[Job_EmploymentType] ([EmploymentId], [Employment_Type], [Count_Of_Job]) VALUES (2, N'Contract', NULL)
GO
INSERT [dbo].[Job_EmploymentType] ([EmploymentId], [Employment_Type], [Count_Of_Job]) VALUES (3, N'Full Time', NULL)
GO
INSERT [dbo].[Job_EmploymentType] ([EmploymentId], [Employment_Type], [Count_Of_Job]) VALUES (4, N'Part Time', NULL)
GO
SET IDENTITY_INSERT [dbo].[Job_EmploymentType] OFF
GO
SET IDENTITY_INSERT [dbo].[Job_Expernice] ON 
GO
INSERT [dbo].[Job_Expernice] ([ExperineceId], [Exp_Range], [Count_Of_Job]) VALUES (1, N'0-3yr', NULL)
GO
INSERT [dbo].[Job_Expernice] ([ExperineceId], [Exp_Range], [Count_Of_Job]) VALUES (2, N'4-8yr', NULL)
GO
INSERT [dbo].[Job_Expernice] ([ExperineceId], [Exp_Range], [Count_Of_Job]) VALUES (3, N'8-12yr', NULL)
GO
INSERT [dbo].[Job_Expernice] ([ExperineceId], [Exp_Range], [Count_Of_Job]) VALUES (4, N'12yr or More', NULL)
GO
SET IDENTITY_INSERT [dbo].[Job_Expernice] OFF
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'00b5d538-5db5-48db-8050-90972d7a194e', N'CHJ00b5d5', 2, 1, 2, N'78235', N'{"JobId":"00b5d538-5db5-48db-8050-90972d7a194e","ChJobID":"CHJ00b5d5","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/624438d5-52b4-4c01-a4e0-1e690641aed7.png","filename":"624438d5-52b4-4c01-a4e0-1e690641aed7.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c52ca05f-510b-4008-b61a-6945569cc677.png","filename":"c52ca05f-510b-4008-b61a-6945569cc677.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:06.470' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'010943f1-b37a-4650-93db-c44f08fe5bc2', N'CHJ010943', 2, 1, 2, N'78235', N'{"JobId":"010943f1-b37a-4650-93db-c44f08fe5bc2","ChJobID":"CHJ010943","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1c575573-9ca9-4797-9426-2797b370ec1f.png","filename":"1c575573-9ca9-4797-9426-2797b370ec1f.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c3b5d949-2712-401e-a40d-8654682e11c4.png","filename":"c3b5d949-2712-401e-a40d-8654682e11c4.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:01.177' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'01e9b84f-2b5e-49dd-b704-3e6473525420', N'CHJ01e9b8', 2, 1, 2, N'78235', N'{"JobId":"01e9b84f-2b5e-49dd-b704-3e6473525420","ChJobID":"CHJ01e9b8","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5710e2fe-275b-4408-a0cc-85b7c626a00c.png","filename":"5710e2fe-275b-4408-a0cc-85b7c626a00c.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/4677688e-ab71-46bd-b8d7-1c56c72d3bf7.png","filename":"4677688e-ab71-46bd-b8d7-1c56c72d3bf7.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:40.640' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0291cadb-2c16-4695-8534-1c1fb5ab4f7c', N'CHJ0291ca', 2, 1, 2, N'78235', N'{"JobId":"0291cadb-2c16-4695-8534-1c1fb5ab4f7c","ChJobID":"CHJ0291ca","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c2f38a1d-0508-4be6-b11d-0e2a28c75732.png","filename":"c2f38a1d-0508-4be6-b11d-0e2a28c75732.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f09b972c-fae4-4df6-93c4-f64c69394ab3.png","filename":"f09b972c-fae4-4df6-93c4-f64c69394ab3.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:16.667' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'03ddd7d9-8a14-4353-9bdc-8063515826f3', N'CHJ03ddd7', 2, 1, 2, N'78235', N'{"JobId":"03ddd7d9-8a14-4353-9bdc-8063515826f3","ChJobID":"CHJ03ddd7","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/01489a8f-221d-4d0a-89a8-ed4c364182e0.png","filename":"01489a8f-221d-4d0a-89a8-ed4c364182e0.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7c90cd12-66ca-4e1b-bb59-800fb8754241.png","filename":"7c90cd12-66ca-4e1b-bb59-800fb8754241.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:44.087' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'04bc69fe-9483-45dc-b192-c74cd4499c47', N'CHJ04bc69', 2, 1, 2, N'78235', N'{"JobId":"04bc69fe-9483-45dc-b192-c74cd4499c47","ChJobID":"CHJ04bc69","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cbc8a7c1-3e84-4525-975c-b4149e752948.png","filename":"cbc8a7c1-3e84-4525-975c-b4149e752948.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b5b828f2-920a-42b8-9e62-793dcfead08f.png","filename":"b5b828f2-920a-42b8-9e62-793dcfead08f.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:27.770' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0522ee15-4b8d-48f9-b339-820cabe18cba', N'CHJ0522ee', 2, 1, 2, N'78235', N'{"JobId":"0522ee15-4b8d-48f9-b339-820cabe18cba","ChJobID":"CHJ0522ee","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b4bb4eab-1558-4534-90bb-e95a5fc8a013.png","filename":"b4bb4eab-1558-4534-90bb-e95a5fc8a013.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/14f9a766-a1e6-47a5-a2cd-09e9d0f89670.png","filename":"14f9a766-a1e6-47a5-a2cd-09e9d0f89670.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:00.870' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'05b44260-85a0-4cb6-b026-2ee766dfbbda', N'CHJ05b442', 2, 1, 2, N'78235', N'{"JobId":"05b44260-85a0-4cb6-b026-2ee766dfbbda","ChJobID":"CHJ05b442","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1dd0eeb3-4204-4640-aeae-a19cfd8361bb.png","filename":"1dd0eeb3-4204-4640-aeae-a19cfd8361bb.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6c0a441a-b830-4f16-af4d-f94f77a0befa.png","filename":"6c0a441a-b830-4f16-af4d-f94f77a0befa.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:02.183' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0687ff7a-c90f-470b-b6e6-66cb59f807ae', N'CHJ0687ff', 2, 1, 2, N'78235', N'{"JobId":"0687ff7a-c90f-470b-b6e6-66cb59f807ae","ChJobID":"CHJ0687ff","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ef26a247-6c6a-4f5d-b82c-66d50ca306b7.png","filename":"ef26a247-6c6a-4f5d-b82c-66d50ca306b7.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d0506b0c-eb41-48e1-a0d2-2429ce950a4e.png","filename":"d0506b0c-eb41-48e1-a0d2-2429ce950a4e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:11.170' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'076954d3-7338-4cba-abf6-e70572bfb34d', N'CHJ076954', 2, 1, 2, N'78235', N'{"JobId":"076954d3-7338-4cba-abf6-e70572bfb34d","ChJobID":"CHJ076954","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/37b95c56-705e-4ccd-8e0e-cd18fc8277f8.png","filename":"37b95c56-705e-4ccd-8e0e-cd18fc8277f8.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2177780f-bd23-4258-b2c6-c6ce93e13129.png","filename":"2177780f-bd23-4258-b2c6-c6ce93e13129.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:14.053' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0911d222-0904-4ca2-94b4-48acd2aa0213', N'CHJ0911d2', 2, 1, 2, N'78235', N'{"JobId":"0911d222-0904-4ca2-94b4-48acd2aa0213","ChJobID":"CHJ0911d2","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a395571d-f4cf-4665-b662-70ff733836c3.png","filename":"a395571d-f4cf-4665-b662-70ff733836c3.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7ce29840-f8a7-4290-8618-9601de471445.png","filename":"7ce29840-f8a7-4290-8618-9601de471445.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:46.303' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'091a03ba-df02-4229-a82a-7f234f271c8f', N'CHJ091a03', 2, 1, 2, N'78235', N'{"JobId":"091a03ba-df02-4229-a82a-7f234f271c8f","ChJobID":"CHJ091a03","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/45d3a84a-2688-4fbb-b4e3-b33c0838178e.png","filename":"45d3a84a-2688-4fbb-b4e3-b33c0838178e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/14fadd42-6772-4610-9aad-2e1d8ef20aac.png","filename":"14fadd42-6772-4610-9aad-2e1d8ef20aac.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:13.873' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0b64ab7f-950e-4505-a81b-efda045c8362', N'CHJ0b64ab', 2, 1, 2, N'78235', N'{"JobId":"0b64ab7f-950e-4505-a81b-efda045c8362","ChJobID":"CHJ0b64ab","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/61c42706-1dc8-430f-b6c6-8ce88f6e1d7a.png","filename":"61c42706-1dc8-430f-b6c6-8ce88f6e1d7a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/21848ab4-824b-4ff4-b5e3-c4b2ea701a88.png","filename":"21848ab4-824b-4ff4-b5e3-c4b2ea701a88.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:21.557' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0b753952-9e79-4af5-b9f2-1d377a552f2b', N'CHJ0b7539', 2, 1, 2, N'78235', N'{"JobId":"0b753952-9e79-4af5-b9f2-1d377a552f2b","ChJobID":"CHJ0b7539","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/29531365-7200-45cc-bfdb-b4230fa185f0.png","filename":"29531365-7200-45cc-bfdb-b4230fa185f0.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2e722e2d-a3ae-4064-a881-2fbee586cbba.png","filename":"2e722e2d-a3ae-4064-a881-2fbee586cbba.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:16.920' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0d968abf-963d-4332-9f64-475afa3d166e', N'CHJ0d968a', 2, 1, 2, N'78235', N'{"JobId":"0d968abf-963d-4332-9f64-475afa3d166e","ChJobID":"CHJ0d968a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/908778eb-d532-4c9f-a9cc-c2ed57ed805d.png","filename":"908778eb-d532-4c9f-a9cc-c2ed57ed805d.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7dad2667-c7fc-42c7-81bb-4cbbb110be59.png","filename":"7dad2667-c7fc-42c7-81bb-4cbbb110be59.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:00.230' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0dadd935-bff0-40a7-923e-c998a47d8abd', N'CHJ0dadd9', 2, 1, 2, N'78235', N'{"JobId":"0dadd935-bff0-40a7-923e-c998a47d8abd","ChJobID":"CHJ0dadd9","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e2c424d1-961a-4590-9ac2-a06b0e50d29e.png","filename":"e2c424d1-961a-4590-9ac2-a06b0e50d29e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1fb78600-6b6d-4525-94cb-034701f3e0d0.png","filename":"1fb78600-6b6d-4525-94cb-034701f3e0d0.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:22.843' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'0fd23a02-c338-4d10-897e-391721070f0e', N'CHJ0fd23a', 2, 1, 2, N'78235', N'{"JobId":"0fd23a02-c338-4d10-897e-391721070f0e","ChJobID":"CHJ0fd23a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e982c194-33e0-4923-9e78-a264a447f23a.png","filename":"e982c194-33e0-4923-9e78-a264a447f23a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5760eb49-28e8-4669-8e65-b8744ee3aabe.png","filename":"5760eb49-28e8-4669-8e65-b8744ee3aabe.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:37.140' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'1631b21c-c8a6-47b9-88d4-1624e8f06bd7', N'CHJ1631b2', 2, 1, 2, N'78235', N'{"JobId":"1631b21c-c8a6-47b9-88d4-1624e8f06bd7","ChJobID":"CHJ1631b2","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/8d4f84ac-9905-4900-87dd-0eb6ede73d24.png","filename":"8d4f84ac-9905-4900-87dd-0eb6ede73d24.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1b060b64-b420-408c-a404-3512d7fc2a30.png","filename":"1b060b64-b420-408c-a404-3512d7fc2a30.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:50.313' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'170c1c85-81c3-4dae-aa1b-426764cbcbff', N'CHJ170c1c', 2, 1, 2, N'78235', N'{"JobId":"170c1c85-81c3-4dae-aa1b-426764cbcbff","ChJobID":"CHJ170c1c","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cfd6de8d-4516-48de-8d05-49275fd56e6d.png","filename":"cfd6de8d-4516-48de-8d05-49275fd56e6d.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2f90b0da-bb50-4f49-86fc-05eb605cb3e4.png","filename":"2f90b0da-bb50-4f49-86fc-05eb605cb3e4.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:43.690' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'22c0ce01-b1f2-4a27-8207-fa4c90d7ca39', N'CHJ22c0ce', 2, 1, 2, N'78235', N'{"JobId":"22c0ce01-b1f2-4a27-8207-fa4c90d7ca39","ChJobID":"CHJ22c0ce","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c94c9e2e-5fa7-48d2-8899-a1cc6bef716e.png","filename":"c94c9e2e-5fa7-48d2-8899-a1cc6bef716e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f5fd5aaf-df16-498b-8d19-edf8ebe3fbe8.png","filename":"f5fd5aaf-df16-498b-8d19-edf8ebe3fbe8.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:26.457' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'25ee9e23-65dc-4377-ad90-ecfb870dc97e', N'CHJ25ee9e', 2, 1, 2, N'78235', N'{"JobId":"25ee9e23-65dc-4377-ad90-ecfb870dc97e","ChJobID":"CHJ25ee9e","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6aad24cc-1a69-4440-8857-be6994328440.png","filename":"6aad24cc-1a69-4440-8857-be6994328440.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/104fc302-a01a-46a7-9ec2-a01eece9d05b.png","filename":"104fc302-a01a-46a7-9ec2-a01eece9d05b.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:07.447' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'26383a0c-b5d1-43ad-bf40-fb06d45f07f0', N'CHJ26383a', 2, 1, 2, N'78235', N'{"JobId":"26383a0c-b5d1-43ad-bf40-fb06d45f07f0","ChJobID":"CHJ26383a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/48e7a6cb-c6a1-4b2b-aa75-08f9fbb5340b.png","filename":"48e7a6cb-c6a1-4b2b-aa75-08f9fbb5340b.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b667a610-1cdc-488e-ae02-16b2017dcadd.png","filename":"b667a610-1cdc-488e-ae02-16b2017dcadd.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:05.803' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'270447e2-54b8-49d0-9978-27b35dbec640', N'CHJ270447', 2, 1, 2, N'78235', N'{"JobId":"270447e2-54b8-49d0-9978-27b35dbec640","ChJobID":"CHJ270447","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0e22ce7a-ac5f-409b-83da-ae855dea6dec.png","filename":"0e22ce7a-ac5f-409b-83da-ae855dea6dec.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/df583aa9-d718-4e71-873f-7625b1b0e319.png","filename":"df583aa9-d718-4e71-873f-7625b1b0e319.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:38.740' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'274a3d85-873e-4cab-8ec4-17407ccd9dd9', N'CHJ274a3d', 2, 1, 2, N'78235', N'{"JobId":"274a3d85-873e-4cab-8ec4-17407ccd9dd9","ChJobID":"CHJ274a3d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5f4eb16d-fe43-4c5a-9cec-6e095c1ce091.png","filename":"5f4eb16d-fe43-4c5a-9cec-6e095c1ce091.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b42ad46b-9995-4ee9-b1f3-0bd4049b4101.png","filename":"b42ad46b-9995-4ee9-b1f3-0bd4049b4101.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:14.427' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'2a21edf0-874e-416d-8c7f-5ca09b151c1c', N'CHJ2a21ed', 2, 1, 2, N'78235', N'{"JobId":"2a21edf0-874e-416d-8c7f-5ca09b151c1c","ChJobID":"CHJ2a21ed","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/abd38a5f-2624-4604-ad95-0dab9fdab45f.png","filename":"abd38a5f-2624-4604-ad95-0dab9fdab45f.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c91ed803-561d-4f2a-a5db-60dd05170699.png","filename":"c91ed803-561d-4f2a-a5db-60dd05170699.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:41.363' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'2e4ec0e2-468b-4902-bfc2-037350af638d', N'CHJ2e4ec0', 2, 1, 2, N'78235', N'{"JobId":"2e4ec0e2-468b-4902-bfc2-037350af638d","ChJobID":"CHJ2e4ec0","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0736c64f-0765-45e5-add2-933df59797ca.png","filename":"0736c64f-0765-45e5-add2-933df59797ca.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2561c889-9cbc-4a08-b516-c8e890931375.png","filename":"2561c889-9cbc-4a08-b516-c8e890931375.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:21.183' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'2f3f26a5-4382-40c1-babd-ef130008b645', N'CHJ2f3f26', 2, 1, 2, N'78235', N'{"JobId":"2f3f26a5-4382-40c1-babd-ef130008b645","ChJobID":"CHJ2f3f26","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/891c3c9d-d800-454d-ad95-50c3641643e0.png","filename":"891c3c9d-d800-454d-ad95-50c3641643e0.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/66043182-734d-4c03-8613-e1e002dd0da6.png","filename":"66043182-734d-4c03-8613-e1e002dd0da6.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:59.837' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'2f6d799b-d0b9-400e-a99e-ef1139f30199', N'CHJ2f6d79', 2, 1, 2, N'78235', N'{"JobId":"2f6d799b-d0b9-400e-a99e-ef1139f30199","ChJobID":"CHJ2f6d79","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/149c4ea0-7ac4-4a35-99f6-3a4dd17913bd.png","filename":"149c4ea0-7ac4-4a35-99f6-3a4dd17913bd.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5ac5d273-87de-42fc-9633-92cd014d38be.png","filename":"5ac5d273-87de-42fc-9633-92cd014d38be.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:10.847' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'327baec2-c01c-45e6-98ed-5176468360d3', N'CHJ327bae', 2, 1, 2, N'78235', N'{"JobId":"327baec2-c01c-45e6-98ed-5176468360d3","ChJobID":"CHJ327bae","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b8e15664-2e18-4f8f-a8d7-e76397163d0e.png","filename":"b8e15664-2e18-4f8f-a8d7-e76397163d0e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d947bf24-d4d9-40fb-aeb5-9aaa54a01f43.png","filename":"d947bf24-d4d9-40fb-aeb5-9aaa54a01f43.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:15.840' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'3322a7bd-f444-4eb7-9c4c-55afed575ed4', N'CHJ3322a7', 2, 1, 2, N'78235', N'{"JobId":"3322a7bd-f444-4eb7-9c4c-55afed575ed4","ChJobID":"CHJ3322a7","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6e4492ae-3b14-44dc-9ab1-4a28d9edefc0.png","filename":"6e4492ae-3b14-44dc-9ab1-4a28d9edefc0.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/aedab2f5-4356-49ee-9281-2b1cd2543b76.png","filename":"aedab2f5-4356-49ee-9281-2b1cd2543b76.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:22.243' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'34923bd4-88f7-426d-a7df-8ed699bea53a', N'CHJ34923b', 2, 1, 2, N'78235', N'{"JobId":"34923bd4-88f7-426d-a7df-8ed699bea53a","ChJobID":"CHJ34923b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7cccd156-05db-403b-bd0d-464e2277b9cf.png","filename":"7cccd156-05db-403b-bd0d-464e2277b9cf.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/75d1296d-0a6c-45f2-91d5-c39b14748c8d.png","filename":"75d1296d-0a6c-45f2-91d5-c39b14748c8d.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:09.797' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'34aadb5c-2667-4e9b-bd36-4bede1832e4f', N'CHJ34aadb', 2, 1, 2, N'78235', N'{"JobId":"34aadb5c-2667-4e9b-bd36-4bede1832e4f","ChJobID":"CHJ34aadb","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/47fb8800-aba2-4e12-970a-a5f143f64640.png","filename":"47fb8800-aba2-4e12-970a-a5f143f64640.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9039da66-d1a4-4084-922b-c2225ff9527d.png","filename":"9039da66-d1a4-4084-922b-c2225ff9527d.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:18.173' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'39680a95-e1cb-418c-97e7-5a0bee39a5a3', N'CHJ39680a', 2, 1, 2, N'78235', N'{"JobId":"39680a95-e1cb-418c-97e7-5a0bee39a5a3","ChJobID":"CHJ39680a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2188c3d2-b1bd-4884-be66-7c211bba93f8.png","filename":"2188c3d2-b1bd-4884-be66-7c211bba93f8.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5c129e92-937b-413c-9640-7110085fc6c2.png","filename":"5c129e92-937b-413c-9640-7110085fc6c2.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:24.497' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'3a1964b0-cdce-4d3e-807f-b9a6655d153b', N'CHJ3a1964', 2, 1, 2, N'78235', N'{"JobId":"3a1964b0-cdce-4d3e-807f-b9a6655d153b","ChJobID":"CHJ3a1964","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6b6bc306-5591-44c9-8ff8-b83cf8b01b76.png","filename":"6b6bc306-5591-44c9-8ff8-b83cf8b01b76.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a1b4697c-05b3-458b-a9a5-855eba61e10e.png","filename":"a1b4697c-05b3-458b-a9a5-855eba61e10e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:19.070' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'3c807351-3f21-4259-8b4e-75578f868e81', N'CHJ3c8073', 2, 1, 2, N'78235', N'{"JobId":"3c807351-3f21-4259-8b4e-75578f868e81","ChJobID":"CHJ3c8073","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7ba1e043-8e1f-411f-a04f-6cf99b601981.png","filename":"7ba1e043-8e1f-411f-a04f-6cf99b601981.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/83b72965-88b0-4036-b7cf-45338043aaa0.png","filename":"83b72965-88b0-4036-b7cf-45338043aaa0.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:06.433' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'3d9916d1-1821-4304-8c94-363fd1e90bd8', N'CHJ3d9916', 2, 1, 2, N'78235', N'{"JobId":"3d9916d1-1821-4304-8c94-363fd1e90bd8","ChJobID":"CHJ3d9916","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/843011dd-dd59-4021-98f8-a27e5314ddaa.png","filename":"843011dd-dd59-4021-98f8-a27e5314ddaa.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cf3f5a6b-a95e-44ca-bd4f-ff38078cca46.png","filename":"cf3f5a6b-a95e-44ca-bd4f-ff38078cca46.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:12.000' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'3f9055fb-62dd-4a3a-9d2d-e752ad373252', N'CHJ3f9055', 2, 1, 2, N'78235', N'{"JobId":"3f9055fb-62dd-4a3a-9d2d-e752ad373252","ChJobID":"CHJ3f9055","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ed593bde-723c-4550-a64f-5a7c237b6989.png","filename":"ed593bde-723c-4550-a64f-5a7c237b6989.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6ea59152-71bc-455f-822f-6497d42f92c7.png","filename":"6ea59152-71bc-455f-822f-6497d42f92c7.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:04.160' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'3f9bec70-0f99-4543-a26c-3b947889fcd7', N'CHJ3f9bec', 2, 1, 2, N'78235', N'{"JobId":"3f9bec70-0f99-4543-a26c-3b947889fcd7","ChJobID":"CHJ3f9bec","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/871a418f-1edf-458d-b887-6ac4f92fff13.png","filename":"871a418f-1edf-458d-b887-6ac4f92fff13.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e8c282aa-8d99-461d-8e3e-1fca6f99c74a.png","filename":"e8c282aa-8d99-461d-8e3e-1fca6f99c74a.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:52.290' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'4006a0fa-25da-4d9b-95b9-6430dee3192f', N'CHJ4006a0', 2, 1, 2, N'78235', N'{"JobId":"4006a0fa-25da-4d9b-95b9-6430dee3192f","ChJobID":"CHJ4006a0","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d7a905c0-e3d3-41e1-b9ea-17140076a2a7.png","filename":"d7a905c0-e3d3-41e1-b9ea-17140076a2a7.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d885e86e-907c-4025-9678-75acf92b8f2b.png","filename":"d885e86e-907c-4025-9678-75acf92b8f2b.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:08.827' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'43fc3aa3-1f98-4a27-b741-53b139cf288e', N'CHJ43fc3a', 2, 1, 2, N'78235', N'{"JobId":"43fc3aa3-1f98-4a27-b741-53b139cf288e","ChJobID":"CHJ43fc3a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0b28e7b2-c113-41a0-b159-1d9647cb8b5f.png","filename":"0b28e7b2-c113-41a0-b159-1d9647cb8b5f.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/25c816c1-e13c-4a57-8d38-31b91649af3a.png","filename":"25c816c1-e13c-4a57-8d38-31b91649af3a.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:25.507' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'456924c5-223d-4ff1-9bbc-4ebe626d6835', N'CHJ456924', 2, 1, 2, N'78235', N'{"JobId":"456924c5-223d-4ff1-9bbc-4ebe626d6835","ChJobID":"CHJ456924","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5ddf48f7-5e0a-4c46-8b9d-09173dfa1cb9.png","filename":"5ddf48f7-5e0a-4c46-8b9d-09173dfa1cb9.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/771b66f0-34af-4f12-b4b2-73fe9f4b48f6.png","filename":"771b66f0-34af-4f12-b4b2-73fe9f4b48f6.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:17.900' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'46354df2-7303-4281-b0ec-4a4810b77614', N'CHJ46354d', 2, 1, 2, N'78235', N'{"JobId":"46354df2-7303-4281-b0ec-4a4810b77614","ChJobID":"CHJ46354d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/73ff634e-ebe7-4b46-99fe-02de8ced5ab4.png","filename":"73ff634e-ebe7-4b46-99fe-02de8ced5ab4.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/33680673-6887-4327-a0bd-e955dc7974ef.png","filename":"33680673-6887-4327-a0bd-e955dc7974ef.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:47.020' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'46a26bd5-eeba-47ad-8a34-c864f1817840', N'CHJ46a26b', 2, 1, 2, N'78235', N'{"JobId":"46a26bd5-eeba-47ad-8a34-c864f1817840","ChJobID":"CHJ46a26b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a5850d41-2419-4df5-b0ae-0701a45cc404.png","filename":"a5850d41-2419-4df5-b0ae-0701a45cc404.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/422f452f-c8d8-4804-98bf-d448b39b36f4.png","filename":"422f452f-c8d8-4804-98bf-d448b39b36f4.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:12.187' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'4722cca5-9e68-42d0-be0d-ac981a562b57', N'CHJ4722cc', 2, 1, 2, N'78235', N'{"JobId":"4722cca5-9e68-42d0-be0d-ac981a562b57","ChJobID":"CHJ4722cc","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2effa584-5da2-451d-b880-f0af937fea6f.png","filename":"2effa584-5da2-451d-b880-f0af937fea6f.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0e8a07bf-314b-40c8-b8b9-599b4b484ff1.png","filename":"0e8a07bf-314b-40c8-b8b9-599b4b484ff1.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:18.320' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'47650acc-53ed-4470-aa45-8bc116bd145a', N'CHJ47650a', 2, 1, 2, N'78235', N'{"JobId":"47650acc-53ed-4470-aa45-8bc116bd145a","ChJobID":"CHJ47650a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0c66d66f-d282-4c50-bfad-dd9e251449c3.png","filename":"0c66d66f-d282-4c50-bfad-dd9e251449c3.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d0ca65dc-f179-4f31-b2cb-83b3100c46a6.png","filename":"d0ca65dc-f179-4f31-b2cb-83b3100c46a6.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:01.530' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'4b0b44d5-8beb-495d-a5fb-b7d66d7e83aa', N'CHJ4b0b44', 2, 1, 2, N'78235', N'{"JobId":"4b0b44d5-8beb-495d-a5fb-b7d66d7e83aa","ChJobID":"CHJ4b0b44","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6ad48e6d-0877-48bc-b807-44bda15b0b34.png","filename":"6ad48e6d-0877-48bc-b807-44bda15b0b34.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1ed225c5-0760-4167-a7a6-558bfff0c93c.png","filename":"1ed225c5-0760-4167-a7a6-558bfff0c93c.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:23.777' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'4b417f6e-0169-4321-9ad4-c6b59263e351', N'CHJ4b417f', 2, 1, 2, N'78235', N'{"JobId":"4b417f6e-0169-4321-9ad4-c6b59263e351","ChJobID":"CHJ4b417f","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2d341729-7ee4-47aa-90f4-56335116cd6f.png","filename":"2d341729-7ee4-47aa-90f4-56335116cd6f.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3ec99d83-89dd-4891-9f41-600ba1964497.png","filename":"3ec99d83-89dd-4891-9f41-600ba1964497.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:20.813' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'4d1b163e-be5c-4a2d-a6d5-1bde7758e080', N'CHJ4d1b16', 2, 1, 2, N'78235', N'{"JobId":"4d1b163e-be5c-4a2d-a6d5-1bde7758e080","ChJobID":"CHJ4d1b16","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1e366638-ff19-4d98-b291-4222da1de875.png","filename":"1e366638-ff19-4d98-b291-4222da1de875.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/77d94599-c69a-4148-af15-1b2d1671a0e6.png","filename":"77d94599-c69a-4148-af15-1b2d1671a0e6.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:33.293' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'4df04378-2088-4ac2-8fad-400ab12133f0', N'CHJ4df043', 2, 1, 2, N'78235', N'{"JobId":"4df04378-2088-4ac2-8fad-400ab12133f0","ChJobID":"CHJ4df043","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3a6351f1-f75b-403e-bbd2-be92135a1f89.png","filename":"3a6351f1-f75b-403e-bbd2-be92135a1f89.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a09dd9fc-ee24-4567-abf0-76f3c7d2c0f1.png","filename":"a09dd9fc-ee24-4567-abf0-76f3c7d2c0f1.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:43.063' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'4fc559a8-969a-4105-80b5-ad56010a49a8', N'CHJ4fc559', 2, 1, 2, N'78235', N'{"JobId":"4fc559a8-969a-4105-80b5-ad56010a49a8","ChJobID":"CHJ4fc559","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3235060c-4a40-4add-99f6-50257cfdfcee.png","filename":"3235060c-4a40-4add-99f6-50257cfdfcee.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b605b20b-450e-4607-b73c-9ea675b7c37d.png","filename":"b605b20b-450e-4607-b73c-9ea675b7c37d.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:06.827' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'50bb4cc1-44f6-4e32-aded-6cdc218d9c5a', N'CHJ50bb4c', 2, 1, 2, N'78235', N'{"JobId":"50bb4cc1-44f6-4e32-aded-6cdc218d9c5a","ChJobID":"CHJ50bb4c","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1f8df4f5-bb72-4a5b-bb44-e6ca60703d7e.png","filename":"1f8df4f5-bb72-4a5b-bb44-e6ca60703d7e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9b396470-7c44-48d2-b916-5e587e1b5957.png","filename":"9b396470-7c44-48d2-b916-5e587e1b5957.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:49.970' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'5367b709-6ed0-4b14-9114-8f6e668ef059', N'CHJ5367b7', 2, 1, 2, N'78235', N'{"JobId":"5367b709-6ed0-4b14-9114-8f6e668ef059","ChJobID":"CHJ5367b7","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d5284ca0-5689-40dd-86e7-59a2214a7497.png","filename":"d5284ca0-5689-40dd-86e7-59a2214a7497.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a2b82ed2-6363-41a1-b67e-950991a18962.png","filename":"a2b82ed2-6363-41a1-b67e-950991a18962.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:39.577' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'542d5e53-a877-4c8b-9428-493c44652efb', N'CHJ542d5e', 2, 1, 2, N'78235', N'{"JobId":"542d5e53-a877-4c8b-9428-493c44652efb","ChJobID":"CHJ542d5e","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/8b68532e-55a7-45f4-95e5-1c677d5fd819.png","filename":"8b68532e-55a7-45f4-95e5-1c677d5fd819.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/509da8b1-f6a0-430f-87c6-9fe97c50123e.png","filename":"509da8b1-f6a0-430f-87c6-9fe97c50123e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:07.827' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'54a9e17c-85f5-4374-80a2-7a1a3c90c5b5', N'CHJ54a9e1', 2, 1, 2, N'78235', N'{"JobId":"54a9e17c-85f5-4374-80a2-7a1a3c90c5b5","ChJobID":"CHJ54a9e1","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/42968ac4-fdef-4cd7-93ac-a081d4ccb75e.png","filename":"42968ac4-fdef-4cd7-93ac-a081d4ccb75e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/17022cf9-7248-41f0-b574-7af76b381921.png","filename":"17022cf9-7248-41f0-b574-7af76b381921.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:02.933' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'557a36c8-dabc-4618-9a87-cd5e28948209', N'CHJ557a36', 2, 1, 2, N'78235', N'{"JobId":"557a36c8-dabc-4618-9a87-cd5e28948209","ChJobID":"CHJ557a36","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e09b10dd-b139-41e0-8290-55c922a5cd0a.png","filename":"e09b10dd-b139-41e0-8290-55c922a5cd0a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/27cd1f19-3ab0-4d77-87b7-c6d3794d10aa.png","filename":"27cd1f19-3ab0-4d77-87b7-c6d3794d10aa.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:59.230' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'56e38b49-f370-4ecd-9d79-12e960d70554', N'CHJ56e38b', 2, 1, 2, N'78235', N'{"JobId":"56e38b49-f370-4ecd-9d79-12e960d70554","ChJobID":"CHJ56e38b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/dfc82ceb-caaf-477c-88de-851b138a2d83.png","filename":"dfc82ceb-caaf-477c-88de-851b138a2d83.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/8490aec1-6242-47d1-bbc9-591c0d6fe81e.png","filename":"8490aec1-6242-47d1-bbc9-591c0d6fe81e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:09.900' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'58369c0a-a8a1-4800-b21b-62cab23bbe89', N'CHJ58369c', 2, 1, 2, N'78235', N'{"JobId":"58369c0a-a8a1-4800-b21b-62cab23bbe89","ChJobID":"CHJ58369c","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0f3dfcbf-478e-42f6-b060-e65ce6494822.png","filename":"0f3dfcbf-478e-42f6-b060-e65ce6494822.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/60348c22-dee9-49cb-be1d-971c9ba5e146.png","filename":"60348c22-dee9-49cb-be1d-971c9ba5e146.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:48.723' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'5a48a306-c726-484e-8aa7-11f795522630', N'CHJ5a48a3', 2, 1, 2, N'78235', N'{"JobId":"5a48a306-c726-484e-8aa7-11f795522630","ChJobID":"CHJ5a48a3","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/345bc412-8723-4025-aa76-eb226f78cfd5.png","filename":"345bc412-8723-4025-aa76-eb226f78cfd5.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/328b9ba9-0ad9-47d9-b64c-ea50e32de6ae.png","filename":"328b9ba9-0ad9-47d9-b64c-ea50e32de6ae.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:10.490' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'5e754b04-35cc-4641-b8c9-ad5756392dd3', N'CHJ5e754b', 2, 1, 2, N'78235', N'{"JobId":"5e754b04-35cc-4641-b8c9-ad5756392dd3","ChJobID":"CHJ5e754b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/bd864cf5-3c05-4201-af29-910656a6d54d.png","filename":"bd864cf5-3c05-4201-af29-910656a6d54d.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d0ad24e7-eaa6-4eb9-9ca3-2ef72b1595aa.png","filename":"d0ad24e7-eaa6-4eb9-9ca3-2ef72b1595aa.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:16.187' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'5f968723-8726-45c7-838e-d190f59ef340', N'CHJ5f9687', 2, 1, 2, N'78235', N'{"JobId":"5f968723-8726-45c7-838e-d190f59ef340","ChJobID":"CHJ5f9687","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5dcb70d4-5438-4bde-b2b5-13359791bffd.png","filename":"5dcb70d4-5438-4bde-b2b5-13359791bffd.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/fb2852cc-bfb7-4d6c-89a9-fbe263dee1c7.png","filename":"fb2852cc-bfb7-4d6c-89a9-fbe263dee1c7.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:18.623' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'5fe64263-4064-4192-90cf-7ae5d4cf0e2d', N'CHJ5fe642', 2, 1, 2, N'78235', N'{"JobId":"5fe64263-4064-4192-90cf-7ae5d4cf0e2d","ChJobID":"CHJ5fe642","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/42384350-92fd-4e07-99a2-65fffbc67d91.png","filename":"42384350-92fd-4e07-99a2-65fffbc67d91.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9d1817a6-378b-476b-a878-f7b68ca54fe5.png","filename":"9d1817a6-378b-476b-a878-f7b68ca54fe5.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:48.120' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'5ffab701-c40a-4b1f-bbc2-bf93498d671b', N'CHJ5ffab7', 2, 1, 2, N'78235', N'{"JobId":"5ffab701-c40a-4b1f-bbc2-bf93498d671b","ChJobID":"CHJ5ffab7","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6d9f2bba-44a8-4164-8bcf-87b178f5de58.png","filename":"6d9f2bba-44a8-4164-8bcf-87b178f5de58.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/70af5a9c-2e3c-4e57-ab03-f0d84ec52c0a.png","filename":"70af5a9c-2e3c-4e57-ab03-f0d84ec52c0a.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:39.163' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'604039f3-83aa-4834-abd7-95c5e56d983b', N'CHJ604039', 2, 1, 2, N'78235', N'{"JobId":"604039f3-83aa-4834-abd7-95c5e56d983b","ChJobID":"CHJ604039","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ede50159-0136-472b-a3a9-0c4fad014076.png","filename":"ede50159-0136-472b-a3a9-0c4fad014076.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f9daa085-cbe8-4e75-a618-b2c44817c3a3.png","filename":"f9daa085-cbe8-4e75-a618-b2c44817c3a3.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:34:06.000' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6221fab9-0a6a-49b0-9d12-36a55463e77c', N'CHJ6221fa', 2, 1, 2, N'78235', N'{"JobId":"6221fab9-0a6a-49b0-9d12-36a55463e77c","ChJobID":"CHJ6221fa","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/16ade04d-d8d1-4ff2-ad48-9417292f8835.png","filename":"16ade04d-d8d1-4ff2-ad48-9417292f8835.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/32dd862f-524e-4eb9-8ab7-af8423436942.png","filename":"32dd862f-524e-4eb9-8ab7-af8423436942.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:51.577' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'63ea4341-0a62-4b80-8edf-62da899a06ba', N'CHJ63ea43', 2, 1, 2, N'78235', N'{"JobId":"63ea4341-0a62-4b80-8edf-62da899a06ba","ChJobID":"CHJ63ea43","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2d6bde34-7f5e-470c-88dd-f29c28a78567.png","filename":"2d6bde34-7f5e-470c-88dd-f29c28a78567.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d41e86e2-3006-44be-acb2-27823deb2351.png","filename":"d41e86e2-3006-44be-acb2-27823deb2351.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:26.753' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'64c1e4a0-c5b8-4546-bcd9-e83f3e522932', N'CHJ64c1e4', 2, 1, 2, N'78235', N'{"JobId":"64c1e4a0-c5b8-4546-bcd9-e83f3e522932","ChJobID":"CHJ64c1e4","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5b50b6d4-04f5-462e-b007-86c791f8ce5e.png","filename":"5b50b6d4-04f5-462e-b007-86c791f8ce5e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/eed21653-f334-4d90-abc9-a5c30a636390.png","filename":"eed21653-f334-4d90-abc9-a5c30a636390.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:49.037' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6864ba2d-1184-44a2-aa63-f09b4038f845', N'CHJ6864ba', 2, 1, 2, N'78235', N'{"JobId":"6864ba2d-1184-44a2-aa63-f09b4038f845","ChJobID":"CHJ6864ba","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/66435c1d-8761-489e-abd5-e001dbd386fb.png","filename":"66435c1d-8761-489e-abd5-e001dbd386fb.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/47823818-a90e-4b45-8d26-8b54dae40638.png","filename":"47823818-a90e-4b45-8d26-8b54dae40638.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:17.493' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'69e82426-dd8e-447c-a0c8-f58fca20aa48', N'CHJ69e824', 2, 1, 2, N'78235', N'{"JobId":"69e82426-dd8e-447c-a0c8-f58fca20aa48","ChJobID":"CHJ69e824","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1ae1941d-b92c-41e9-b9ab-13ed63185ca7.png","filename":"1ae1941d-b92c-41e9-b9ab-13ed63185ca7.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/39077ac9-41af-4bb0-bb74-359ab566479b.png","filename":"39077ac9-41af-4bb0-bb74-359ab566479b.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:14.393' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6c40f22b-d574-4e68-ba93-364107601df4', N'CHJ6c40f2', 2, 1, 2, N'78235', N'{"JobId":"6c40f22b-d574-4e68-ba93-364107601df4","ChJobID":"CHJ6c40f2","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ef1a402d-ec80-42ab-85ce-0e4f085f6b21.png","filename":"ef1a402d-ec80-42ab-85ce-0e4f085f6b21.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d9c68124-6386-477b-bd0a-6e31157e528a.png","filename":"d9c68124-6386-477b-bd0a-6e31157e528a.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:10.843' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6c75986a-b0e3-49ca-9429-20b7b3eaf8b8', N'CHJ6c7598', 2, 1, 2, N'78235', N'{"JobId":"6c75986a-b0e3-49ca-9429-20b7b3eaf8b8","ChJobID":"CHJ6c7598","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/66ab905b-61d1-4fb2-af90-e1229617d627.png","filename":"66ab905b-61d1-4fb2-af90-e1229617d627.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1afddde4-3377-4054-b7f9-cf0e3e9f0dce.png","filename":"1afddde4-3377-4054-b7f9-cf0e3e9f0dce.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:58.217' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6e42af53-3380-48a1-a16d-26c9114f6ceb', N'CHJ6e42af', 2, 1, 2, N'78235', N'{"JobId":"6e42af53-3380-48a1-a16d-26c9114f6ceb","ChJobID":"CHJ6e42af","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2d756d7b-2ab0-45f7-ba4c-d8ccc02230c8.png","filename":"2d756d7b-2ab0-45f7-ba4c-d8ccc02230c8.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f671e24a-d61e-4bc7-bf98-7b0c1251538e.png","filename":"f671e24a-d61e-4bc7-bf98-7b0c1251538e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:24.820' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6ef3d0b6-4131-49b3-8c9c-d3edbaf63a5d', N'CHJ6ef3d0', 2, 1, 2, N'78235', N'{"JobId":"6ef3d0b6-4131-49b3-8c9c-d3edbaf63a5d","ChJobID":"CHJ6ef3d0","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/57b50f40-1843-46ff-a9de-92629503af73.png","filename":"57b50f40-1843-46ff-a9de-92629503af73.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/bda4ae8c-79f0-441b-aeed-8c57ff400112.png","filename":"bda4ae8c-79f0-441b-aeed-8c57ff400112.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:58.563' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6f6db821-56ba-4513-b288-304cacd09bee', N'CHJ6f6db8', 2, 1, 2, N'78235', N'{"JobId":"6f6db821-56ba-4513-b288-304cacd09bee","ChJobID":"CHJ6f6db8","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/69a310aa-62ea-4b18-823c-a8a833b44a99.png","filename":"69a310aa-62ea-4b18-823c-a8a833b44a99.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/813bb436-8cb6-4300-978a-d41aa91522b6.png","filename":"813bb436-8cb6-4300-978a-d41aa91522b6.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:58.883' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'6fa2adf3-71b0-4250-9be6-6c60afa7b12c', N'CHJ6fa2ad', 2, 1, 2, N'78235', N'{"JobId":"6fa2adf3-71b0-4250-9be6-6c60afa7b12c","ChJobID":"CHJ6fa2ad","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/18447643-9223-44a8-8325-68f08de44bac.png","filename":"18447643-9223-44a8-8325-68f08de44bac.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/df138922-b541-4c8d-b7eb-0c30d6f08a75.png","filename":"df138922-b541-4c8d-b7eb-0c30d6f08a75.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:41.000' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'70928a8a-c1e4-4702-be88-0938a9803ba9', N'CHJ70928a', 2, 1, 2, N'78235', N'{"JobId":"70928a8a-c1e4-4702-be88-0938a9803ba9","ChJobID":"CHJ70928a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/fd378681-892c-415d-80d6-fb36d001d07b.png","filename":"fd378681-892c-415d-80d6-fb36d001d07b.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/df429512-8444-4b7a-bd40-f3964c3a17eb.png","filename":"df429512-8444-4b7a-bd40-f3964c3a17eb.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:47.630' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'726e4091-3c17-4f9e-8065-09ae1b62f9b1', N'CHJ726e40', 2, 1, 2, N'78235', N'{"JobId":"726e4091-3c17-4f9e-8065-09ae1b62f9b1","ChJobID":"CHJ726e40","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/658959a1-5ed2-437b-827d-67e9af5feafe.png","filename":"658959a1-5ed2-437b-827d-67e9af5feafe.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e93356b8-5955-4c99-93f9-5e0f0375c77e.png","filename":"e93356b8-5955-4c99-93f9-5e0f0375c77e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:56.287' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'73a72675-3cc0-4285-b485-244009bae4d8', N'CHJ73a726', 2, 1, 2, N'78235', N'{"JobId":"73a72675-3cc0-4285-b485-244009bae4d8","ChJobID":"CHJ73a726","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1797ca8d-5e2c-44bb-9e30-4675ce327f1b.png","filename":"1797ca8d-5e2c-44bb-9e30-4675ce327f1b.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c900757c-dc58-44f3-b98e-04bf382ad1ec.png","filename":"c900757c-dc58-44f3-b98e-04bf382ad1ec.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:08.787' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'740c183d-0aca-43e7-b50c-377ad69f69c3', N'CHJ740c18', 2, 1, 2, N'78235', N'{"JobId":"740c183d-0aca-43e7-b50c-377ad69f69c3","ChJobID":"CHJ740c18","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d2f2399f-d16e-4a93-ab6f-5876531cbdc6.png","filename":"d2f2399f-d16e-4a93-ab6f-5876531cbdc6.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e6fbfe24-3afa-43f4-88bf-ba6cb416475a.png","filename":"e6fbfe24-3afa-43f4-88bf-ba6cb416475a.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:05.510' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'75872786-9eb6-42cf-8183-6907a9a8c957', N'CHJ758727', 2, 1, 2, N'78235', N'{"JobId":"75872786-9eb6-42cf-8183-6907a9a8c957","ChJobID":"CHJ758727","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e1270c81-034a-4eb2-9864-c6627426ef87.png","filename":"e1270c81-034a-4eb2-9864-c6627426ef87.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/74a3eaf3-79a6-4c54-ae85-e81518418031.png","filename":"74a3eaf3-79a6-4c54-ae85-e81518418031.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:11.513' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'758b26a9-45a7-4382-b374-1c3535ab9e0e', N'CHJ758b26', 2, 1, 2, N'78235', N'{"JobId":"758b26a9-45a7-4382-b374-1c3535ab9e0e","ChJobID":"CHJ758b26","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0a2e98ac-bfed-4780-8740-490c35bfdc50.png","filename":"0a2e98ac-bfed-4780-8740-490c35bfdc50.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0271917c-6f82-4f69-9981-7bd52d8c7258.png","filename":"0271917c-6f82-4f69-9981-7bd52d8c7258.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:50.670' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'75a17dd0-01ec-4676-8f63-da8b8f779c49', N'CHJ75a17d', 2, 1, 2, N'78235', N'{"JobId":"75a17dd0-01ec-4676-8f63-da8b8f779c49","ChJobID":"CHJ75a17d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cc51b376-1368-4e01-8c7d-779de44dff6c.png","filename":"cc51b376-1368-4e01-8c7d-779de44dff6c.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9992686f-436b-4132-b986-3493b13419be.png","filename":"9992686f-436b-4132-b986-3493b13419be.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:09.420' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'75c87cce-cc2d-4f37-9e7e-a302dd0e3677', N'CHJ75c87c', 2, 1, 2, N'78235', N'{"JobId":"75c87cce-cc2d-4f37-9e7e-a302dd0e3677","ChJobID":"CHJ75c87c","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a2cf5241-8c56-42c1-8ede-0fc923645bd8.png","filename":"a2cf5241-8c56-42c1-8ede-0fc923645bd8.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2c68b099-bce6-4aa3-aeeb-281fcf604f44.png","filename":"2c68b099-bce6-4aa3-aeeb-281fcf604f44.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:30.437' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'76093d40-2361-4cca-8270-2fa8204580b7', N'CHJ76093d', 2, 1, 2, N'78235', N'{"JobId":"76093d40-2361-4cca-8270-2fa8204580b7","ChJobID":"CHJ76093d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/30eeb16d-618c-4b8a-863e-661c9b051287.png","filename":"30eeb16d-618c-4b8a-863e-661c9b051287.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/954d1d2f-1b3a-41c3-8637-5c253b021954.png","filename":"954d1d2f-1b3a-41c3-8637-5c253b021954.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:14.843' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'7728ea90-d10a-4b08-8cb6-bb31be677b30', N'CHJ7728ea', 2, 1, 2, N'78235', N'{"JobId":"7728ea90-d10a-4b08-8cb6-bb31be677b30","ChJobID":"CHJ7728ea","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/336c1af0-dedc-44cc-9445-ee56d9c9f09e.png","filename":"336c1af0-dedc-44cc-9445-ee56d9c9f09e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/26441dc8-5408-4a03-84db-3f86a19feb59.png","filename":"26441dc8-5408-4a03-84db-3f86a19feb59.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:36.467' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'7ae73f11-ef4b-4a7a-928e-6cc2ef3d0c7f', N'CHJ7ae73f', 2, 1, 2, N'78235', N'{"JobId":"7ae73f11-ef4b-4a7a-928e-6cc2ef3d0c7f","ChJobID":"CHJ7ae73f","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5e5f15df-4ff8-462e-a472-d8712c86c3d8.png","filename":"5e5f15df-4ff8-462e-a472-d8712c86c3d8.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c5939a50-cb85-429e-8229-4c883278c760.png","filename":"c5939a50-cb85-429e-8229-4c883278c760.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:28.697' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'7bd4c8b2-b3b8-4d96-85ac-007501410001', N'CHJ7bd4c8', 2, 1, 2, N'78235', N'{"JobId":"7bd4c8b2-b3b8-4d96-85ac-007501410001","ChJobID":"CHJ7bd4c8","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/64f39f90-04ae-491c-9d7d-70aedd142e2a.png","filename":"64f39f90-04ae-491c-9d7d-70aedd142e2a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/8053e86f-3af1-498e-8293-fdb242f17de1.png","filename":"8053e86f-3af1-498e-8293-fdb242f17de1.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:11.260' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'7cd28336-0156-4891-8be0-8067587b00fc', N'CHJ7cd283', 2, 1, 2, N'78235', N'{"JobId":"7cd28336-0156-4891-8be0-8067587b00fc","ChJobID":"CHJ7cd283","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/8ab7babd-1874-4236-9577-b8c62c587150.png","filename":"8ab7babd-1874-4236-9577-b8c62c587150.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0403c45c-4f62-4591-b6fb-d1e9909303dc.png","filename":"0403c45c-4f62-4591-b6fb-d1e9909303dc.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:51.927' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'7e86882c-7812-4f79-ae1c-6133fb0ae17a', N'CHJ7e8688', 2, 1, 2, N'78235', N'{"JobId":"7e86882c-7812-4f79-ae1c-6133fb0ae17a","ChJobID":"CHJ7e8688","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/dc7959a7-3669-4e28-b11d-f18104950d10.png","filename":"dc7959a7-3669-4e28-b11d-f18104950d10.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c22f8136-e03b-4f9c-b0fa-d3d5c275fe3f.png","filename":"c22f8136-e03b-4f9c-b0fa-d3d5c275fe3f.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:13.337' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'8037986e-7424-41a8-bfa4-c6d25c79afc0', N'CHJ803798', 2, 1, 2, N'78235', N'{"JobId":"8037986e-7424-41a8-bfa4-c6d25c79afc0","ChJobID":"CHJ803798","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e4d8c69e-13cd-4519-ad51-15ebc8d8bc07.png","filename":"e4d8c69e-13cd-4519-ad51-15ebc8d8bc07.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5e3d4891-a483-4199-a352-eb4bfd01599a.png","filename":"5e3d4891-a483-4199-a352-eb4bfd01599a.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:17.310' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'826d7bd5-135e-421f-915c-52841e2a5147', N'CHJ826d7b', 2, 1, 2, N'78235', N'{"JobId":"826d7bd5-135e-421f-915c-52841e2a5147","ChJobID":"CHJ826d7b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/74a376cf-5c52-4514-8234-5eb086ef80e0.png","filename":"74a376cf-5c52-4514-8234-5eb086ef80e0.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/4e990ff1-041c-4e03-a267-70f6aee51054.png","filename":"4e990ff1-041c-4e03-a267-70f6aee51054.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:48.413' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'843a0929-f3de-4040-96ca-32944af3bc84', N'CHJ843a09', 2, 1, 2, N'78235', N'{"JobId":"843a0929-f3de-4040-96ca-32944af3bc84","ChJobID":"CHJ843a09","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f005c4ca-894a-4a5a-9298-6a51a8365080.png","filename":"f005c4ca-894a-4a5a-9298-6a51a8365080.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f7f0492e-7e85-48a8-9721-ab83d606cd66.png","filename":"f7f0492e-7e85-48a8-9721-ab83d606cd66.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:12.480' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'859b8ec6-be9e-4dec-b26a-c3d02f1d78fa', N'CHJ859b8e', 2, 1, 2, N'78235', N'{"JobId":"859b8ec6-be9e-4dec-b26a-c3d02f1d78fa","ChJobID":"CHJ859b8e","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b91b85a8-0e2b-4f96-b0eb-9822b302b0e0.png","filename":"b91b85a8-0e2b-4f96-b0eb-9822b302b0e0.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7aad47b5-7584-4cad-a420-fe0b723050ef.png","filename":"7aad47b5-7584-4cad-a420-fe0b723050ef.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:15.153' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'8673a9fc-2d8f-4aab-9b8d-4a5e256941c6', N'CHJ8673a9', 2, 1, 2, N'78235', N'{"JobId":"8673a9fc-2d8f-4aab-9b8d-4a5e256941c6","ChJobID":"CHJ8673a9","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b5f1fbdc-bd91-47ab-9b3f-b76033db0ec4.png","filename":"b5f1fbdc-bd91-47ab-9b3f-b76033db0ec4.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f9b5fcb8-7f6c-4195-a19a-d84cf7d864a9.png","filename":"f9b5fcb8-7f6c-4195-a19a-d84cf7d864a9.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:55.770' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'86aed2e3-eaaf-4d42-a7d8-902eea53ff24', N'CHJ86aed2', 2, 1, 2, N'78235', N'{"JobId":"86aed2e3-eaaf-4d42-a7d8-902eea53ff24","ChJobID":"CHJ86aed2","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3a09cecd-6a81-4ca3-a51a-7a34e4075913.png","filename":"3a09cecd-6a81-4ca3-a51a-7a34e4075913.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/572aa01c-380e-4ae6-a910-53f646c1cd99.png","filename":"572aa01c-380e-4ae6-a910-53f646c1cd99.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:55.227' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'87a1db2d-667e-4608-adf8-da37e99e1c93', N'CHJ87a1db', 2, 1, 2, N'78235', N'{"JobId":"87a1db2d-667e-4608-adf8-da37e99e1c93","ChJobID":"CHJ87a1db","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c1370cbf-106b-47a8-85ac-4966d3d20e5b.png","filename":"c1370cbf-106b-47a8-85ac-4966d3d20e5b.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9c373f39-3d76-4b9a-abea-b6614b8de03b.png","filename":"9c373f39-3d76-4b9a-abea-b6614b8de03b.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:03.773' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'87cd6a17-6500-464b-b5aa-599f52d178c0', N'CHJ87cd6a', 2, 1, 2, N'78235', N'{"JobId":"87cd6a17-6500-464b-b5aa-599f52d178c0","ChJobID":"CHJ87cd6a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/fb0b9795-691b-4df7-92cb-97db80952014.png","filename":"fb0b9795-691b-4df7-92cb-97db80952014.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ce16c664-ad7f-452e-8906-5776ddde22ea.png","filename":"ce16c664-ad7f-452e-8906-5776ddde22ea.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:21.867' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'87d6b986-7922-4698-941b-abed0d9346e8', N'CHJ87d6b9', 2, 1, 2, N'78235', N'{"JobId":"87d6b986-7922-4698-941b-abed0d9346e8","ChJobID":"CHJ87d6b9","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f2ee97b8-7e95-45db-8d17-677d7b980cef.png","filename":"f2ee97b8-7e95-45db-8d17-677d7b980cef.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b4406589-5a61-4c58-b94e-740b2366fa2c.png","filename":"b4406589-5a61-4c58-b94e-740b2366fa2c.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:06.707' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'8d2f6b9b-8571-4e0c-8024-fb2b7cdcdaa7', N'CHJ8d2f6b', 2, 1, 2, N'78235', N'{"JobId":"8d2f6b9b-8571-4e0c-8024-fb2b7cdcdaa7","ChJobID":"CHJ8d2f6b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6154335c-b102-4303-86fe-8214007845e3.png","filename":"6154335c-b102-4303-86fe-8214007845e3.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c3f6bde0-b5ca-4eea-a49a-8aafb768ff7f.png","filename":"c3f6bde0-b5ca-4eea-a49a-8aafb768ff7f.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:06.043' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'8e8abf63-4845-43a0-94a6-0d2bd3ea9fff', N'CHJ8e8abf', 2, 1, 2, N'78235', N'{"JobId":"8e8abf63-4845-43a0-94a6-0d2bd3ea9fff","ChJobID":"CHJ8e8abf","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/df2a764e-3eb8-43b4-bd30-77aa4f83fed2.png","filename":"df2a764e-3eb8-43b4-bd30-77aa4f83fed2.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b6bff222-6483-4c15-a60f-f03cbc4b5be8.png","filename":"b6bff222-6483-4c15-a60f-f03cbc4b5be8.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:40.257' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'903c37bd-164f-4090-a375-5ec93680ed8b', N'CHJ903c37', 2, 1, 2, N'78235', N'{"JobId":"903c37bd-164f-4090-a375-5ec93680ed8b","ChJobID":"CHJ903c37","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/db794ad8-7775-46c6-9a35-e4653efff6fa.png","filename":"db794ad8-7775-46c6-9a35-e4653efff6fa.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/05066056-06b9-409c-ada7-72d59d8b277b.png","filename":"05066056-06b9-409c-ada7-72d59d8b277b.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:07.123' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'91320466-1628-4a32-ba1c-fd5ddc7930c8', N'CHJ913204', 2, 1, 2, N'78235', N'{"JobId":"91320466-1628-4a32-ba1c-fd5ddc7930c8","ChJobID":"CHJ913204","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/bcdbdd66-8eee-42b1-9f63-ba383ad24ddc.png","filename":"bcdbdd66-8eee-42b1-9f63-ba383ad24ddc.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c5d68856-4e67-433c-b4a2-338f59e15abd.png","filename":"c5d68856-4e67-433c-b4a2-338f59e15abd.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:14.873' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'939b02bc-8ed0-4f82-8f60-d42af3aeb0db', N'CHJ939b02', 2, 1, 2, N'78235', N'{"JobId":"939b02bc-8ed0-4f82-8f60-d42af3aeb0db","ChJobID":"CHJ939b02","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/77d1e68f-a91f-4aea-8a42-880c206be8cb.png","filename":"77d1e68f-a91f-4aea-8a42-880c206be8cb.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/59c4217e-4631-45c3-afc6-cae8f1232384.png","filename":"59c4217e-4631-45c3-afc6-cae8f1232384.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:42.377' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'94421075-4be2-4c78-8699-5f7e689189cf', N'CHJ944210', 2, 1, 2, N'78235', N'{"JobId":"94421075-4be2-4c78-8699-5f7e689189cf","ChJobID":"CHJ944210","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f6260089-0ca5-473b-947c-3f197b7a7bf6.png","filename":"f6260089-0ca5-473b-947c-3f197b7a7bf6.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/18c8f731-78ef-4f57-a2b2-f61d78b31bae.png","filename":"18c8f731-78ef-4f57-a2b2-f61d78b31bae.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:39.977' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'94b0193c-f801-4dda-b28e-871dc12dc757', N'CHJ94b019', 2, 1, 2, N'78235', N'{"JobId":"94b0193c-f801-4dda-b28e-871dc12dc757","ChJobID":"CHJ94b019","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f143128a-b72d-42a3-b67c-f485dbc21e8a.png","filename":"f143128a-b72d-42a3-b67c-f485dbc21e8a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0d7d64fb-579d-467a-be70-0a2d3e4bf528.png","filename":"0d7d64fb-579d-467a-be70-0a2d3e4bf528.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:11.787' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'95086809-39ba-43e1-a3c3-a1350ed52448', N'CHJ950868', 2, 1, 2, N'78235', N'{"JobId":"95086809-39ba-43e1-a3c3-a1350ed52448","ChJobID":"CHJ950868","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/77f27418-a51a-4eb5-9ac3-6e2a04535a0d.png","filename":"77f27418-a51a-4eb5-9ac3-6e2a04535a0d.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/dc4cb8f2-7abf-4a74-bb0c-fdd73c282e48.png","filename":"dc4cb8f2-7abf-4a74-bb0c-fdd73c282e48.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:57.137' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'964a5b76-67c0-4bce-96fb-0cb8f5d3dc64', N'CHJ964a5b', 2, 1, 2, N'78235', N'{"JobId":"964a5b76-67c0-4bce-96fb-0cb8f5d3dc64","ChJobID":"CHJ964a5b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3e1b7a2e-a9ed-485c-9149-f2762ebe033d.png","filename":"3e1b7a2e-a9ed-485c-9149-f2762ebe033d.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d0d8eecf-a0ae-4778-8b77-8c5de1f793fa.png","filename":"d0d8eecf-a0ae-4778-8b77-8c5de1f793fa.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:20.007' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'96fb8b9a-ebaa-4da1-a86b-09d95f6c6375', N'CHJ96fb8b', 2, 1, 2, N'78235', N'{"JobId":"96fb8b9a-ebaa-4da1-a86b-09d95f6c6375","ChJobID":"CHJ96fb8b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6d564943-f88f-4dbb-9889-3df84b6a82bf.png","filename":"6d564943-f88f-4dbb-9889-3df84b6a82bf.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/62cf9464-48e8-4d81-88ad-ed969f1d502c.png","filename":"62cf9464-48e8-4d81-88ad-ed969f1d502c.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:32.910' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'973b195c-edc8-4642-a18d-50123d63b7e0', N'CHJ973b19', 2, 1, 2, N'78235', N'{"JobId":"973b195c-edc8-4642-a18d-50123d63b7e0","ChJobID":"CHJ973b19","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/116c8e4f-ddcd-486a-9061-38362a459723.png","filename":"116c8e4f-ddcd-486a-9061-38362a459723.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f8b9c7cb-8aea-406a-bca9-5706bc05a1b2.png","filename":"f8b9c7cb-8aea-406a-bca9-5706bc05a1b2.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:41.713' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'97a82a5b-ec7a-44b2-96be-37ba499206f1', N'CHJ97a82a', 2, 1, 2, N'78235', N'{"JobId":"97a82a5b-ec7a-44b2-96be-37ba499206f1","ChJobID":"CHJ97a82a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3f1fafa0-6284-4339-8868-4756dd1bfce1.png","filename":"3f1fafa0-6284-4339-8868-4756dd1bfce1.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9de1900d-37b6-4de5-9c78-48c438a7eafc.png","filename":"9de1900d-37b6-4de5-9c78-48c438a7eafc.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:03.573' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'997b8dfe-1041-4314-b5f8-b1992f3ac74a', N'CHJ997b8d', 2, 1, 2, N'78235', N'{"JobId":"997b8dfe-1041-4314-b5f8-b1992f3ac74a","ChJobID":"CHJ997b8d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/bd75fd83-7612-4b8b-af2e-31cfb71c0ca1.png","filename":"bd75fd83-7612-4b8b-af2e-31cfb71c0ca1.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/72d08d00-d2a7-4b16-be80-a9d7f1f4f81c.png","filename":"72d08d00-d2a7-4b16-be80-a9d7f1f4f81c.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:00.570' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'99c719eb-7de4-4df0-877d-2c18c953c175', N'CHJ99c719', 2, 1, 2, N'78235', N'{"JobId":"99c719eb-7de4-4df0-877d-2c18c953c175","ChJobID":"CHJ99c719","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9830fd64-46c6-434c-b73c-410c6e7042bd.png","filename":"9830fd64-46c6-434c-b73c-410c6e7042bd.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c155927a-e619-4e86-8d4d-b3972ee4280c.png","filename":"c155927a-e619-4e86-8d4d-b3972ee4280c.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:42.047' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'9b199b88-ea53-47eb-8476-f7630e71dc14', N'CHJ9b199b', 2, 1, 2, N'78235', N'{"JobId":"9b199b88-ea53-47eb-8476-f7630e71dc14","ChJobID":"CHJ9b199b","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/27f31899-6825-48a8-b104-2bf6286c1442.png","filename":"27f31899-6825-48a8-b104-2bf6286c1442.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/da63346b-f381-4803-a5f6-922a27c07890.png","filename":"da63346b-f381-4803-a5f6-922a27c07890.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:45.050' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'9cc6e931-3f87-464d-8abc-ffd7b7216b0f', N'CHJ9cc6e9', 2, 1, 2, N'78235', N'{"JobId":"9cc6e931-3f87-464d-8abc-ffd7b7216b0f","ChJobID":"CHJ9cc6e9","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9d376ff4-6a53-4277-9243-089e08b9f303.png","filename":"9d376ff4-6a53-4277-9243-089e08b9f303.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5d8dc025-893f-4d3f-a0bf-15901c7b9f51.png","filename":"5d8dc025-893f-4d3f-a0bf-15901c7b9f51.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:06.163' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'9d588dac-9bb6-4772-87b2-69a8d8b39a90', N'CHJ9d588d', 2, 1, 2, N'78235', N'{"JobId":"9d588dac-9bb6-4772-87b2-69a8d8b39a90","ChJobID":"CHJ9d588d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f698a69d-ed11-44e0-ad32-e69ff0ade9b4.png","filename":"f698a69d-ed11-44e0-ad32-e69ff0ade9b4.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/fcb224e1-9162-4d5e-8b91-12eae7b7a647.png","filename":"fcb224e1-9162-4d5e-8b91-12eae7b7a647.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:57.897' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'9e3b52ee-0098-42c0-9d54-ef51b8e1e19c', N'CHJ9e3b52', 2, 1, 2, N'78235', N'{"JobId":"9e3b52ee-0098-42c0-9d54-ef51b8e1e19c","ChJobID":"CHJ9e3b52","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a8dc0fa3-1986-4064-a478-f8abf31fef66.png","filename":"a8dc0fa3-1986-4064-a478-f8abf31fef66.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/fa9d70b7-b853-4540-9387-6561c0bd4d68.png","filename":"fa9d70b7-b853-4540-9387-6561c0bd4d68.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:37.750' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'9fe4da40-5afa-48fd-b3e7-68641ca4cffa', N'CHJ9fe4da', 2, 1, 2, N'78235', N'{"JobId":"9fe4da40-5afa-48fd-b3e7-68641ca4cffa","ChJobID":"CHJ9fe4da","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/959e49e5-8f8c-4712-b593-6fbe2fad5de9.png","filename":"959e49e5-8f8c-4712-b593-6fbe2fad5de9.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7bbdd5f8-6a0d-441d-a267-55c18c8e9a6c.png","filename":"7bbdd5f8-6a0d-441d-a267-55c18c8e9a6c.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:05.110' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a13ea546-038e-4ced-9ab0-de1a3a5f96e8', N'CHJa13ea5', 2, 1, 2, N'78235', N'{"JobId":"a13ea546-038e-4ced-9ab0-de1a3a5f96e8","ChJobID":"CHJa13ea5","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2c78ff0c-d7de-435c-ae56-8a12e8076793.png","filename":"2c78ff0c-d7de-435c-ae56-8a12e8076793.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c4353a53-5e92-484c-97fc-a6ebf824555e.png","filename":"c4353a53-5e92-484c-97fc-a6ebf824555e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:33.777' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a173486c-2e45-4e65-b247-cbee3f0afbe5', N'CHJa17348', 2, 1, 2, N'78235', N'{"JobId":"a173486c-2e45-4e65-b247-cbee3f0afbe5","ChJobID":"CHJa17348","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9270ae13-b14d-4bf8-b7f8-b562062a7933.png","filename":"9270ae13-b14d-4bf8-b7f8-b562062a7933.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/52acd7c1-09dd-4a08-98ce-dc9389ac66d4.png","filename":"52acd7c1-09dd-4a08-98ce-dc9389ac66d4.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:16.190' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a37ca5f6-fcbd-439f-8ac3-e5962dedbe73', N'CHJa37ca5', 2, 1, 2, N'78235', N'{"JobId":"a37ca5f6-fcbd-439f-8ac3-e5962dedbe73","ChJobID":"CHJa37ca5","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5625c787-e304-43b1-900e-ef4be550e840.png","filename":"5625c787-e304-43b1-900e-ef4be550e840.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b521de49-6969-4937-8483-fbf27d21e193.png","filename":"b521de49-6969-4937-8483-fbf27d21e193.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:03.123' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a6a43900-831b-448d-a3ec-316349ffd327', N'CHJa6a439', 2, 1, 2, N'78235', N'{"JobId":"a6a43900-831b-448d-a3ec-316349ffd327","ChJobID":"CHJa6a439","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/40d39b86-64d0-4a2a-ba8f-32757510d9f5.png","filename":"40d39b86-64d0-4a2a-ba8f-32757510d9f5.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/bd92b518-2f62-4ad6-b856-a96e363ae1df.png","filename":"bd92b518-2f62-4ad6-b856-a96e363ae1df.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:15.487' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a74bcdc1-6694-428e-88a0-23b8eb87f07c', N'CHJa74bcd', 2, 1, 2, N'78235', N'{"JobId":"a74bcdc1-6694-428e-88a0-23b8eb87f07c","ChJobID":"CHJa74bcd","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/72641592-3b01-48d9-be01-07846fd39983.png","filename":"72641592-3b01-48d9-be01-07846fd39983.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9e1cd26e-6a46-4782-be9a-7862125ec4c6.png","filename":"9e1cd26e-6a46-4782-be9a-7862125ec4c6.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:11.630' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a8097f38-9293-40e6-9fb7-516b2ba569be', N'CHJa8097f', 2, 1, 2, N'78235', N'{"JobId":"a8097f38-9293-40e6-9fb7-516b2ba569be","ChJobID":"CHJa8097f","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b33488c5-89af-431d-bf4b-b3a92dbb09d3.png","filename":"b33488c5-89af-431d-bf4b-b3a92dbb09d3.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d671fae8-1888-45d7-a6bb-84433adef709.png","filename":"d671fae8-1888-45d7-a6bb-84433adef709.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:04.950' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a839e855-1b0d-4956-82c9-9efb13c082d8', N'CHJa839e8', 2, 1, 2, N'78235', N'{"JobId":"a839e855-1b0d-4956-82c9-9efb13c082d8","ChJobID":"CHJa839e8","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1b908a9c-0da5-460e-937a-99164d93f5a7.png","filename":"1b908a9c-0da5-460e-937a-99164d93f5a7.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7a52122a-748b-47b9-95d9-b045ebb5360d.png","filename":"7a52122a-748b-47b9-95d9-b045ebb5360d.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:27.493' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a8c3116c-ad62-4abd-945c-4428d2e386c9', N'CHJa8c311', 2, 1, 2, N'78235', N'{"JobId":"a8c3116c-ad62-4abd-945c-4428d2e386c9","ChJobID":"CHJa8c311","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a28bc93c-8b82-469d-98ea-62d5a4bba3aa.png","filename":"a28bc93c-8b82-469d-98ea-62d5a4bba3aa.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/66ac0533-85a8-4c67-9aa8-a5f76d020eac.png","filename":"66ac0533-85a8-4c67-9aa8-a5f76d020eac.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:04.640' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a919fc91-85a2-473d-956a-7d7ca59ec6b3', N'CHJa919fc', 2, 1, 2, N'78235', N'{"JobId":"a919fc91-85a2-473d-956a-7d7ca59ec6b3","ChJobID":"CHJa919fc","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/fb356869-ac32-494a-85cb-297e7f684cfe.png","filename":"fb356869-ac32-494a-85cb-297e7f684cfe.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/828403ef-c18e-4df4-93a0-b253819c4e54.png","filename":"828403ef-c18e-4df4-93a0-b253819c4e54.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:04.180' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'a935faea-d2bd-4cd8-949d-d6dfdf0ce38a', N'CHJa935fa', 2, 1, 2, N'78235', N'{"JobId":"a935faea-d2bd-4cd8-949d-d6dfdf0ce38a","ChJobID":"CHJa935fa","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/80bf8e90-4dd7-4c49-95f2-924223c5b1c3.png","filename":"80bf8e90-4dd7-4c49-95f2-924223c5b1c3.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7c69a8ee-586f-4c28-9f34-765b6c148c03.png","filename":"7c69a8ee-586f-4c28-9f34-765b6c148c03.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:12.837' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'ae2c5d68-2272-4cbc-8579-03624b345b0f', N'CHJae2c5d', 2, 1, 2, N'78235', N'{"JobId":"ae2c5d68-2272-4cbc-8579-03624b345b0f","ChJobID":"CHJae2c5d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/44f8ff42-761b-48ac-9436-10e339aeed35.png","filename":"44f8ff42-761b-48ac-9436-10e339aeed35.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d4f9c851-8c8b-4fd4-b22f-56192cd708e4.png","filename":"d4f9c851-8c8b-4fd4-b22f-56192cd708e4.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:05.707' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'aff34405-d6c3-44d3-8391-c29032446522', N'CHJaff344', 2, 1, 2, N'78235', N'{"JobId":"aff34405-d6c3-44d3-8391-c29032446522","ChJobID":"CHJaff344","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/02dc4629-5b6d-4c07-842b-93c23bbcd4f2.png","filename":"02dc4629-5b6d-4c07-842b-93c23bbcd4f2.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/60e74bba-eb8f-4122-925c-5cfe87dede77.png","filename":"60e74bba-eb8f-4122-925c-5cfe87dede77.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:42.680' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'b093c3c1-f6ca-4c73-9119-19f0d301aa78', N'CHJb093c3', 2, 1, 2, N'78235', N'{"JobId":"b093c3c1-f6ca-4c73-9119-19f0d301aa78","ChJobID":"CHJb093c3","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cf9a67b0-ada7-4c89-9b92-1c0a5ca00558.png","filename":"cf9a67b0-ada7-4c89-9b92-1c0a5ca00558.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/223a854f-7e61-44d8-8185-568c42d74dd8.png","filename":"223a854f-7e61-44d8-8185-568c42d74dd8.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:30.057' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'b3212d89-ded1-4ecb-adf6-2656fa2c2627', N'CHJb3212d', 2, 1, 2, N'78235', N'{"JobId":"b3212d89-ded1-4ecb-adf6-2656fa2c2627","ChJobID":"CHJb3212d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/238666ce-91a1-4f86-b728-bb519c6be142.png","filename":"238666ce-91a1-4f86-b728-bb519c6be142.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6a382057-8153-40bb-bf14-746bf4de9a11.png","filename":"6a382057-8153-40bb-bf14-746bf4de9a11.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:05.340' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'b615b540-ee49-4c8b-8c68-bd2d9c063def', N'CHJb615b5', 2, 1, 2, N'78235', N'{"JobId":"b615b540-ee49-4c8b-8c68-bd2d9c063def","ChJobID":"CHJb615b5","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/db56d6d3-2e4a-4e3e-8312-fee9a7d162a9.png","filename":"db56d6d3-2e4a-4e3e-8312-fee9a7d162a9.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c90b3e63-1410-4652-8cb3-90107361fec4.png","filename":"c90b3e63-1410-4652-8cb3-90107361fec4.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:16.680' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'b678a47b-d170-4e2c-8282-9c3c4a752fc1', N'CHJb678a4', 2, 1, 2, N'78235', N'{"JobId":"b678a47b-d170-4e2c-8282-9c3c4a752fc1","ChJobID":"CHJb678a4","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0391bd3a-1032-4a74-bc73-10d454cd5067.png","filename":"0391bd3a-1032-4a74-bc73-10d454cd5067.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/eec1c738-d084-4b35-843a-0dd7e0ca7229.png","filename":"eec1c738-d084-4b35-843a-0dd7e0ca7229.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:10.203' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'b74265af-e763-4884-920a-7ae9f096821b', N'CHJb74265', 2, 1, 2, N'78235', N'{"JobId":"b74265af-e763-4884-920a-7ae9f096821b","ChJobID":"CHJb74265","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/608595df-cd9c-4a34-9062-cd2672cc5a5e.png","filename":"608595df-cd9c-4a34-9062-cd2672cc5a5e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5a614ad3-073d-4509-8de3-cff5878096d2.png","filename":"5a614ad3-073d-4509-8de3-cff5878096d2.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:15.320' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'b75c4612-6d5e-44c6-8a2b-14e0d19dad16', N'CHJb75c46', 2, 1, 2, N'78235', N'{"JobId":"b75c4612-6d5e-44c6-8a2b-14e0d19dad16","ChJobID":"CHJb75c46","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0794e4a6-4e35-433c-ade9-baec32fb860a.png","filename":"0794e4a6-4e35-433c-ade9-baec32fb860a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a31f5ca7-2be3-4649-8cb0-fe03a038106e.png","filename":"a31f5ca7-2be3-4649-8cb0-fe03a038106e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:10.347' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'be1a8ac3-1a0a-442b-9a95-ca226b02b1bd', N'CHJbe1a8a', 2, 1, 2, N'78235', N'{"JobId":"be1a8ac3-1a0a-442b-9a95-ca226b02b1bd","ChJobID":"CHJbe1a8a","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e487c5fb-7c01-4c7b-b660-c8cb6b317701.png","filename":"e487c5fb-7c01-4c7b-b660-c8cb6b317701.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/9a5a6f29-4f83-45c0-b649-b29630c7f3f7.png","filename":"9a5a6f29-4f83-45c0-b649-b29630c7f3f7.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:01.830' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'bebd0304-402e-40ec-83ba-5515570798a7', N'CHJbebd03', 2, 1, 2, N'78235', N'{"JobId":"bebd0304-402e-40ec-83ba-5515570798a7","ChJobID":"CHJbebd03","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5bed9817-be7c-424f-aec4-376b79f3b927.png","filename":"5bed9817-be7c-424f-aec4-376b79f3b927.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/58c61182-5cf7-46c8-ad48-f79bf7757386.png","filename":"58c61182-5cf7-46c8-ad48-f79bf7757386.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:45.377' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'c152ab66-f316-4500-8e6e-a7684cbf6915', N'CHJc152ab', 2, 1, 2, N'78235', N'{"JobId":"c152ab66-f316-4500-8e6e-a7684cbf6915","ChJobID":"CHJc152ab","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/04f8660b-dec1-4641-8a5e-fbd176a3804a.png","filename":"04f8660b-dec1-4641-8a5e-fbd176a3804a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/4c7d3351-c88b-4d7c-b880-e3cf50f71e90.png","filename":"4c7d3351-c88b-4d7c-b880-e3cf50f71e90.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:32.307' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'c2f3d86c-8431-46da-a8cb-c23e01d9c4b9', N'CHJc2f3d8', 2, 1, 2, N'78235', N'{"JobId":"c2f3d86c-8431-46da-a8cb-c23e01d9c4b9","ChJobID":"CHJc2f3d8","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/5a4195a1-b978-4376-b100-b0dd098a7e0c.png","filename":"5a4195a1-b978-4376-b100-b0dd098a7e0c.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6ffe789f-b817-40fb-8df6-581653fa0a0b.png","filename":"6ffe789f-b817-40fb-8df6-581653fa0a0b.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:17.100' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'c59b9487-41e5-4e5e-9d4b-87b2015637e1', N'CHJc59b94', 2, 1, 2, N'78235', N'{"JobId":"c59b9487-41e5-4e5e-9d4b-87b2015637e1","ChJobID":"CHJc59b94","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/4778c1e3-546c-484c-bc06-e3758a01ed1b.png","filename":"4778c1e3-546c-484c-bc06-e3758a01ed1b.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/4ba54731-481b-454b-a3a4-2ec8040a77b0.png","filename":"4ba54731-481b-454b-a3a4-2ec8040a77b0.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:20.390' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'c5c278e2-52a1-48a2-a210-ba893b0125cf', N'CHJc5c278', 2, 1, 2, N'78235', N'{"JobId":"c5c278e2-52a1-48a2-a210-ba893b0125cf","ChJobID":"CHJc5c278","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/12e5c371-1821-4b6d-a482-30bceeac5b33.png","filename":"12e5c371-1821-4b6d-a482-30bceeac5b33.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/f0b0f40d-fb5c-436a-90a7-a4f5023378aa.png","filename":"f0b0f40d-fb5c-436a-90a7-a4f5023378aa.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:17.827' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'c902d031-55f1-4cd3-ab64-3da9f18f7244', N'CHJc902d0', 2, 1, 2, N'78235', N'{"JobId":"c902d031-55f1-4cd3-ab64-3da9f18f7244","ChJobID":"CHJc902d0","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cd7dbb93-b1c0-4cf0-a457-8830598f3850.png","filename":"cd7dbb93-b1c0-4cf0-a457-8830598f3850.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0aafd277-20ae-457c-b1db-80fe5e888532.png","filename":"0aafd277-20ae-457c-b1db-80fe5e888532.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:29.103' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'ca51ee8e-c7fa-4879-81b6-622170fd3357', N'CHJca51ee', 2, 1, 2, N'78235', N'{"JobId":"ca51ee8e-c7fa-4879-81b6-622170fd3357","ChJobID":"CHJca51ee","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/84837d57-5f71-4686-bb96-d0f068273b11.png","filename":"84837d57-5f71-4686-bb96-d0f068273b11.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3be3cbe2-cf00-4920-b162-929f3715591d.png","filename":"3be3cbe2-cf00-4920-b162-929f3715591d.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:43.377' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'cbc5fff8-7260-4743-8957-d9f2853ebf9a', N'CHJcbc5ff', 2, 1, 2, N'78235', N'{"JobId":"cbc5fff8-7260-4743-8957-d9f2853ebf9a","ChJobID":"CHJcbc5ff","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/d918ad46-0024-4b2b-9ba4-cb38f432d8a2.png","filename":"d918ad46-0024-4b2b-9ba4-cb38f432d8a2.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c325e13e-dec8-4628-a82d-165b06593458.png","filename":"c325e13e-dec8-4628-a82d-165b06593458.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:49.353' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'cc30b526-26dd-4cfe-971e-619783df89cf', N'CHJcc30b5', 2, 1, 2, N'78235', N'{"JobId":"cc30b526-26dd-4cfe-971e-619783df89cf","ChJobID":"CHJcc30b5","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c8d5ee4e-5a8f-40a9-aa9a-bf4a4ae59c28.png","filename":"c8d5ee4e-5a8f-40a9-aa9a-bf4a4ae59c28.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/91c3bc47-c2a1-43fc-b6e9-5b53a074c551.png","filename":"91c3bc47-c2a1-43fc-b6e9-5b53a074c551.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:09.480' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'd0707d66-8a5f-46a6-baf1-4d24fffcdd32', N'CHJd0707d', 2, 1, 2, N'78235', N'{"JobId":"d0707d66-8a5f-46a6-baf1-4d24fffcdd32","ChJobID":"CHJd0707d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ba4f328c-cafc-45d0-adaa-bbd39503281a.png","filename":"ba4f328c-cafc-45d0-adaa-bbd39503281a.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/48965b9f-8d6b-4bdf-b44b-99c535165ea3.png","filename":"48965b9f-8d6b-4bdf-b44b-99c535165ea3.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:08.200' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'd1f869d9-02ce-4cfa-b531-0a44c6baf41f', N'CHJd1f869', 2, 1, 2, N'78235', N'{"JobId":"d1f869d9-02ce-4cfa-b531-0a44c6baf41f","ChJobID":"CHJd1f869","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3b172788-9305-4783-92b0-9644102b3a0f.png","filename":"3b172788-9305-4783-92b0-9644102b3a0f.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b112c419-e576-4bb3-8f19-dbd04d56c3b4.png","filename":"b112c419-e576-4bb3-8f19-dbd04d56c3b4.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:13.147' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'd27dc025-663c-4093-a371-8feea07a65f4', N'CHJd27dc0', 2, 1, 2, N'78235', N'{"JobId":"d27dc025-663c-4093-a371-8feea07a65f4","ChJobID":"CHJd27dc0","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e63e1bd1-36d3-4924-bb20-f9060ef30d11.png","filename":"e63e1bd1-36d3-4924-bb20-f9060ef30d11.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e94ec217-715c-46ca-b931-00efce7521e0.png","filename":"e94ec217-715c-46ca-b931-00efce7521e0.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:34:05.117' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'd63a97cf-2ab9-49b7-970d-82301e35270e', N'CHJd63a97', 2, 1, 2, N'78235', N'{"JobId":"d63a97cf-2ab9-49b7-970d-82301e35270e","ChJobID":"CHJd63a97","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e8b54108-8591-4479-a193-a64274ab5839.png","filename":"e8b54108-8591-4479-a193-a64274ab5839.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/8310ce69-266f-4b7a-9942-d21293c46daf.png","filename":"8310ce69-266f-4b7a-9942-d21293c46daf.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:45.983' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'd8a89d9c-3b24-4688-a267-1a02f87474ac', N'CHJd8a89d', 2, 1, 2, N'78235', N'{"JobId":"d8a89d9c-3b24-4688-a267-1a02f87474ac","ChJobID":"CHJd8a89d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/e6c6f1e3-1f58-4fe1-9631-f331e1f8bd7e.png","filename":"e6c6f1e3-1f58-4fe1-9631-f331e1f8bd7e.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cb0f523b-4a5d-4444-b88a-3ea4893f89fb.png","filename":"cb0f523b-4a5d-4444-b88a-3ea4893f89fb.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:46.630' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'da706820-3ee3-4454-acfe-4459c75f1bac', N'CHJda7068', 2, 1, 2, N'78235', N'{"JobId":"da706820-3ee3-4454-acfe-4459c75f1bac","ChJobID":"CHJda7068","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7ffd8603-e7c6-4680-a974-5a4fcdb06872.png","filename":"7ffd8603-e7c6-4680-a974-5a4fcdb06872.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/94d5b614-b737-45bb-b38f-c0cc97687471.png","filename":"94d5b614-b737-45bb-b38f-c0cc97687471.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:27.137' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'dbef5576-5dbf-4727-b549-752856fad97d', N'CHJdbef55', 2, 1, 2, N'78235', N'{"JobId":"dbef5576-5dbf-4727-b549-752856fad97d","ChJobID":"CHJdbef55","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7073b5a0-315e-4801-8193-57fe2ad1dccc.png","filename":"7073b5a0-315e-4801-8193-57fe2ad1dccc.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/2d38002f-6399-454e-a2d7-247bd488243e.png","filename":"2d38002f-6399-454e-a2d7-247bd488243e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:24.127' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'df9637f4-d914-40e9-b22e-e92799ee6036', N'CHJdf9637', 2, 1, 2, N'78235', N'{"JobId":"df9637f4-d914-40e9-b22e-e92799ee6036","ChJobID":"CHJdf9637","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/30df2213-c480-4d34-b822-9e8ea013c12c.png","filename":"30df2213-c480-4d34-b822-9e8ea013c12c.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/7a85855a-04de-4811-89dc-0be617b09c49.png","filename":"7a85855a-04de-4811-89dc-0be617b09c49.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:07.070' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'dff64592-63dc-4274-a76a-731b255b07d6', N'CHJdff645', 2, 1, 2, N'78235', N'{"JobId":"dff64592-63dc-4274-a76a-731b255b07d6","ChJobID":"CHJdff645","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ff505ce2-47f1-4c2a-ac72-ec6f5bd331f5.png","filename":"ff505ce2-47f1-4c2a-ac72-ec6f5bd331f5.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/752c785e-1854-484f-a907-df6d24cc3e5e.png","filename":"752c785e-1854-484f-a907-df6d24cc3e5e.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:57.523' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'e01c3fa5-9d91-4c94-83d7-152d5809a63b', N'CHJe01c3f', 2, 1, 2, N'78235', N'{"JobId":"e01c3fa5-9d91-4c94-83d7-152d5809a63b","ChJobID":"CHJe01c3f","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a1298b7a-b02f-4e4b-8e0e-282363d39a25.png","filename":"a1298b7a-b02f-4e4b-8e0e-282363d39a25.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/fe898a12-6746-4b7f-866a-2019ec38c140.png","filename":"fe898a12-6746-4b7f-866a-2019ec38c140.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:52.590' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'e3b3421b-6308-44ba-bf00-65a8506f1e98', N'CHJe3b342', 2, 1, 2, N'78235', N'{"JobId":"e3b3421b-6308-44ba-bf00-65a8506f1e98","ChJobID":"CHJe3b342","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c5ec8852-0411-47e1-9732-fe6713c9c8d5.png","filename":"c5ec8852-0411-47e1-9732-fe6713c9c8d5.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/100e6b29-9dbc-46b3-8566-9249ad9ac3d1.png","filename":"100e6b29-9dbc-46b3-8566-9249ad9ac3d1.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:25.807' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'e5f9c4fa-78de-4189-a8b7-27101a71f05b', N'CHJe5f9c4', 2, 1, 2, N'78235', N'{"JobId":"e5f9c4fa-78de-4189-a8b7-27101a71f05b","ChJobID":"CHJe5f9c4","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/c8298eda-30e8-4851-8601-ab062b8c0542.png","filename":"c8298eda-30e8-4851-8601-ab062b8c0542.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cb1469f6-23ca-49b3-8b31-5a3d8e887eec.png","filename":"cb1469f6-23ca-49b3-8b31-5a3d8e887eec.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:25.130' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'e70107d2-0e90-45bc-84ac-b7d9462b6b70', N'CHJe70107', 2, 1, 2, N'78235', N'{"JobId":"e70107d2-0e90-45bc-84ac-b7d9462b6b70","ChJobID":"CHJe70107","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1dcbbcf9-073f-428e-9f1d-46d792997492.png","filename":"1dcbbcf9-073f-428e-9f1d-46d792997492.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ea2deeeb-a75b-4bc5-8c3c-80e5ccf12377.png","filename":"ea2deeeb-a75b-4bc5-8c3c-80e5ccf12377.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:02.517' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'e7c3032b-dc92-4ff5-a887-b29d547ca58d', N'CHJe7c303', 2, 1, 2, N'78235', N'{"JobId":"e7c3032b-dc92-4ff5-a887-b29d547ca58d","ChJobID":"CHJe7c303","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/63ebbae9-65ff-48a2-9fdb-428ccea60210.png","filename":"63ebbae9-65ff-48a2-9fdb-428ccea60210.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/99d797f4-0e59-49f2-ba8b-2dc67a87fba6.png","filename":"99d797f4-0e59-49f2-ba8b-2dc67a87fba6.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:19.357' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'e91aa9aa-646c-45d0-9248-93bb9d5346bc', N'CHJe91aa9', 2, 1, 2, N'78235', N'{"JobId":"e91aa9aa-646c-45d0-9248-93bb9d5346bc","ChJobID":"CHJe91aa9","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/ed1853b1-1f92-45d8-ba68-bd5ce7bacc74.png","filename":"ed1853b1-1f92-45d8-ba68-bd5ce7bacc74.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/de1ad759-6eee-42df-899f-376c5165ae6d.png","filename":"de1ad759-6eee-42df-899f-376c5165ae6d.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:08.480' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'eee5af0d-416c-457b-8dae-a863d4990d87', N'CHJeee5af', 2, 1, 2, N'78235', N'{"JobId":"eee5af0d-416c-457b-8dae-a863d4990d87","ChJobID":"CHJeee5af","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/77ce9e30-914e-4352-9533-e39e95b61347.png","filename":"77ce9e30-914e-4352-9533-e39e95b61347.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/50497f27-1279-435c-bdf9-172a741fea7f.png","filename":"50497f27-1279-435c-bdf9-172a741fea7f.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:44.657' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'eee5d913-b642-45bb-be69-c764b5a65cf1', N'CHJeee5d9', 2, 1, 2, N'78235', N'{"JobId":"eee5d913-b642-45bb-be69-c764b5a65cf1","ChJobID":"CHJeee5d9","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/66fa1f7a-489e-4988-b190-e59c40145a61.png","filename":"66fa1f7a-489e-4988-b190-e59c40145a61.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/58a6b192-7498-415f-89f7-691d9b4f909d.png","filename":"58a6b192-7498-415f-89f7-691d9b4f909d.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:56.723' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'eef28d70-8509-464e-878b-75fab8878fdb', N'CHJeef28d', 2, 1, 2, N'78235', N'{"JobId":"eef28d70-8509-464e-878b-75fab8878fdb","ChJobID":"CHJeef28d","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/66240ea3-3f53-4c99-a072-af64e08c23f9.png","filename":"66240ea3-3f53-4c99-a072-af64e08c23f9.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/3d671200-5fc3-413e-a856-1b85e3d15a29.png","filename":"3d671200-5fc3-413e-a856-1b85e3d15a29.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:15.790' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'f214a193-a033-46b5-810c-856592b9ccc4', N'CHJf214a1', 2, 1, 2, N'78235', N'{"JobId":"f214a193-a033-46b5-810c-856592b9ccc4","ChJobID":"CHJf214a1","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a7b0c897-44d5-416c-8447-1b3508b1ec16.png","filename":"a7b0c897-44d5-416c-8447-1b3508b1ec16.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6fd8dfa5-97ce-46d2-87b4-2144405580bd.png","filename":"6fd8dfa5-97ce-46d2-87b4-2144405580bd.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:19.697' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'f69c81d4-2de9-4715-9e93-4a578c9fe4a1', N'CHJf69c81', 2, 1, 2, N'78235', N'{"JobId":"f69c81d4-2de9-4715-9e93-4a578c9fe4a1","ChJobID":"CHJf69c81","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b496ee18-2186-4544-988e-a45fd1099533.png","filename":"b496ee18-2186-4544-988e-a45fd1099533.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/1451104c-d754-46e3-ac54-3d850fbe9da9.png","filename":"1451104c-d754-46e3-ac54-3d850fbe9da9.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:49.667' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'f73f6501-50b1-465b-825d-8b2887c93fb0', N'CHJf73f65', 2, 1, 2, N'78235', N'{"JobId":"f73f6501-50b1-465b-825d-8b2887c93fb0","ChJobID":"CHJf73f65","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/0e614867-fb22-4b84-8d5d-f43a5e7f459d.png","filename":"0e614867-fb22-4b84-8d5d-f43a5e7f459d.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/6be683fc-0cd9-42b0-a35a-8b7c6606dca5.png","filename":"6be683fc-0cd9-42b0-a35a-8b7c6606dca5.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:38.283' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'fa06894f-5107-488e-bfa0-d421350b5196', N'CHJfa0689', 2, 1, 2, N'78235', N'{"JobId":"fa06894f-5107-488e-bfa0-d421350b5196","ChJobID":"CHJfa0689","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/75f48227-5c79-4bab-b529-6a3b3d37c159.png","filename":"75f48227-5c79-4bab-b529-6a3b3d37c159.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/126e6430-4bf9-48f3-9231-af19945047b5.png","filename":"126e6430-4bf9-48f3-9231-af19945047b5.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:31.373' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'fb7cd794-f200-44e9-9a7a-fa7ab737d1b9', N'CHJfb7cd7', 2, 1, 2, N'78235', N'{"JobId":"fb7cd794-f200-44e9-9a7a-fa7ab737d1b9","ChJobID":"CHJfb7cd7","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/a9f1747c-4f12-46d9-94e9-9124c6840737.png","filename":"a9f1747c-4f12-46d9-94e9-9124c6840737.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/872527b7-fbb1-44f2-b297-ecbb089456da.png","filename":"872527b7-fbb1-44f2-b297-ecbb089456da.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:09.110' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'fba321f8-2ba9-429e-8add-7e398544de26', N'CHJfba321', 2, 1, 2, N'78235', N'{"JobId":"fba321f8-2ba9-429e-8add-7e398544de26","ChJobID":"CHJfba321","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/b70027fa-b7b9-4215-a784-6c6f89dafee2.png","filename":"b70027fa-b7b9-4215-a784-6c6f89dafee2.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/bff4af73-cd39-41d1-be12-03d724fdb5ac.png","filename":"bff4af73-cd39-41d1-be12-03d724fdb5ac.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:40:02.077' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[JobPost] ([JobID], [ChJobID], [CategoryId], [EmploymentId], [ExperineceId], [PostedByID], [JobJson], [SearchInstance], [CreatedDate], [ModifyDate], [Is_Job], [Like_Countq], [Comment_Panel]) VALUES (N'fbf64535-bdfe-4731-9884-c552f32da93f', N'CHJfbf645', 2, 1, 2, N'78235', N'{"JobId":"fbf64535-bdfe-4731-9884-c552f32da93f","ChJobID":"CHJfbf645","PostedByID":"78235","PostedByName":"Shiva","RoleId":".Net Developer","Jobtitle":".Net Developer","CategoryID":2,"Category_Name":"Software Engineering","ExperienceID":2,"Experience_Name":"4-8yr","EmploymenttypeID":1,"Employmenttype_Name":"Remote","Salaryrange":"120000","JobDescription":"<html>Need a .net developer</html>","Is_Job":true,"Ip_Address":"192.168.26.32","Device_Type":"Window","city":["Bhubaneswar","Banagalore","Pune"],"Skills":["C#","Azure","Mvc","Sql",".Net Core"],"JobQuestions":["asda","sad","asd","asd","asd","ads","das","das","das"],"JobFiles":[{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/baedc8a6-07eb-433c-b648-68523bf453b5.png","filename":"baedc8a6-07eb-433c-b648-68523bf453b5.png"},{"filetype":"png","fileurl":"https://localhost:44342/JobFiles/cb8e2380-3f8d-4e04-b9d3-b99f4810cd18.png","filename":"cb8e2380-3f8d-4e04-b9d3-b99f4810cd18.png"}]}', N'-Bhubaneswar-Banagalore-Pune-.net developer-c#,azure,mvc,sql,.net core', CAST(N'2022-01-22T09:41:04.733' AS DateTime), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Question_Master] ([Question]) VALUES (N'Annual CTC?')
GO
INSERT [dbo].[Question_Master] ([Question]) VALUES (N'Excepted CTC?')
GO
INSERT [dbo].[Question_Master] ([Question]) VALUES (N'Notice Period as per the Offer Letter?')
GO
INSERT [dbo].[Question_Master] ([Question]) VALUES (N'Willing to Relocate?')
GO
INSERT [dbo].[Question_Master] ([Question]) VALUES (N'Total Year of Exp?')
GO
INSERT [dbo].[Role_Master] ([RoleName]) VALUES (N'.Net Developer')
GO
INSERT [dbo].[Role_Master] ([RoleName]) VALUES (N'HR Manager')
GO
INSERT [dbo].[Role_Master] ([RoleName]) VALUES (N'business development manager')
GO
INSERT [dbo].[Skill_Master] ([SkillName]) VALUES (N'["C#","Azure","Mvc","Sql",".Net Core"]')
GO
SET IDENTITY_INSERT [dbo].[User_Device_Tracking] ON 
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (1, N'78235', 1, N'CHJd27dc0', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:34:05.140' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (2, N'78235', 1, N'CHJ604039', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:34:06.000' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (3, N'78235', 1, N'CHJfba321', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:02.100' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (4, N'78235', 1, N'CHJ54a9e1', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:02.937' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (5, N'78235', 1, N'CHJ97a82a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:03.577' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (6, N'78235', 1, N'CHJa919fc', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:04.180' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (7, N'78235', 1, N'CHJa8c311', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:04.640' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (8, N'78235', 1, N'CHJa8097f', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:04.960' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (9, N'78235', 1, N'CHJb3212d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:05.343' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (10, N'78235', 1, N'CHJae2c5d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:05.710' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (11, N'78235', 1, N'CHJ8d2f6b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:06.047' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (12, N'78235', 1, N'CHJ3c8073', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:06.433' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (13, N'78235', 1, N'CHJ87d6b9', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:06.710' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (14, N'78235', 1, N'CHJdf9637', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:07.080' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (15, N'78235', 1, N'CHJ4006a0', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:08.830' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (16, N'78235', 1, N'CHJ75a17d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:09.423' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (17, N'78235', 1, N'CHJ56e38b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:09.903' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (18, N'78235', 1, N'CHJb75c46', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:10.350' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (19, N'78235', 1, N'CHJ2f6d79', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:10.850' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (20, N'78235', 1, N'CHJ7bd4c8', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:11.260' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (21, N'78235', 1, N'CHJa74bcd', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:11.630' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (22, N'78235', 1, N'CHJ3d9916', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:12.007' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (23, N'78235', 1, N'CHJ7e8688', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:13.340' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (24, N'78235', 1, N'CHJ091a03', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:13.877' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (25, N'78235', 1, N'CHJ69e824', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:14.397' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (26, N'78235', 1, N'CHJ913204', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:14.877' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (27, N'78235', 1, N'CHJb74265', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:15.323' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (28, N'78235', 1, N'CHJeef28d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:15.790' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (29, N'78235', 1, N'CHJa17348', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:16.200' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (30, N'78235', 1, N'CHJb615b5', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:16.683' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (31, N'78235', 1, N'CHJc2f3d8', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:17.103' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (32, N'78235', 1, N'CHJ6864ba', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:17.497' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (33, N'78235', 1, N'CHJc5c278', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:17.830' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (34, N'78235', 1, N'CHJ34aadb', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:18.177' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (35, N'78235', 1, N'CHJ5f9687', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:18.630' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (36, N'78235', 1, N'CHJ3a1964', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:19.073' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (37, N'78235', 1, N'CHJe7c303', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:19.360' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (38, N'78235', 1, N'CHJf214a1', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:19.700' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (39, N'78235', 1, N'CHJ964a5b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:20.013' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (40, N'78235', 1, N'CHJc59b94', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:20.393' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (41, N'78235', 1, N'CHJ4b417f', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:20.817' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (42, N'78235', 1, N'CHJ2e4ec0', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:21.187' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (43, N'78235', 1, N'CHJ0b64ab', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:21.557' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (44, N'78235', 1, N'CHJ87cd6a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:21.870' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (45, N'78235', 1, N'CHJ3322a7', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:22.247' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (46, N'78235', 1, N'CHJ0dadd9', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:22.843' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (47, N'78235', 1, N'CHJ4b0b44', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:23.777' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (48, N'78235', 1, N'CHJdbef55', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:24.130' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (49, N'78235', 1, N'CHJ39680a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:24.500' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (50, N'78235', 1, N'CHJ6e42af', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:24.823' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (51, N'78235', 1, N'CHJe5f9c4', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:25.133' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (52, N'78235', 1, N'CHJ43fc3a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:25.510' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (53, N'78235', 1, N'CHJe3b342', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:25.810' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (54, N'78235', 1, N'CHJ22c0ce', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:26.457' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (55, N'78235', 1, N'CHJ63ea43', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:26.757' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (56, N'78235', 1, N'CHJda7068', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:27.140' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (57, N'78235', 1, N'CHJa839e8', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:27.497' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (58, N'78235', 1, N'CHJ04bc69', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:27.773' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (59, N'78235', 1, N'CHJ7ae73f', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:28.697' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (60, N'78235', 1, N'CHJc902d0', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:29.107' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (61, N'78235', 1, N'CHJb093c3', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:30.060' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (62, N'78235', 1, N'CHJ75c87c', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:30.440' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (63, N'78235', 1, N'CHJfa0689', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:31.377' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (64, N'78235', 1, N'CHJc152ab', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:32.307' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (65, N'78235', 1, N'CHJ96fb8b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:32.910' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (66, N'78235', 1, N'CHJ4d1b16', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:33.297' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (67, N'78235', 1, N'CHJa13ea5', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:33.780' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (68, N'78235', 1, N'CHJ7728ea', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:36.470' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (69, N'78235', 1, N'CHJ0fd23a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:37.143' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (70, N'78235', 1, N'CHJ9e3b52', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:37.753' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (71, N'78235', 1, N'CHJf73f65', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:38.287' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (72, N'78235', 1, N'CHJ270447', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:38.743' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (73, N'78235', 1, N'CHJ5ffab7', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:39.167' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (74, N'78235', 1, N'CHJ5367b7', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:39.583' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (75, N'78235', 1, N'CHJ944210', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:39.980' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (76, N'78235', 1, N'CHJ8e8abf', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:40.260' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (77, N'78235', 1, N'CHJ01e9b8', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:40.643' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (78, N'78235', 1, N'CHJ6fa2ad', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:41.003' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (79, N'78235', 1, N'CHJ2a21ed', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:41.367' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (80, N'78235', 1, N'CHJ973b19', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:41.723' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (81, N'78235', 1, N'CHJ99c719', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:42.050' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (82, N'78235', 1, N'CHJ939b02', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:42.383' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (83, N'78235', 1, N'CHJaff344', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:42.680' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (84, N'78235', 1, N'CHJ4df043', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:43.067' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (85, N'78235', 1, N'CHJca51ee', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:43.380' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (86, N'78235', 1, N'CHJ170c1c', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:43.693' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (87, N'78235', 1, N'CHJ03ddd7', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:44.110' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (88, N'78235', 1, N'CHJeee5af', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:44.677' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (89, N'78235', 1, N'CHJ9b199b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:45.070' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (90, N'78235', 1, N'CHJbebd03', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:45.400' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (91, N'78235', 1, N'CHJd63a97', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:46.000' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (92, N'78235', 1, N'CHJ0911d2', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:46.323' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (93, N'78235', 1, N'CHJd8a89d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:46.650' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (94, N'78235', 1, N'CHJ46354d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:47.040' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (95, N'78235', 1, N'CHJ70928a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:47.650' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (96, N'78235', 1, N'CHJ5fe642', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:48.137' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (97, N'78235', 1, N'CHJ826d7b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:48.420' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (98, N'78235', 1, N'CHJ58369c', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:48.727' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (99, N'78235', 1, N'CHJ64c1e4', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:49.040' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (100, N'78235', 1, N'CHJcbc5ff', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:49.357' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (101, N'78235', 1, N'CHJf69c81', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:49.670' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (102, N'78235', 1, N'CHJ50bb4c', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:49.973' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (103, N'78235', 1, N'CHJ1631b2', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:50.317' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (104, N'78235', 1, N'CHJ758b26', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:50.673' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (105, N'78235', 1, N'CHJ6221fa', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:51.577' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (106, N'78235', 1, N'CHJ7cd283', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:51.927' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (107, N'78235', 1, N'CHJ3f9bec', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:52.293' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (108, N'78235', 1, N'CHJe01c3f', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:52.593' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (109, N'78235', 1, N'CHJ86aed2', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:55.230' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (110, N'78235', 1, N'CHJ8673a9', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:55.773' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (111, N'78235', 1, N'CHJ726e40', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:56.287' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (112, N'78235', 1, N'CHJeee5d9', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:56.727' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (113, N'78235', 1, N'CHJ950868', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:57.140' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (114, N'78235', 1, N'CHJdff645', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:57.530' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (115, N'78235', 1, N'CHJ9d588d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:57.900' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (116, N'78235', 1, N'CHJ6c7598', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:58.220' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (117, N'78235', 1, N'CHJ6ef3d0', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:58.567' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (118, N'78235', 1, N'CHJ6f6db8', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:58.887' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (119, N'78235', 1, N'CHJ557a36', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:59.230' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (120, N'78235', 1, N'CHJ2f3f26', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:40:59.840' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (121, N'78235', 1, N'CHJ0d968a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:00.233' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (122, N'78235', 1, N'CHJ997b8d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:00.573' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (123, N'78235', 1, N'CHJ0522ee', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:00.873' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (124, N'78235', 1, N'CHJ010943', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:01.180' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (125, N'78235', 1, N'CHJ47650a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:01.530' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (126, N'78235', 1, N'CHJbe1a8a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:01.833' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (127, N'78235', 1, N'CHJ05b442', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:02.187' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (128, N'78235', 1, N'CHJe70107', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:02.520' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (129, N'78235', 1, N'CHJa37ca5', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:03.127' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (130, N'78235', 1, N'CHJ87a1db', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:03.780' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (131, N'78235', 1, N'CHJ3f9055', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:04.160' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (132, N'78235', 1, N'CHJfbf645', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:04.733' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (133, N'78235', 1, N'CHJ9fe4da', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:05.113' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (134, N'78235', 1, N'CHJ740c18', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:05.513' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (135, N'78235', 1, N'CHJ26383a', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:05.807' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (136, N'78235', 1, N'CHJ9cc6e9', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:06.167' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (137, N'78235', 1, N'CHJ00b5d5', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:06.470' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (138, N'78235', 1, N'CHJ4fc559', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:06.830' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (139, N'78235', 1, N'CHJ903c37', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:07.127' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (140, N'78235', 1, N'CHJ25ee9e', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:07.453' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (141, N'78235', 1, N'CHJ542d5e', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:07.827' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (142, N'78235', 1, N'CHJd0707d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:08.207' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (143, N'78235', 1, N'CHJe91aa9', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:08.483' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (144, N'78235', 1, N'CHJ73a726', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:08.787' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (145, N'78235', 1, N'CHJfb7cd7', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:09.110' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (146, N'78235', 1, N'CHJcc30b5', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:09.483' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (147, N'78235', 1, N'CHJ34923b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:09.803' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (148, N'78235', 1, N'CHJb678a4', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:10.207' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (149, N'78235', 1, N'CHJ5a48a3', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:10.490' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (150, N'78235', 1, N'CHJ6c40f2', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:10.847' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (151, N'78235', 1, N'CHJ0687ff', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:11.170' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (152, N'78235', 1, N'CHJ758727', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:11.517' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (153, N'78235', 1, N'CHJ94b019', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:11.787' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (154, N'78235', 1, N'CHJ46a26b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:12.190' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (155, N'78235', 1, N'CHJ843a09', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:12.487' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (156, N'78235', 1, N'CHJa935fa', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:12.837' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (157, N'78235', 1, N'CHJd1f869', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:13.150' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (158, N'78235', 1, N'CHJ076954', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:14.057' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (159, N'78235', 1, N'CHJ274a3d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:14.430' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (160, N'78235', 1, N'CHJ76093d', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:14.847' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (161, N'78235', 1, N'CHJ859b8e', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:15.153' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (162, N'78235', 1, N'CHJa6a439', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:15.490' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (163, N'78235', 1, N'CHJ327bae', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:15.843' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (164, N'78235', 1, N'CHJ5e754b', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:16.187' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (165, N'78235', 1, N'CHJ0291ca', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:16.670' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (166, N'78235', 1, N'CHJ0b7539', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:16.920' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (167, N'78235', 1, N'CHJ803798', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:17.317' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (168, N'78235', 1, N'CHJ456924', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:17.903' AS DateTime))
GO
INSERT [dbo].[User_Device_Tracking] ([Device_Track_ID], [PostedByID], [Is_Job], [ChJobID], [Ip_Address], [Device_Type], [Action_DateTime]) VALUES (169, N'78235', 1, N'CHJ4722cc', N'192.168.26.32', N'Window', CAST(N'2022-01-22T09:41:18.320' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[User_Device_Tracking] OFF
GO
/****** Object:  StoredProcedure [dbo].[CreateJobForPublic]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[CreateJobForPublic]
@JobID varchar(250),
@ChJobID varchar(250),
@PostedByID varchar(250),
@JobJson varchar(MAX),
@SearchInstance varchar(MAX),
@CategoryId int,
@EmploymentId int,
@ExperineceId int,
@city varchar(max),
@Is_Job bit,
@Ip_Address varchar(max),
@Device_Type varchar(max)
as
begin
Insert into JobPost (JobID,ChJobID,CategoryId,EmploymentId,ExperineceId,PostedByID,JobJson,SearchInstance,CreatedDate,Is_Job)
values
(@JobID,@ChJobID,@CategoryId,@EmploymentId,@ExperineceId,@PostedByID,@JobJson,@SearchInstance,getdate(),@Is_Job)


----insert job as per the city
insert into Job_ByCity (City_Name,ChJobID,CategoryId,ExperineceId,EmploymentId)
SELECT LOWER (items),@ChJobID,@CategoryId,@ExperineceId,@EmploymentId FROM dbo.udf_Split(@city,',')

---Insert data for tracking
insert into User_Device_Tracking (PostedByID,Is_Job,ChJobID,Ip_Address,Device_Type,Action_DateTime)
values (@PostedByID,@Is_Job,@ChJobID,@Ip_Address,@Device_Type,getdate())
end

GO
/****** Object:  StoredProcedure [dbo].[GetJob_Category]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetJob_Category]
as
begin
select * from Job_Category FOR JSON AUTO
end;
GO
/****** Object:  StoredProcedure [dbo].[GetJob_City]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetJob_City]
as
begin
select * from Job_City FOR JSON AUTO
end
GO
/****** Object:  StoredProcedure [dbo].[GetJob_EmploymentType]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetJob_EmploymentType]
as
begin
select * from Job_EmploymentType FOR JSON AUTO
end
GO
/****** Object:  StoredProcedure [dbo].[GetJob_Expernice]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetJob_Expernice]
as
begin
select * from Job_Expernice FOR JSON AUTO
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateJobForPublic]    Script Date: 22-01-2022 9.42.34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[UpdateJobForPublic]
@ChJobID varchar(250),
@JobJson varchar(MAX),
@SearchInstance varchar(MAX),
@Ip_Address varchar(max),
@Device_Type varchar(max),
@PostedByID varchar(250),
@Is_Job bit
as
begin
update [dbo].[JobPost]
set JobJson=@JobJson,
SearchInstance=@SearchInstance,
ModifyDate=getdate()

---Insert data for tracking
insert into User_Device_Tracking (ChJobID,Ip_Address,Device_Type,Is_Job,Action_DateTime,PostedByID)
values(@ChJobID,@Ip_Address,@Device_Type,@Is_Job,getdate(),@PostedByID)
end
GO
USE [master]
GO
ALTER DATABASE [Cohire] SET  READ_WRITE 
GO
