USE [master]
GO
/****** Object:  Database [people]    Script Date: 01/10/2017 14:44:45 ******/
CREATE DATABASE [people] ON  PRIMARY 
( NAME = N'people', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\people.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'people_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\people_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [people] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [people].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [people] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [people] SET ANSI_NULLS OFF
GO
ALTER DATABASE [people] SET ANSI_PADDING OFF
GO
ALTER DATABASE [people] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [people] SET ARITHABORT OFF
GO
ALTER DATABASE [people] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [people] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [people] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [people] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [people] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [people] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [people] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [people] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [people] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [people] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [people] SET  DISABLE_BROKER
GO
ALTER DATABASE [people] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [people] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [people] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [people] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [people] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [people] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [people] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [people] SET  READ_WRITE
GO
ALTER DATABASE [people] SET RECOVERY SIMPLE
GO
ALTER DATABASE [people] SET  MULTI_USER
GO
ALTER DATABASE [people] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [people] SET DB_CHAINING OFF
GO
USE [people]
GO
/****** Object:  Table [dbo].[people]    Script Date: 01/10/2017 14:44:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[people](
	[Sys_Gen] [nvarchar](1000) NULL,
	[Name] [nvarchar](1000) NULL,
	[Sched_In] [nvarchar](1000) NULL,
	[Sched_Out] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Perez , Adrian ', N'Adrian M. Perez', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Oliveros, Nicole', N'Aimee Nicole L. Oliveros', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Lui, Ayami Gayle', N'Ayami Gayle Lui', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Isip , Carlo Lucas ', N'Carlo L Isip', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Ngo, Charmaine Mae R', N'Charmaine Mae Rose O Ngo', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Roa, Christine Anne ', N'Christine Anne V. Roa', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'REYES, CHRISTINE MAR', N'Christine Marianne B Reyes', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Sazon, Clareich', N'Clareich Z. Sazon', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Sotelo, Erby Jennife', N'Erby Jennifer Sotelo', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Delos Santos, Fe Mar+A20', N'Fe Mariz Delos Santos', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Evidente , Gian Fran', N'Gian Franco S. Evidente', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Quintanes, Jam Camil', N'Jam Camille F. Quintanes', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Caparros, Jamaica Ma', N'Jamaica Mae T. Caparros', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'PH011607358, Oblepia', N'Jan Carlo A. Oblepias', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Jordan, Jezzaline', N'Jezzaline T. Jordan', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Ordinanza, Joane Pau', N'Joane Pau Ordinanza', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Niu, Joyce Diane', N'Joyce Diane Go Niu', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Perez , Justine Jire ', N'Justine Jireh Perez', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Cayabyab, Karen', N'Karen C Cayabyab', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Miguel , Karl Ann ', N'Karl Ann D Miguel', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'King, Kathryn  Ann', N'Kathryn Ann M. King', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Nagano, Keiko', N'Keiko B. Nagano', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Castor, Kim Anne', N'Kim Anne M. Castor', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Cabatic, Kim', N'Kim T Cabatic', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Tumaliuan , Kimberly ', N'Kimberly Tumaliuan', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Hao Lin , Lanz Patri', N'Lanz Patrick J HaoLin', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Libres, Ma. Kristina', N'Ma. Kristina E. Libres', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'CANDELARIO, MA. TRIS', N'Ma. Trishia R. Candelario', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Dagdag , Marie Gaell ', N'Marie Gaelle Dagdag', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Boter, Marilyn', N'Marilyn A. Boter', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Roldan , Meleena Ros', N'Meleena Rose Y Roldan', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Luangco, Mergieli', N'Mergeli T Luangco', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Repizo, Myreen', N'Myreen M Repizo', N'7:00:00 AM', N'4:00:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Martinez, Paolo pedr', N'Paolo Pedro C. Martinez', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Ico , Rejeanne ', N'Reajeanne D Ico', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Arguelles , Renalyn ', N'Renalyn Arguelles', N'7:15:00 AM', N'4:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'ROQUE, TRIZIA ROBY-A', N'Trizia Roby Ann C Roque', N'8:15:00 AM', N'5:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Go, Wrenz', N'Wrenz Wilyam C Go', N'9:15:00 AM', N'6:30:00 PM')
INSERT [dbo].[people] ([Sys_Gen], [Name], [Sched_In], [Sched_Out]) VALUES (N'Ubanan, Zuzete ', N'Zuzete B. Ubanan ', N'9:15:00 AM', N'6:30:00 PM')
