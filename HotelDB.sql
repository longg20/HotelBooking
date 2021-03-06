USE [master]
GO
/****** Object:  Database [HotelDB]    Script Date: 11/2/2020 9:13:37 PM ******/
CREATE DATABASE [HotelDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HotelDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\HotelDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HotelDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\HotelDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [HotelDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HotelDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HotelDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HotelDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HotelDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HotelDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HotelDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HotelDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HotelDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HotelDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HotelDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HotelDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HotelDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HotelDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HotelDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HotelDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HotelDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HotelDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HotelDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HotelDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HotelDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HotelDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HotelDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HotelDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HotelDB] SET RECOVERY FULL 
GO
ALTER DATABASE [HotelDB] SET  MULTI_USER 
GO
ALTER DATABASE [HotelDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HotelDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HotelDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HotelDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HotelDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HotelDB', N'ON'
GO
ALTER DATABASE [HotelDB] SET QUERY_STORE = OFF
GO
USE [HotelDB]
GO
/****** Object:  Table [dbo].[tblArea]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArea](
	[AreaID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tblArea] PRIMARY KEY CLUSTERED 
(
	[AreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBooking]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBooking](
	[BookingID] [uniqueidentifier] NOT NULL,
	[UserID] [varchar](500) NOT NULL,
	[Booking Date] [datetime] NOT NULL,
	[CheckIn Date] [date] NOT NULL,
	[CheckOut Date] [date] NOT NULL,
	[Total] [float] NOT NULL,
	[Code] [varchar](500) NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_tblBooking_1] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBookingDetail]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBookingDetail](
	[BookingDetailID] [int] IDENTITY(1,1) NOT NULL,
	[BookingID] [uniqueidentifier] NOT NULL,
	[RoomID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [PK_tblBookingDetail] PRIMARY KEY CLUSTERED 
(
	[BookingDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCode]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCode](
	[CodeID] [varchar](500) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Discount Percent] [int] NOT NULL,
	[Create Date] [datetime] NOT NULL,
	[Expire Date] [date] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_tblCode] PRIMARY KEY CLUSTERED 
(
	[CodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFeedback]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFeedback](
	[FeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](500) NOT NULL,
	[RoomID] [int] NOT NULL,
	[Rating] [float] NOT NULL,
	[Comment] [varchar](max) NULL,
 CONSTRAINT [PK_tblFeedback] PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblHotel]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHotel](
	[HotelID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Area] [int] NOT NULL,
	[Image] [varchar](max) NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_tblHotel] PRIMARY KEY CLUSTERED 
(
	[HotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoom]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoom](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[HotelID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_tblRoom] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoomType]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoomType](
	[RoomTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tblRoomType] PRIMARY KEY CLUSTERED 
(
	[RoomTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatus](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tblStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 11/2/2020 9:13:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserID] [varchar](500) NOT NULL,
	[Password] [varchar](max) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Phone] [varchar](max) NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[Create Date] [datetime] NOT NULL,
	[Role] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblArea] ON 

INSERT [dbo].[tblArea] ([AreaID], [Name]) VALUES (1, N'Ho Chi Minh')
INSERT [dbo].[tblArea] ([AreaID], [Name]) VALUES (2, N'Ha Noi')
INSERT [dbo].[tblArea] ([AreaID], [Name]) VALUES (3, N'Thanh Hoa')
SET IDENTITY_INSERT [dbo].[tblArea] OFF
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'd4b80945-f79b-4f4a-a091-04c69532841e', N'member@gmail.com', CAST(N'2020-10-30T16:14:19.510' AS DateTime), CAST(N'2020-10-10' AS Date), CAST(N'2020-10-31' AS Date), 150, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'571e1165-714a-442b-9118-0829e05a9215', N'verylong0908@gmail.com', CAST(N'2020-11-02T21:09:54.807' AS DateTime), CAST(N'2020-11-03' AS Date), CAST(N'2020-11-12' AS Date), 445, NULL, 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'23bb2356-a232-49d9-9991-15dcd9c3726c', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:37:19.257' AS DateTime), CAST(N'2020-11-02' AS Date), CAST(N'2020-11-04' AS Date), 480, NULL, 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'0df1d016-805a-4ddf-9650-1e621daea3e4', N'longttse140019@fpt.edu.vn', CAST(N'2020-10-31T22:31:56.890' AS DateTime), CAST(N'2020-10-09' AS Date), CAST(N'2020-11-07' AS Date), 1015, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'e4fb0e8f-bd76-4f21-b3fe-2e1548f2c6ec', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T15:16:45.980' AS DateTime), CAST(N'2020-11-14' AS Date), CAST(N'2020-11-27' AS Date), 310, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'093aeb16-8194-4e26-b4c0-362279752412', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T07:15:12.973' AS DateTime), CAST(N'2020-11-03' AS Date), CAST(N'2020-11-28' AS Date), 207, N'DISCOUNT001', 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'3493b67b-cfcf-4ccc-8cd0-3676ae940f26', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T16:26:43.840' AS DateTime), CAST(N'2020-11-12' AS Date), CAST(N'2020-11-27' AS Date), 617.5, N'TESTCODE', 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'441f0238-addc-485b-999d-437a2a1e876a', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T16:12:38.100' AS DateTime), CAST(N'2020-11-01' AS Date), CAST(N'2020-11-02' AS Date), 590, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'467b0097-074d-4828-bddc-47561f8ca40c', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T16:32:59.787' AS DateTime), CAST(N'2020-11-12' AS Date), CAST(N'2020-12-12' AS Date), 436.5, N'DISCOUNT01', 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'e900e90d-5b7c-4b08-80e9-494b29e22966', N'longttse140019@fpt.edu.vn', CAST(N'2020-10-31T21:12:01.260' AS DateTime), CAST(N'2020-10-10' AS Date), CAST(N'2020-10-23' AS Date), 230, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'4434aa31-16f8-462e-9d9b-4b903ef91231', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:33:45.433' AS DateTime), CAST(N'2020-11-02' AS Date), CAST(N'2020-11-03' AS Date), 525, NULL, 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'1a4665bb-198d-4fb4-be03-4c33e2d08fc3', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T07:07:20.543' AS DateTime), CAST(N'2020-11-02' AS Date), CAST(N'2020-12-04' AS Date), 270, N'DISCOUNT04', 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'86141d39-542f-4667-8d7d-5d9a76966678', N'longttse140019@fpt.edu.vn', CAST(N'2020-10-31T12:07:43.013' AS DateTime), CAST(N'2020-10-30' AS Date), CAST(N'2020-11-11' AS Date), 315, NULL, 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'832c4308-719e-4dc2-94d1-616ca5de04de', N'member@gmail.com', CAST(N'2020-10-30T16:38:08.453' AS DateTime), CAST(N'2020-10-10' AS Date), CAST(N'2020-10-31' AS Date), 560, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'd3f8b0d0-505c-4d3e-88fa-66f2d5d9e8db', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:44:30.180' AS DateTime), CAST(N'2020-11-02' AS Date), CAST(N'2020-11-04' AS Date), 230, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'4a156748-7c94-4a34-94e6-839e927e8ffd', N'longttse140019@fpt.edu.vn', CAST(N'2020-10-30T23:34:14.910' AS DateTime), CAST(N'2020-10-16' AS Date), CAST(N'2020-11-05' AS Date), 510, NULL, 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'379b1571-f1cb-4d49-9447-8827c6e8a23c', N'verylong0908@gmail.com', CAST(N'2020-11-02T21:05:59.647' AS DateTime), CAST(N'2020-11-03' AS Date), CAST(N'2020-11-12' AS Date), 487.5, N'DISCOUNT05', 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'8680a491-39e2-4256-9b19-8855a723ea3e', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:50:12.847' AS DateTime), CAST(N'2020-11-18' AS Date), CAST(N'2020-11-25' AS Date), 190, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'bbe20805-7f21-452f-add9-8d7bb74d43ba', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T11:36:32.197' AS DateTime), CAST(N'2020-11-05' AS Date), CAST(N'2020-11-11' AS Date), 585, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'ff0f58ee-1005-4713-9545-92a36fa536d7', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:35:16.743' AS DateTime), CAST(N'2020-11-05' AS Date), CAST(N'2020-11-07' AS Date), 240, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'b0fe8ec0-b4fe-4440-9082-945ca5a3192e', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:48:22.270' AS DateTime), CAST(N'2020-11-18' AS Date), CAST(N'2020-11-20' AS Date), 255, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'8bae4fef-0e63-4f9f-816c-9764bd2f758f', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T16:49:11.793' AS DateTime), CAST(N'2020-11-04' AS Date), CAST(N'2020-12-12' AS Date), 600, N'DISCOUNT02', 0)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'9db38623-f1b3-479c-a49d-990d03e2ac1d', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:45:13.460' AS DateTime), CAST(N'2020-11-12' AS Date), CAST(N'2020-11-19' AS Date), 210, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'a8821e2c-ca46-4db9-935e-9f9988096ad8', N'verylong09082@gmail.com', CAST(N'2020-11-01T21:37:12.983' AS DateTime), CAST(N'2020-11-01' AS Date), CAST(N'2020-12-12' AS Date), 1225, N'DISCOUNT03', 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'b8ad43fe-38f3-4535-a182-a0f911b990f1', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T11:40:46.287' AS DateTime), CAST(N'2020-11-21' AS Date), CAST(N'2020-11-27' AS Date), 240, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'a8ae8dc0-c9bc-48e6-b8d9-b23af7d33e93', N'longttse140019@fpt.edu.vn', CAST(N'2020-10-31T16:22:44.227' AS DateTime), CAST(N'2020-10-15' AS Date), CAST(N'2020-10-30' AS Date), 360, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'2c4d2909-ec7e-4bab-b197-c0d8179be720', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T16:20:31.327' AS DateTime), CAST(N'2020-11-13' AS Date), CAST(N'2020-11-26' AS Date), 331.5, N'TESTCODE', 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'258cff39-dd5e-4b4e-bc43-d9fec21c9223', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T14:44:38.100' AS DateTime), CAST(N'2020-11-14' AS Date), CAST(N'2020-11-27' AS Date), 530, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'2341cd81-cf12-4c6d-bc84-dfbaeec05545', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-02T18:47:41.873' AS DateTime), CAST(N'2020-11-11' AS Date), CAST(N'2020-11-12' AS Date), 130, NULL, 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'62bf7bab-00ba-4666-a579-ef4749b7aab8', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T16:30:51.520' AS DateTime), CAST(N'2020-11-04' AS Date), CAST(N'2020-11-28' AS Date), 650, N'TESTCODE', 1)
INSERT [dbo].[tblBooking] ([BookingID], [UserID], [Booking Date], [CheckIn Date], [CheckOut Date], [Total], [Code], [Status]) VALUES (N'1d708f83-5595-4af7-be5c-f2d9bb8148ab', N'longttse140019@fpt.edu.vn', CAST(N'2020-11-01T16:22:43.337' AS DateTime), CAST(N'2020-11-18' AS Date), CAST(N'2020-11-27' AS Date), 331.5, N'TESTCODE', 1)
SET IDENTITY_INSERT [dbo].[tblBookingDetail] ON 

INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (1, N'd4b80945-f79b-4f4a-a091-04c69532841e', 1, 3, 150)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (2, N'832c4308-719e-4dc2-94d1-616ca5de04de', 1, 8, 400)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (3, N'832c4308-719e-4dc2-94d1-616ca5de04de', 2, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (4, N'4a156748-7c94-4a34-94e6-839e927e8ffd', 4, 6, 240)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (5, N'4a156748-7c94-4a34-94e6-839e927e8ffd', 6, 3, 270)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (6, N'86141d39-542f-4667-8d7d-5d9a76966678', 7, 3, 165)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (7, N'86141d39-542f-4667-8d7d-5d9a76966678', 8, 2, 150)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (8, N'a8ae8dc0-c9bc-48e6-b8d9-b23af7d33e93', 2, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (9, N'a8ae8dc0-c9bc-48e6-b8d9-b23af7d33e93', 3, 2, 200)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (10, N'e900e90d-5b7c-4b08-80e9-494b29e22966', 1, 1, 50)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (11, N'e900e90d-5b7c-4b08-80e9-494b29e22966', 2, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (12, N'e900e90d-5b7c-4b08-80e9-494b29e22966', 3, 1, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (13, N'0df1d016-805a-4ddf-9650-1e621daea3e4', 11, 1, 65)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (14, N'0df1d016-805a-4ddf-9650-1e621daea3e4', 12, 10, 950)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (15, N'258cff39-dd5e-4b4e-bc43-d9fec21c9223', 2, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (16, N'258cff39-dd5e-4b4e-bc43-d9fec21c9223', 3, 2, 200)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (17, N'258cff39-dd5e-4b4e-bc43-d9fec21c9223', 5, 1, 60)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (18, N'258cff39-dd5e-4b4e-bc43-d9fec21c9223', 12, 2, 190)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (19, N'e4fb0e8f-bd76-4f21-b3fe-2e1548f2c6ec', 1, 1, 50)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (20, N'e4fb0e8f-bd76-4f21-b3fe-2e1548f2c6ec', 2, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (21, N'e4fb0e8f-bd76-4f21-b3fe-2e1548f2c6ec', 3, 1, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (22, N'441f0238-addc-485b-999d-437a2a1e876a', 1, 3, 150)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (23, N'441f0238-addc-485b-999d-437a2a1e876a', 2, 3, 240)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (24, N'441f0238-addc-485b-999d-437a2a1e876a', 3, 2, 200)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (25, N'2c4d2909-ec7e-4bab-b197-c0d8179be720', 1, 3, 150)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (26, N'2c4d2909-ec7e-4bab-b197-c0d8179be720', 2, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (27, N'2c4d2909-ec7e-4bab-b197-c0d8179be720', 3, 2, 200)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (28, N'1d708f83-5595-4af7-be5c-f2d9bb8148ab', 4, 1, 40)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (29, N'1d708f83-5595-4af7-be5c-f2d9bb8148ab', 5, 1, 60)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (30, N'1d708f83-5595-4af7-be5c-f2d9bb8148ab', 6, 1, 90)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (31, N'1d708f83-5595-4af7-be5c-f2d9bb8148ab', 9, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (32, N'1d708f83-5595-4af7-be5c-f2d9bb8148ab', 10, 2, 240)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (33, N'3493b67b-cfcf-4ccc-8cd0-3676ae940f26', 4, 1, 40)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (34, N'3493b67b-cfcf-4ccc-8cd0-3676ae940f26', 5, 1, 60)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (35, N'3493b67b-cfcf-4ccc-8cd0-3676ae940f26', 7, 4, 220)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (36, N'3493b67b-cfcf-4ccc-8cd0-3676ae940f26', 8, 2, 150)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (37, N'3493b67b-cfcf-4ccc-8cd0-3676ae940f26', 11, 3, 195)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (38, N'3493b67b-cfcf-4ccc-8cd0-3676ae940f26', 12, 3, 285)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (39, N'62bf7bab-00ba-4666-a579-ef4749b7aab8', 1, 2, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (40, N'62bf7bab-00ba-4666-a579-ef4749b7aab8', 2, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (41, N'62bf7bab-00ba-4666-a579-ef4749b7aab8', 7, 5, 275)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (42, N'62bf7bab-00ba-4666-a579-ef4749b7aab8', 8, 3, 225)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (43, N'62bf7bab-00ba-4666-a579-ef4749b7aab8', 9, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (44, N'62bf7bab-00ba-4666-a579-ef4749b7aab8', 10, 2, 240)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (45, N'467b0097-074d-4828-bddc-47561f8ca40c', 7, 2, 110)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (46, N'467b0097-074d-4828-bddc-47561f8ca40c', 8, 5, 375)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (47, N'8bae4fef-0e63-4f9f-816c-9764bd2f758f', 4, 1, 40)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (48, N'8bae4fef-0e63-4f9f-816c-9764bd2f758f', 5, 2, 120)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (49, N'8bae4fef-0e63-4f9f-816c-9764bd2f758f', 6, 1, 90)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (50, N'8bae4fef-0e63-4f9f-816c-9764bd2f758f', 8, 4, 300)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (51, N'8bae4fef-0e63-4f9f-816c-9764bd2f758f', 9, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (52, N'8bae4fef-0e63-4f9f-816c-9764bd2f758f', 10, 1, 120)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (53, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 7, 3, 165)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (54, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 8, 2, 150)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (55, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 9, 6, 480)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (56, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 11, 3, 195)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (57, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 12, 2, 190)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (58, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 13, 2, 140)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (59, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 14, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (60, N'a8821e2c-ca46-4db9-935e-9f9988096ad8', 15, 3, 270)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (63, N'1a4665bb-198d-4fb4-be03-4c33e2d08fc3', 4, 2, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (64, N'1a4665bb-198d-4fb4-be03-4c33e2d08fc3', 5, 1, 60)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (65, N'1a4665bb-198d-4fb4-be03-4c33e2d08fc3', 6, 1, 90)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (66, N'1a4665bb-198d-4fb4-be03-4c33e2d08fc3', 13, 2, 140)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (67, N'1a4665bb-198d-4fb4-be03-4c33e2d08fc3', 14, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (68, N'093aeb16-8194-4e26-b4c0-362279752412', 1, 1, 50)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (69, N'093aeb16-8194-4e26-b4c0-362279752412', 2, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (70, N'093aeb16-8194-4e26-b4c0-362279752412', 3, 1, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (71, N'bbe20805-7f21-452f-add9-8d7bb74d43ba', 1, 2, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (72, N'bbe20805-7f21-452f-add9-8d7bb74d43ba', 2, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (73, N'bbe20805-7f21-452f-add9-8d7bb74d43ba', 3, 1, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (74, N'bbe20805-7f21-452f-add9-8d7bb74d43ba', 8, 3, 225)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (75, N'b8ad43fe-38f3-4535-a182-a0f911b990f1', 13, 1, 70)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (76, N'b8ad43fe-38f3-4535-a182-a0f911b990f1', 14, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (77, N'b8ad43fe-38f3-4535-a182-a0f911b990f1', 15, 1, 90)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (78, N'4434aa31-16f8-462e-9d9b-4b903ef91231', 8, 7, 525)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (79, N'ff0f58ee-1005-4713-9545-92a36fa536d7', 14, 3, 240)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (80, N'23bb2356-a232-49d9-9991-15dcd9c3726c', 14, 6, 480)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (81, N'd3f8b0d0-505c-4d3e-88fa-66f2d5d9e8db', 1, 1, 50)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (82, N'd3f8b0d0-505c-4d3e-88fa-66f2d5d9e8db', 2, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (83, N'd3f8b0d0-505c-4d3e-88fa-66f2d5d9e8db', 3, 1, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (84, N'9db38623-f1b3-479c-a49d-990d03e2ac1d', 1, 1, 50)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (85, N'9db38623-f1b3-479c-a49d-990d03e2ac1d', 2, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (86, N'2341cd81-cf12-4c6d-bc84-dfbaeec05545', 1, 1, 50)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (87, N'2341cd81-cf12-4c6d-bc84-dfbaeec05545', 2, 1, 80)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (88, N'b0fe8ec0-b4fe-4440-9082-945ca5a3192e', 12, 1, 95)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (89, N'b0fe8ec0-b4fe-4440-9082-945ca5a3192e', 14, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (90, N'8680a491-39e2-4256-9b19-8855a723ea3e', 12, 2, 190)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (91, N'379b1571-f1cb-4d49-9447-8827c6e8a23c', 2, 4, 320)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (92, N'379b1571-f1cb-4d49-9447-8827c6e8a23c', 8, 1, 75)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (93, N'379b1571-f1cb-4d49-9447-8827c6e8a23c', 12, 2, 190)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (94, N'379b1571-f1cb-4d49-9447-8827c6e8a23c', 13, 2, 140)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (95, N'379b1571-f1cb-4d49-9447-8827c6e8a23c', 14, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (96, N'379b1571-f1cb-4d49-9447-8827c6e8a23c', 15, 1, 90)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (97, N'571e1165-714a-442b-9118-0829e05a9215', 2, 2, 160)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (98, N'571e1165-714a-442b-9118-0829e05a9215', 3, 1, 100)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (99, N'571e1165-714a-442b-9118-0829e05a9215', 7, 2, 110)
INSERT [dbo].[tblBookingDetail] ([BookingDetailID], [BookingID], [RoomID], [Quantity], [Total]) VALUES (100, N'571e1165-714a-442b-9118-0829e05a9215', 8, 1, 75)
SET IDENTITY_INSERT [dbo].[tblBookingDetail] OFF
GO
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'CHUCMUNGNAMMOI', N'New Year Discount Code', 15, CAST(N'2020-11-01T11:29:30.147' AS DateTime), CAST(N'2020-11-30' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT001', N'Discount 10%', 10, CAST(N'2020-11-02T07:08:49.183' AS DateTime), CAST(N'2020-12-10' AS Date), 0)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT01', N'Discount 10%', 10, CAST(N'2020-11-01T12:01:39.383' AS DateTime), CAST(N'2020-12-01' AS Date), 0)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT02', N'Discount 20%', 20, CAST(N'2020-11-01T12:57:53.993' AS DateTime), CAST(N'2020-12-12' AS Date), 0)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT03', N'Discount 30%', 30, CAST(N'2020-11-01T21:14:00.683' AS DateTime), CAST(N'2020-12-05' AS Date), 0)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT04', N'Discount 40%', 40, CAST(N'2020-11-01T21:14:08.530' AS DateTime), CAST(N'2020-12-05' AS Date), 0)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT05', N'Discount 50%', 50, CAST(N'2020-11-01T21:47:15.380' AS DateTime), CAST(N'2020-12-11' AS Date), 0)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT06', N'Discount 60%', 60, CAST(N'2020-11-01T21:47:21.437' AS DateTime), CAST(N'2020-12-11' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT10', N'Discount 10%', 10, CAST(N'2020-11-02T21:11:03.793' AS DateTime), CAST(N'2020-12-12' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT11', N'Discount 10%', 10, CAST(N'2020-11-02T21:11:08.810' AS DateTime), CAST(N'2020-12-12' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT12', N'Discount 10%', 10, CAST(N'2020-11-02T21:11:10.660' AS DateTime), CAST(N'2020-12-12' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'DISCOUNT13', N'Discount 10%', 10, CAST(N'2020-11-02T21:11:12.537' AS DateTime), CAST(N'2020-12-12' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'EXPIREDCODE', N'Expired Code Test', 69, CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-10-30' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'ONEYEARANNIVERSARY', N'1 Year Anni Discount Code', 20, CAST(N'2020-11-01T11:34:29.030' AS DateTime), CAST(N'2020-12-25' AS Date), 1)
INSERT [dbo].[tblCode] ([CodeID], [Name], [Discount Percent], [Create Date], [Expire Date], [Status]) VALUES (N'TESTCODE', N'Code Used for Testing', 35, CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-11' AS Date), 0)
SET IDENTITY_INSERT [dbo].[tblFeedback] ON 

INSERT [dbo].[tblFeedback] ([FeedbackID], [UserID], [RoomID], [Rating], [Comment]) VALUES (1, N'longttse140019@fpt.edu.vn', 2, 3, N'')
INSERT [dbo].[tblFeedback] ([FeedbackID], [UserID], [RoomID], [Rating], [Comment]) VALUES (3, N'longttse140019@fpt.edu.vn', 3, 4, N'nice')
INSERT [dbo].[tblFeedback] ([FeedbackID], [UserID], [RoomID], [Rating], [Comment]) VALUES (4, N'longttse140019@fpt.edu.vn', 1, 0.5, N'bathroom broke')
SET IDENTITY_INSERT [dbo].[tblFeedback] OFF
SET IDENTITY_INSERT [dbo].[tblHotel] ON 

INSERT [dbo].[tblHotel] ([HotelID], [Name], [Area], [Image], [Status]) VALUES (1, N'Mi Hotel', 1, N'images\hotel1.png', 1)
INSERT [dbo].[tblHotel] ([HotelID], [Name], [Area], [Image], [Status]) VALUES (2, N'Cloud Hotel', 1, N'images\hotel2.png', 1)
INSERT [dbo].[tblHotel] ([HotelID], [Name], [Area], [Image], [Status]) VALUES (3, N'Deux Hotel', 2, N'images\hotel3.png', 1)
INSERT [dbo].[tblHotel] ([HotelID], [Name], [Area], [Image], [Status]) VALUES (4, N'Royal Hotel', 2, N'images\hotel1.png', 1)
INSERT [dbo].[tblHotel] ([HotelID], [Name], [Area], [Image], [Status]) VALUES (5, N'Blue Hotel', 3, N'images\hotel2.png', 1)
INSERT [dbo].[tblHotel] ([HotelID], [Name], [Area], [Image], [Status]) VALUES (6, N'Seaside Hotel', 3, N'images\hotel3.png', 1)
SET IDENTITY_INSERT [dbo].[tblHotel] OFF
SET IDENTITY_INSERT [dbo].[tblRole] ON 

INSERT [dbo].[tblRole] ([RoleID], [Name]) VALUES (1, N'User')
INSERT [dbo].[tblRole] ([RoleID], [Name]) VALUES (2, N'Admin')
SET IDENTITY_INSERT [dbo].[tblRole] OFF
SET IDENTITY_INSERT [dbo].[tblRoom] ON 

INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (1, 1, 1, 50, 50, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (2, 1, 2, 80, 40, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (3, 1, 3, 100, 30, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (4, 2, 1, 40, 40, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (5, 2, 2, 60, 30, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (6, 2, 3, 90, 20, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (7, 3, 1, 55, 60, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (8, 3, 2, 75, 60, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (9, 4, 1, 80, 40, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (10, 4, 3, 120, 40, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (11, 5, 1, 65, 70, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (12, 5, 2, 95, 50, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (13, 6, 1, 70, 45, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (14, 6, 2, 80, 55, 1)
INSERT [dbo].[tblRoom] ([RoomID], [HotelID], [Type], [Price], [Quantity], [Status]) VALUES (15, 6, 3, 90, 40, 1)
SET IDENTITY_INSERT [dbo].[tblRoom] OFF
SET IDENTITY_INSERT [dbo].[tblRoomType] ON 

INSERT [dbo].[tblRoomType] ([RoomTypeID], [Name]) VALUES (1, N'Single')
INSERT [dbo].[tblRoomType] ([RoomTypeID], [Name]) VALUES (2, N'Double')
INSERT [dbo].[tblRoomType] ([RoomTypeID], [Name]) VALUES (3, N'Family')
SET IDENTITY_INSERT [dbo].[tblRoomType] OFF
SET IDENTITY_INSERT [dbo].[tblStatus] ON 

INSERT [dbo].[tblStatus] ([StatusID], [Name]) VALUES (-1, N'Deactive')
INSERT [dbo].[tblStatus] ([StatusID], [Name]) VALUES (0, N'Pending')
INSERT [dbo].[tblStatus] ([StatusID], [Name]) VALUES (1, N'Active')
SET IDENTITY_INSERT [dbo].[tblStatus] OFF
INSERT [dbo].[tblUser] ([UserID], [Password], [Name], [Phone], [Address], [Create Date], [Role], [Status]) VALUES (N'admin@gmail.com', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'Admin Long', N'0900900901', N'Viet Cong', CAST(N'2020-10-22T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[tblUser] ([UserID], [Password], [Name], [Phone], [Address], [Create Date], [Role], [Status]) VALUES (N'longttse140019@fpt.edu.vn', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Longg', N'0906649576', N'Viet Nam', CAST(N'2020-10-30T23:19:09.807' AS DateTime), 1, 1)
INSERT [dbo].[tblUser] ([UserID], [Password], [Name], [Phone], [Address], [Create Date], [Role], [Status]) VALUES (N'member@gmail.com', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'Tran Long', N'0901234567', N'Viet Nam', CAST(N'2020-10-23T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[tblUser] ([UserID], [Password], [Name], [Phone], [Address], [Create Date], [Role], [Status]) VALUES (N'verylong0908@gmail.com', N'5843b1fffa336fe8fd6296833b6ab86d0fd9c194779f9af807c70803d273ac65', N'Mappa Mare', N'0901234567', N'California', CAST(N'2020-11-02T21:02:30.903' AS DateTime), 1, 1)
INSERT [dbo].[tblUser] ([UserID], [Password], [Name], [Phone], [Address], [Create Date], [Role], [Status]) VALUES (N'verylong09082@gmail.com', N'5843b1fffa336fe8fd6296833b6ab86d0fd9c194779f9af807c70803d273ac65', N'Watermelon', N'0906649577', N'Viet Nam', CAST(N'2020-11-01T21:27:43.697' AS DateTime), 1, 1)
ALTER TABLE [dbo].[tblBooking]  WITH CHECK ADD  CONSTRAINT [FK_tblBooking_tblCode] FOREIGN KEY([Code])
REFERENCES [dbo].[tblCode] ([CodeID])
GO
ALTER TABLE [dbo].[tblBooking] CHECK CONSTRAINT [FK_tblBooking_tblCode]
GO
ALTER TABLE [dbo].[tblBooking]  WITH CHECK ADD  CONSTRAINT [FK_tblBooking_tblStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[tblStatus] ([StatusID])
GO
ALTER TABLE [dbo].[tblBooking] CHECK CONSTRAINT [FK_tblBooking_tblStatus]
GO
ALTER TABLE [dbo].[tblBooking]  WITH CHECK ADD  CONSTRAINT [FK_tblBooking_tblUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUser] ([UserID])
GO
ALTER TABLE [dbo].[tblBooking] CHECK CONSTRAINT [FK_tblBooking_tblUser]
GO
ALTER TABLE [dbo].[tblBookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblBookingDetail_tblBooking] FOREIGN KEY([BookingID])
REFERENCES [dbo].[tblBooking] ([BookingID])
GO
ALTER TABLE [dbo].[tblBookingDetail] CHECK CONSTRAINT [FK_tblBookingDetail_tblBooking]
GO
ALTER TABLE [dbo].[tblBookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblBookingDetail_tblRoom] FOREIGN KEY([RoomID])
REFERENCES [dbo].[tblRoom] ([RoomID])
GO
ALTER TABLE [dbo].[tblBookingDetail] CHECK CONSTRAINT [FK_tblBookingDetail_tblRoom]
GO
ALTER TABLE [dbo].[tblCode]  WITH CHECK ADD  CONSTRAINT [FK_tblCode_tblStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[tblStatus] ([StatusID])
GO
ALTER TABLE [dbo].[tblCode] CHECK CONSTRAINT [FK_tblCode_tblStatus]
GO
ALTER TABLE [dbo].[tblFeedback]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedback_tblRoom] FOREIGN KEY([RoomID])
REFERENCES [dbo].[tblRoom] ([RoomID])
GO
ALTER TABLE [dbo].[tblFeedback] CHECK CONSTRAINT [FK_tblFeedback_tblRoom]
GO
ALTER TABLE [dbo].[tblFeedback]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedback_tblUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUser] ([UserID])
GO
ALTER TABLE [dbo].[tblFeedback] CHECK CONSTRAINT [FK_tblFeedback_tblUser]
GO
ALTER TABLE [dbo].[tblHotel]  WITH CHECK ADD  CONSTRAINT [FK_tblHotel_tblArea] FOREIGN KEY([Area])
REFERENCES [dbo].[tblArea] ([AreaID])
GO
ALTER TABLE [dbo].[tblHotel] CHECK CONSTRAINT [FK_tblHotel_tblArea]
GO
ALTER TABLE [dbo].[tblHotel]  WITH CHECK ADD  CONSTRAINT [FK_tblHotel_tblStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[tblStatus] ([StatusID])
GO
ALTER TABLE [dbo].[tblHotel] CHECK CONSTRAINT [FK_tblHotel_tblStatus]
GO
ALTER TABLE [dbo].[tblRoom]  WITH CHECK ADD  CONSTRAINT [FK_tblRoom_tblHotel] FOREIGN KEY([HotelID])
REFERENCES [dbo].[tblHotel] ([HotelID])
GO
ALTER TABLE [dbo].[tblRoom] CHECK CONSTRAINT [FK_tblRoom_tblHotel]
GO
ALTER TABLE [dbo].[tblRoom]  WITH CHECK ADD  CONSTRAINT [FK_tblRoom_tblRoomType] FOREIGN KEY([Type])
REFERENCES [dbo].[tblRoomType] ([RoomTypeID])
GO
ALTER TABLE [dbo].[tblRoom] CHECK CONSTRAINT [FK_tblRoom_tblRoomType]
GO
ALTER TABLE [dbo].[tblRoom]  WITH CHECK ADD  CONSTRAINT [FK_tblRoom_tblStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[tblStatus] ([StatusID])
GO
ALTER TABLE [dbo].[tblRoom] CHECK CONSTRAINT [FK_tblRoom_tblStatus]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblRole] FOREIGN KEY([Role])
REFERENCES [dbo].[tblRole] ([RoleID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblRole]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[tblStatus] ([StatusID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblStatus]
GO
USE [master]
GO
ALTER DATABASE [HotelDB] SET  READ_WRITE 
GO
