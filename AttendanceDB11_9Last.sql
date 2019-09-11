USE [master]
GO
/****** Object:  Database [Attendance]    Script Date: 9/11/2019 3:40:33 PM ******/
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
/****** Object:  Table [dbo].[Attendance]    Script Date: 9/11/2019 3:40:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Attendance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[AttendanceDate] [char](10) NULL,
	[CheckInTime] [nvarchar](8) NULL,
	[CheckOutTime] [nvarchar](8) NULL,
	[ShiftFrom] [nvarchar](8) NULL,
	[ShiftTo] [nvarchar](8) NULL,
	[ProvidedTotalMin] [int] NULL,
	[ActualTotalMin] [int] NULL,
	[RecordSource] [nvarchar](50) NULL,
	[UploadedFileId] [int] NULL,
	[CreateDate] [char](10) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AttendanceLog]    Script Date: 9/11/2019 3:40:33 PM ******/
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
	[UploadedType] [nvarchar](max) NULL,
	[FileID] [int] NULL,
 CONSTRAINT [PK_AttendanceLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttMachine]    Script Date: 9/11/2019 3:40:33 PM ******/
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
/****** Object:  Table [dbo].[AttMachineTableRefrence]    Script Date: 9/11/2019 3:40:33 PM ******/
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
/****** Object:  Table [dbo].[AttTableDefination]    Script Date: 9/11/2019 3:40:33 PM ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 9/11/2019 3:40:33 PM ******/
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
/****** Object:  Table [dbo].[FileRefrence]    Script Date: 9/11/2019 3:40:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileRefrence](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileNumber] [nvarchar](max) NULL,
	[FilePath] [nvarchar](max) NULL,
	[Comment] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[IsActive] [int] NULL,
 CONSTRAINT [PK_FileRefrence] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Senarios]    Script Date: 9/11/2019 3:40:33 PM ******/
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
SET IDENTITY_INSERT [dbo].[AttendanceLog] ON 

GO
INSERT [dbo].[AttendanceLog] ([Id], [Date], [TimeIN], [TimeOut], [TimeFunction], [FunctionID], [EmployeeID], [MachineTableID], [UploadedType], [FileID]) VALUES (37, N'08/09/2019', N'09:00:00', N'18:22:00', NULL, NULL, 5, 1007, N'File', 15)
GO
INSERT [dbo].[AttendanceLog] ([Id], [Date], [TimeIN], [TimeOut], [TimeFunction], [FunctionID], [EmployeeID], [MachineTableID], [UploadedType], [FileID]) VALUES (38, N'08/09/2019', N'09:15:00', N'22:12:00', NULL, NULL, 5, 1007, N'File', 16)
GO
INSERT [dbo].[AttendanceLog] ([Id], [Date], [TimeIN], [TimeOut], [TimeFunction], [FunctionID], [EmployeeID], [MachineTableID], [UploadedType], [FileID]) VALUES (39, N'10/09/2019', N'08:00:00', N'15:00:00', NULL, NULL, 7, 1007, N'File', 17)
GO
INSERT [dbo].[AttendanceLog] ([Id], [Date], [TimeIN], [TimeOut], [TimeFunction], [FunctionID], [EmployeeID], [MachineTableID], [UploadedType], [FileID]) VALUES (40, N'10/09/2019', N'09:00:00', N'17:00:00', NULL, NULL, 7, 1007, N'File', 17)
GO
SET IDENTITY_INSERT [dbo].[AttendanceLog] OFF
GO
SET IDENTITY_INSERT [dbo].[AttMachine] ON 

