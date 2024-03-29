USE [master]
GO
/****** Object:  Database [Attendance]    Script Date: 9/5/2019 5:34:57 PM ******/
CREATE DATABASE [Attendance]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Attendance', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Attendance.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Attendance_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Attendance_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Attendance] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Attendance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Attendance] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Attendance] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Attendance] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Attendance] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Attendance] SET ARITHABORT OFF 
GO
ALTER DATABASE [Attendance] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Attendance] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Attendance] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Attendance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Attendance] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Attendance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Attendance] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Attendance] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Attendance] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Attendance] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Attendance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Attendance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Attendance] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Attendance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Attendance] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Attendance] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Attendance] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Attendance] SET RECOVERY FULL 
GO
ALTER DATABASE [Attendance] SET  MULTI_USER 
GO
ALTER DATABASE [Attendance] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Attendance] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Attendance] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Attendance] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Attendance] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Attendance', N'ON'
GO
USE [Attendance]
GO
/****** Object:  Table [dbo].[AttendanceLog]    Script Date: 9/5/2019 5:34:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttendanceLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [nvarchar](max) NULL,
	[TimeIN] [nvarchar](max) NULL,
	[TimeOut] [nvarchar](max) NULL,
	[TimeFunction] [nvarchar](max) NULL,
	[FunctionID] [nvarchar](max) NULL,
	[EmployeeID] [int] NULL,
	[MachineTableID] [int] NULL,
	[Comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_AttendanceLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttMachine]    Script Date: 9/5/2019 5:34:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttMachine](
	[MachId] [int] IDENTITY(1,1) NOT NULL,
	[MachineName] [nvarchar](max) NOT NULL,
	[SenarioID] [int] NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_AttMachine] PRIMARY KEY CLUSTERED 
(
	[MachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttMachineTableRefrence]    Script Date: 9/5/2019 5:34:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttMachineTableRefrence](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MachineID] [int] NULL,
	[TableID] [int] NULL,
 CONSTRAINT [PK_AttMachineTableRefrence] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttTableDefination]    Script Date: 9/5/2019 5:34:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttTableDefination](
	[TableId] [int] IDENTITY(1,1) NOT NULL,
	[SenarioID] [int] NULL,
	[ColumnDefination] [nvarchar](max) NULL,
	[ColumnOrder] [nvarchar](max) NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_AttTableDefination] PRIMARY KEY CLUSTERED 
(
	[TableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 9/5/2019 5:34:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceNumber] [nvarchar](max) NULL,
	[EmployeeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_HRM.Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Senarios]    Script Date: 9/5/2019 5:34:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Senarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SenarioName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Senarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[AttMachine] ON 

INSERT [dbo].[AttMachine] ([MachId], [MachineName], [SenarioID], [IsDeleted]) VALUES (1, N'Mac01', 1, NULL)
INSERT [dbo].[AttMachine] ([MachId], [MachineName], [SenarioID], [IsDeleted]) VALUES (2, N'Fun06', 2, NULL)
INSERT [dbo].[AttMachine] ([MachId], [MachineName], [SenarioID], [IsDeleted]) VALUES (3, N'Fun22', 2, NULL)
INSERT [dbo].[AttMachine] ([MachId], [MachineName], [SenarioID], [IsDeleted]) VALUES (4, N'Mac14', 1, NULL)
INSERT [dbo].[AttMachine] ([MachId], [MachineName], [SenarioID], [IsDeleted]) VALUES (1002, N'Anwar23', 1, NULL)
SET IDENTITY_INSERT [dbo].[AttMachine] OFF
SET IDENTITY_INSERT [dbo].[AttMachineTableRefrence] ON 

INSERT [dbo].[AttMachineTableRefrence] ([Id], [MachineID], [TableID]) VALUES (1, 1, 1003)
INSERT [dbo].[AttMachineTableRefrence] ([Id], [MachineID], [TableID]) VALUES (2, 4, 1003)
INSERT [dbo].[AttMachineTableRefrence] ([Id], [MachineID], [TableID]) VALUES (3, 2, 1004)
INSERT [dbo].[AttMachineTableRefrence] ([Id], [MachineID], [TableID]) VALUES (4, 3, 1004)
INSERT [dbo].[AttMachineTableRefrence] ([Id], [MachineID], [TableID]) VALUES (5, 1002, 1005)
SET IDENTITY_INSERT [dbo].[AttMachineTableRefrence] OFF
SET IDENTITY_INSERT [dbo].[AttTableDefination] ON 

INSERT [dbo].[AttTableDefination] ([TableId], [SenarioID], [ColumnDefination], [ColumnOrder], [IsDeleted]) VALUES (1003, 1, N'EmployeeID,Date,TimeIN,TimeOut,MachineTableID', N'4,1,2,3,5', NULL)
INSERT [dbo].[AttTableDefination] ([TableId], [SenarioID], [ColumnDefination], [ColumnOrder], [IsDeleted]) VALUES (1004, 2, N'EmployeeID,Date,TimeFunction,FunctionID,MachineTableID', N'4,1,2,3,5', NULL)
INSERT [dbo].[AttTableDefination] ([TableId], [SenarioID], [ColumnDefination], [ColumnOrder], [IsDeleted]) VALUES (1005, 1, N'Date,TimeIN,TimeOut,MachineTableID,EmployeeID', N'1,2,3,5,4', NULL)
SET IDENTITY_INSERT [dbo].[AttTableDefination] OFF
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeId], [ReferenceNumber], [EmployeeName]) VALUES (5, N'EMP5', N'Ahmed Anwar Ibrahem')
INSERT [dbo].[Employee] ([EmployeeId], [ReferenceNumber], [EmployeeName]) VALUES (6, N'EMP6', N'Hesham Mohamed')
INSERT [dbo].[Employee] ([EmployeeId], [ReferenceNumber], [EmployeeName]) VALUES (7, N'EMP7', N'Hadeer Mohamed')
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[Senarios] ON 

INSERT [dbo].[Senarios] ([Id], [SenarioName]) VALUES (1, N'TimeIN / TimeOUT')
INSERT [dbo].[Senarios] ([Id], [SenarioName]) VALUES (2, N'Time with Function')
SET IDENTITY_INSERT [dbo].[Senarios] OFF
ALTER TABLE [dbo].[AttendanceLog]  WITH CHECK ADD  CONSTRAINT [FK_AttendanceLog_AttMachineTableRefrence] FOREIGN KEY([MachineTableID])
REFERENCES [dbo].[AttMachineTableRefrence] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AttendanceLog] CHECK CONSTRAINT [FK_AttendanceLog_AttMachineTableRefrence]
GO
ALTER TABLE [dbo].[AttendanceLog]  WITH CHECK ADD  CONSTRAINT [FK_AttendanceLog_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AttendanceLog] CHECK CONSTRAINT [FK_AttendanceLog_Employee]
GO
ALTER TABLE [dbo].[AttMachine]  WITH CHECK ADD  CONSTRAINT [FK_AttMachine_Senarios] FOREIGN KEY([SenarioID])
REFERENCES [dbo].[Senarios] ([Id])
GO
ALTER TABLE [dbo].[AttMachine] CHECK CONSTRAINT [FK_AttMachine_Senarios]
GO
ALTER TABLE [dbo].[AttMachineTableRefrence]  WITH CHECK ADD  CONSTRAINT [FK_AttMachineTableRefrence_AttMachine] FOREIGN KEY([MachineID])
REFERENCES [dbo].[AttMachine] ([MachId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AttMachineTableRefrence] CHECK CONSTRAINT [FK_AttMachineTableRefrence_AttMachine]
GO
ALTER TABLE [dbo].[AttMachineTableRefrence]  WITH CHECK ADD  CONSTRAINT [FK_AttMachineTableRefrence_AttTableDefination] FOREIGN KEY([TableID])
REFERENCES [dbo].[AttTableDefination] ([TableId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AttMachineTableRefrence] CHECK CONSTRAINT [FK_AttMachineTableRefrence_AttTableDefination]
GO
ALTER TABLE [dbo].[AttTableDefination]  WITH CHECK ADD  CONSTRAINT [FK_AttTableDefination_Senarios] FOREIGN KEY([SenarioID])
REFERENCES [dbo].[Senarios] ([Id])
GO
ALTER TABLE [dbo].[AttTableDefination] CHECK CONSTRAINT [FK_AttTableDefination_Senarios]
GO
USE [master]
GO
ALTER DATABASE [Attendance] SET  READ_WRITE 
GO