GO
INSERT [dbo].[AttMachine] ([MachId], [MachineName], [SenarioID], [IsDeleted]) VALUES (2004, N'Mac01', 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[AttMachine] OFF
GO
SET IDENTITY_INSERT [dbo].[AttMachineTableRefrence] ON 

GO
INSERT [dbo].[AttMachineTableRefrence] ([Id], [MachineID], [TableID]) VALUES (1007, 2004, 2006)
GO
SET IDENTITY_INSERT [dbo].[AttMachineTableRefrence] OFF
GO
SET IDENTITY_INSERT [dbo].[AttTableDefination] ON 

GO
INSERT [dbo].[AttTableDefination] ([TableId], [SenarioID], [ColumnDefination], [ColumnOrder], [IsDeleted]) VALUES (2006, 1, N'EmployeeID,Date,TimeIN,TimeOut,MachineTableID', N'6,1,2,3,7', NULL)
GO
SET IDENTITY_INSERT [dbo].[AttTableDefination] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

GO
INSERT [dbo].[Employee] ([EmployeeId], [ReferenceNumber], [EmployeeName]) VALUES (5, N'EMP5', N'Ahmed Anwar Ibrahem')
GO
INSERT [dbo].[Employee] ([EmployeeId], [ReferenceNumber], [EmployeeName]) VALUES (6, N'EMP6', N'Hesham Mohamed')
GO
INSERT [dbo].[Employee] ([EmployeeId], [ReferenceNumber], [EmployeeName]) VALUES (7, N'EMP7', N'Hadeer Mohamed')
GO
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[FileRefrence] ON 

GO
INSERT [dbo].[FileRefrence] ([Id], [FileNumber], [FilePath], [Comment], [CreatedDate], [IsActive]) VALUES (15, N'904d95fb', N'Content/AttendanceFiles/20190911134952801Attendance (57).xlsx', N'Anwar', CAST(N'2019-09-11 13:49:52.803' AS DateTime), 1)
GO
INSERT [dbo].[FileRefrence] ([Id], [FileNumber], [FilePath], [Comment], [CreatedDate], [IsActive]) VALUES (16, N'bd08397d', N'Content/AttendanceFiles/20190911135225716Attendance (57).xlsx', N'Anwar', CAST(N'2019-09-11 13:52:25.720' AS DateTime), 1)
GO
INSERT [dbo].[FileRefrence] ([Id], [FileNumber], [FilePath], [Comment], [CreatedDate], [IsActive]) VALUES (17, N'3cae965c', N'Content/AttendanceFiles/20190911135603632Attendance (59).xlsx', N'test2', CAST(N'2019-09-11 13:56:03.633' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[FileRefrence] OFF
GO
SET IDENTITY_INSERT [dbo].[Senarios] ON 

GO
INSERT [dbo].[Senarios] ([Id], [SenarioName]) VALUES (1, N'TimeIN / TimeOUT')
GO
INSERT [dbo].[Senarios] ([Id], [SenarioName]) VALUES (2, N'Time with Function')
GO
SET IDENTITY_INSERT [dbo].[Senarios] OFF
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Employee]
GO
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
ALTER TABLE [dbo].[AttendanceLog]  WITH CHECK ADD  CONSTRAINT [FK_AttendanceLog_FileRefrence] FOREIGN KEY([FileID])
REFERENCES [dbo].[FileRefrence] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AttendanceLog] CHECK CONSTRAINT [FK_AttendanceLog_FileRefrence]
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
/****** Object:  StoredProcedure [dbo].[FillFunctionAttendance]    Script Date: 9/11/2019 3:40:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FillFunctionAttendance]
(@uploadedFileId int,@CreatedDate date)
as
begin
Update dbo.AttendanceLog set UploadedType = 'Trigger' where FileID = @uploadedFileId
print'Hello'
end







GO
/****** Object:  StoredProcedure [dbo].[FillNewAttendance]    Script Date: 9/11/2019 3:40:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FillNewAttendance]
(@uploadedFileId int,@CreatedDate date)
as
begin

insert into [dbo].[Attendance] 
(EmployeeId,AttendanceDate,CheckInTime,CheckOutTime,RecordSource,UploadedFileId,CreateDate,IsActive)

select emp.EmployeeId, up.Date,up.TimeIN,up.TimeOut,'File',@uploadedFileId,@CreatedDate ,1
from [dbo].[AttendanceLog] up
inner join [dbo].[Employee] emp
on up.EmployeeID=emp.EmployeeId 
left outer join [dbo].[Attendance] AS att
on att.EmployeeId=emp.EmployeeId
AND convert(char(10),att.AttendanceDate,103)=convert(char(10),up.Date,103)
where att.Id is null
and up.FileID=@uploadedFileId
and up.Id = (select Max(Id) from [dbo].[AttendanceLog] dis 
            where dis.EmployeeID=up.EmployeeID
			and dis.Date=up.Date
			and dis.FileID=up.FileID
			group by dis.EmployeeID,dis.Date,dis.FileID)

update [dbo].[Attendance] 
set EmployeeId= emp.EmployeeId,
	AttendanceDate =up.Date,
	CheckInTime=up.TimeIN,
	CheckOutTime=up.TimeOut,
	RecordSource='File',
	UploadedFileId=@uploadedFileId,
	CreateDate=@CreatedDate,
	IsActive=1
from [dbo].[AttendanceLog] AS up 
	inner join [dbo].[Employee] AS emp
		on up.EmployeeID=emp.EmployeeId
	inner join [dbo].[Attendance] AS att
	ON att.EmployeeId=emp.EmployeeId
	ANd convert(char(10),att.AttendanceDate,103)=convert(char(10),up.Date,103)
and up.FileID=@uploadedFileId

 select Id, EmployeeId,AttendanceDate,CheckInTime,CheckOutTime,RecordSource,UploadedFileId,CreateDate,[IsActive] from [dbo].[Attendance]
where UploadedFileId=@uploadedFileId
end


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [dbo].[FileRefrenceUpdateTrigger] ON [dbo].[FileRefrence]  AFTER UPDATE AS 


BEGIN
    DECLARE @status varchar(50);
	DECLARE @fileid int;
	DECLARE @datecreate date;
	DECLARE @senarioid int;

   SELECT @status=i.IsActive FROM inserted i;
   SELECT @fileid=i.Id FROM inserted i;
   SELECT @datecreate=i.CreatedDate FROM inserted i;

  set @senarioid = (select Max(s.Id) from dbo.Senarios as s 
	inner join dbo.AttMachine as mach
	on mach.SenarioID = s.Id
	inner join dbo.AttTableDefination as tbldef
	on tbldef.SenarioID = s.Id
	inner join dbo.AttMachineTableRefrence as atttblref
	on atttblref.MachineID = mach.MachId
	and atttblref.TableID = tbldef.TableId
	inner join dbo.AttendanceLog as attlog
	on attlog.MachineTableID = atttblref.Id
	inner join dbo.FileRefrence as filere
	on filere.Id = attlog.FileID
	where filere.Id = 17)


  IF @status = 1 and @senarioid = 1
	exec dbo.FillNewAttendance @uploadedFileId = @fileid, @CreatedDate = @datecreate;
	Else If  @status = 1 and @senarioid = 2
	exec dbo.FillFunctionAttendance @uploadedFileId = @fileid, @CreatedDate = @datecreate;
END;




GO
USE [master]
GO
ALTER DATABASE [Attendance] SET  READ_WRITE 
GO
