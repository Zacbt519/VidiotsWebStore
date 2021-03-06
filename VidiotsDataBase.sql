USE [master]
GO
/****** Object:  Database [Vidiots]    Script Date: 22/10/2018 14:50:18 ******/
CREATE DATABASE [Vidiots]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Vidiots', FILENAME = N'D:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\Vidiots.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Vidiots_log', FILENAME = N'D:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\Vidiots_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Vidiots] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Vidiots].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Vidiots] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Vidiots] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Vidiots] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Vidiots] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Vidiots] SET ARITHABORT OFF 
GO
ALTER DATABASE [Vidiots] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Vidiots] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Vidiots] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Vidiots] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Vidiots] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Vidiots] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Vidiots] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Vidiots] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Vidiots] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Vidiots] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Vidiots] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Vidiots] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Vidiots] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Vidiots] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Vidiots] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Vidiots] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Vidiots] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Vidiots] SET RECOVERY FULL 
GO
ALTER DATABASE [Vidiots] SET  MULTI_USER 
GO
ALTER DATABASE [Vidiots] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Vidiots] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Vidiots] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Vidiots] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Vidiots] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Vidiots', N'ON'
GO
ALTER DATABASE [Vidiots] SET QUERY_STORE = OFF
GO
USE [Vidiots]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Vidiots]
GO
/****** Object:  FullTextCatalog [Customer]    Script Date: 22/10/2018 14:50:18 ******/
CREATE FULLTEXT CATALOG [Customer] WITH ACCENT_SENSITIVITY = ON
GO
/****** Object:  FullTextCatalog [test]    Script Date: 22/10/2018 14:50:18 ******/
CREATE FULLTEXT CATALOG [test] WITH ACCENT_SENSITIVITY = ON
GO
/****** Object:  Table [dbo].[Address]    Script Date: 22/10/2018 14:50:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[Street] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Province] [char](2) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[PostalCode] [char](6) NOT NULL,
	[CustomerID] [smallint] NOT NULL,
	[AddressType] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [nchar](10) NOT NULL,
	[AdminLogin] [varchar](15) NOT NULL,
	[AdminPassword] [varchar](25) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [smallint] IDENTITY(1,1) NOT NULL,
	[CustomerID] [smallint] NULL,
	[DateCreated] [date] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[CartItemID] [smallint] IDENTITY(1,1) NOT NULL,
	[ProductID] [smallint] NOT NULL,
	[CartID] [smallint] NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_CartItems] PRIMARY KEY CLUSTERED 
(
	[CartItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](15) NOT NULL,
	[Description] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [smallint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[MiddleInitial] [char](2) NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[UserPassword] [nvarchar](20) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[PhoneNumber] [char](10) NOT NULL,
	[EmailAddress] [nvarchar](30) NOT NULL,
	[IsVerified] [bit] NOT NULL,
	[IsArchived] [bit] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[ImageID] [int] NOT NULL,
	[ImageURL] [varchar](50) NOT NULL,
	[AltText] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [smallint] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[BriefDescription] [varchar](200) NOT NULL,
	[FullDescription] [varchar](max) NOT NULL,
	[Price] [float] NOT NULL,
	[ImageID] [int] NOT NULL,
	[Featured] [bit] NOT NULL,
	[ProductStatus] [smallint] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductStatus]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStatus](
	[StatusID] [smallint] IDENTITY(1,1) NOT NULL,
	[StatusDescription] [varchar](30) NOT NULL,
 CONSTRAINT [PK_ProductStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[TypeID] [tinyint] NOT NULL,
	[Name] [varchar](15) NOT NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (6, N'1234 Mountain Road', N'Moncton', N'NB', N'Canada', N'E1B3Z6', 1, N'Billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (7, N'7 Inverness cres', N'Riverview', N'NB', N'Canada', N'E1B 3Z', 2, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (8, N'jhvujhv juh', N'jhvjhv', N'jh', N'jhgvjghvj', N'ughvjg', 3, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (9, N'ijbihjb', N'ijbijb', N'ij', N'oijnbijbn', N'ijbij ', 4, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (10, N'ihvihvb', N'ijbib', N'ki', N'iubiub', N'ijbiub', 5, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (13, N'ihvihvb', N'ijbib', N'ki', N'iubiub', N'ijbiub', 8, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (14, N'ihbihb', N'ibi', N'iu', N'iiub', N'iub   ', 9, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (18, N'7 Inverness cres', N'Riverview', N'NB', N'Canada', N'E1B 3Z', 13, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (19, N'jnijno', N'ojknoik', N'oi', N'okinokjno', N'okinok', 14, N'billing')
INSERT [dbo].[Address] ([AddressID], [Street], [City], [Province], [Country], [PostalCode], [CustomerID], [AddressType]) VALUES (20, N'piojpoinmpo', N'oiknoikn', N'oi', N'oino', N'oikno ', 15, N'billing')
SET IDENTITY_INSERT [dbo].[Address] OFF
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (1, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (2, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (3, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (4, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (5, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (6, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (7, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (8, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (9, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (10, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (11, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (12, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (13, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (14, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (15, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (16, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (17, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (18, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (19, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (20, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (21, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (22, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (23, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (24, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (25, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (26, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (27, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (28, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (29, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (30, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (31, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (32, NULL, CAST(N'2018-10-18' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (33, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (34, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (35, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (36, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (37, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (38, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (39, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (40, NULL, CAST(N'2018-10-19' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (41, NULL, CAST(N'2018-10-22' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (42, NULL, CAST(N'2018-10-22' AS Date))
INSERT [dbo].[Cart] ([CartID], [CustomerID], [DateCreated]) VALUES (43, NULL, CAST(N'2018-10-22' AS Date))
SET IDENTITY_INSERT [dbo].[Cart] OFF
SET IDENTITY_INSERT [dbo].[CartItems] ON 

INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (1, 4, 4, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (2, 4, 5, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (3, 7, 6, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (4, 10, 7, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (5, 10, 8, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (6, 11, 9, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (7, 7, 10, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (8, 7, 11, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (9, 7, 12, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (10, 7, 13, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (11, 4, 14, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (12, 4, 15, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (13, 7, 16, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (14, 7, 17, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (15, 9, 18, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (16, 9, 19, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (24, 10, 20, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (25, 10, 21, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (26, 11, 22, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (27, 4, 23, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (28, 4, 24, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (29, 4, 25, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (30, 4, 26, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (31, 7, 27, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (32, 4, 28, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (33, 4, 29, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (34, 4, 30, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (35, 4, 31, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (36, 4, 32, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (37, 4, 34, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (38, 4, 35, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (39, 7, 36, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (40, 7, 37, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (41, 7, 38, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (42, 9, 39, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (43, 9, 40, 1)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (44, 4, 40, 4)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (45, 7, 40, 4)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (46, 10, 40, 2)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (47, 11, 40, 2)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (48, 4, 41, 7)
INSERT [dbo].[CartItems] ([CartItemID], [ProductID], [CartID], [Quantity]) VALUES (49, 7, 41, 8)
SET IDENTITY_INSERT [dbo].[CartItems] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (1, N'Action', N'Films ')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (2, N'Adventure', N'Films with quests, exploration, and overcoming an adversary')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (3, N'Comedy', N'This will make you laugh')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (4, N'Horror', N'Films that will scare you')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (5, N'Documentaries', N'Films that will make you learn')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (6, N'Office', N'Software used for work in the Office')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (7, N'Programming', N'Software used for developping applications')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (8, N'Graphic Design', N'Software used for art and graphic design')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (1, N'Bichael', N'J ', N'Smith', N'BSmith', N'password', CAST(N'2018-09-12' AS Date), N'3860187   ', N'ihbiubuibiuy', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (2, N'Zach', N'  ', N'Beatty-Taylor', N'jhb', N'jhb', CAST(N'1111-11-11' AS Date), N'5063860187', N'zacbeattytaylor@hotmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (3, N'iuvihbv', N'h ', N'ibij', N'ijhbi', N'hjh', CAST(N'1111-11-11' AS Date), N'jhvjhvjhbv', N'jhvihv@juhvhv.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (4, N'ijbijob', N'ki', N'kjboijbn', N'ojbojbn', N'jbo', CAST(N'1111-11-11' AS Date), N'jnojnb    ', N'ijbi@ijbijb.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (5, N'iugiu', N'iu', N'iubiu', N'iuhiu', N'p', CAST(N'1995-11-11' AS Date), N'ijbijb    ', N'ijbiu@iuhbibv.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (6, N'iugiu', N'iu', N'iubiu', N'iuhiu', N'p', CAST(N'1995-11-11' AS Date), N'ijbijb    ', N'jeremy.e.lirette@gmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (7, N'iugiu', N'iu', N'iubiu', N'iuhiu', N'p', CAST(N'1995-11-11' AS Date), N'ijbijb    ', N'jeremy.e.lirette@gmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (8, N'bafbab', N'iu', N'iubiu', N'iuhiu', N'p', CAST(N'1995-11-11' AS Date), N'ijbijb    ', N'jeremy.e.lirette@gmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (9, N'test', N't ', N'test', N'tst', N'tst', CAST(N'2000-11-11' AS Date), N'ibibi     ', N'zacbeattytaylor@hotmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (10, N'test', N't ', N'test', N'tst', N'tst', CAST(N'2000-11-11' AS Date), N'ibibi     ', N'zacbeattytaylor@hotmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (11, N'test', N't ', N'test', N'tst', N'tst', CAST(N'2000-11-11' AS Date), N'ibibi     ', N'zacbeattytaylor@hotmail.com', 1, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (12, N'Zach', N'  ', N'Beatty-Taylor', N'tstl', N'tst', CAST(N'1997-09-15' AS Date), N'5063860187', N'zacbeattytaylor@gmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (13, N'mike', N'  ', N'Beatty-Taylor', N'tstl', N'tst', CAST(N'1997-09-15' AS Date), N'5063860187', N'zacbeattytaylor@gmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (14, N'willi', N'w ', N'kjnkj', N'hj', N'hj', CAST(N'2003-02-12' AS Date), N'okinoino  ', N'zacbeattytaylor@hotmail.com', 0, 0)
INSERT [dbo].[Customer] ([CustomerID], [FirstName], [MiddleInitial], [LastName], [UserName], [UserPassword], [DateOfBirth], [PhoneNumber], [EmailAddress], [IsVerified], [IsArchived]) VALUES (15, N'tim', N't ', N'ono', N'oiuniou', N'pop', CAST(N'1964-09-27' AS Date), N'oino      ', N'zacbeattytaylor@hotmail.com', 0, 0)
SET IDENTITY_INSERT [dbo].[Customer] OFF
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (1, N'~/img/300px-VHS-Video-Tape-Top-Flat.jpg', N'Deafult')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (2, N'~/img/StarWarsChristmasSpecial', N'Star Wars')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (3, N'~/img/HappyGilmore.jpg', N'Happy Gilmore')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (4, N'~/img/Airbender.jpg', N'Airbender')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (5, N'~/img/MandatoryFun.jpg', N'MandatoryFun')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (6, N'~/img/DareToBeStupid.jpg', N'Stupid')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (7, N'~/img/EvenWorse.jpg', N'Even Worse')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (8, N'~/img/Word.png', N'MS Word')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (9, N'~/img/NetBeans.png', N'NetBeans')
INSERT [dbo].[Images] ([ImageID], [ImageURL], [AltText]) VALUES (10, N'~/img/PhotoShop.png', N'Photoshop')
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [BriefDescription], [FullDescription], [Price], [ImageID], [Featured], [ProductStatus], [CategoryID], [Type]) VALUES (4, N'Avatar: The Last Airbender2', N'Follows the adventures of Aang, a young successor to a long line of Avatars, who must master all four elements and stop the Fire Nation from enslaving the Water Tribes and the Earth Kingdom.', N'The world is divided into four kingdoms, each represented by the element they harness, and peace has lasted throughout the realms of Water, Air, Earth, and Fire under the supervision of the Avatar, a link to the spirit world and the only being capable of mastering the use of all four elements. When young Avatar Aang disappears, the Fire Nation launches an attack to eradicate all members of the Air Nomads to prevent interference in their future plans for world domination. 100 years pass and current Fire Lord Ozai continues to conquer and imprison anyone with elemental "bending" abilities in the Earth and Water Kingdoms, while siblings Katara and Sokka from a Southern Water Tribe find a mysterious boy trapped beneath the ice outside their village. Upon rescuing him, he reveals himself to be Aang, Avatar and last of the Air Nomads. Swearing to protect the Avatar, Katara and Sokka journey with him to the Northern Water Kingdom in his quest to master "Waterbending" and eventually fulfill his destiny of once again restoring peace to the world. But as they inch nearer to their goal, the group must evade Prince Zuko, the exiled son of Lord Ozai, Commander Zhao, the Fire Nation''s military leader, and the tyrannical onslaught of the evil Fire Lord himself.', 1, 1, 1, 1, 2, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [BriefDescription], [FullDescription], [Price], [ImageID], [Featured], [ProductStatus], [CategoryID], [Type]) VALUES (7, N'Even Worse', N'Even Worse is the fifth studio album by "Weird Al" Yankovic, released on April 12, 1988. The album was produced by former The McCoys guitarist Rick Derringer. ', N'The music on Even Worse is built around parodies and pastiches of pop and rock music of the mid-1980s. Half of the album is made up of parodies, featuring jabs at Michael Jackson, George Harrison, Tiffany, Los Lobos''s version of the folk song "La Bamba", and Billy Idol. The other half is original material, featuring several "style parodies" or musical imitations that emulate existing artists. These style parodies include imitations of specific artists such as Oingo Boingo, Beastie Boys, and James Taylor. Even Worse has the distinction of being one of two albums by Yankovic lacking any polka renditions of pop songs or medleys, the other being his debut album "Weird Al" Yankovic (1983). This album''s title and cover art are spoofs of Michael Jackson''s 1987 album Bad.', 900, 7, 1, 1, 3, 2)
INSERT [dbo].[Product] ([ProductID], [ProductName], [BriefDescription], [FullDescription], [Price], [ImageID], [Featured], [ProductStatus], [CategoryID], [Type]) VALUES (8, N'Microsoft Word', N'Microsoft Word (or simply Word) is a word processor developed by Microsoft. ', N'It was first released on October 25, 1983[4] under the name Multi-Tool Word for Xenix systems.[5][6][7] Subsequent versions were later written for several other platforms including IBM PCs running DOS (1983), Apple Macintosh running the Classic Mac OS (1985), AT&T Unix PC (1985), Atari ST (1988), OS/2 (1989), Microsoft Windows (1989), SCO Unix (1994), and macOS (formerly OS X; 2001). Commercial versions of Word are licensed as a standalone product or as a component of Microsoft Office, Windows RT or the discontinued Microsoft Works suite. Microsoft Word Viewer and Office Online are freeware editions of Word with limited features.', 251, 1, 0, 1, 1, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [BriefDescription], [FullDescription], [Price], [ImageID], [Featured], [ProductStatus], [CategoryID], [Type]) VALUES (9, N'Net Beans', N'NetBeans is an integrated development environment (IDE) for Java.', N'NetBeans allows applications to be developed from a set of modular software components called modules. NetBeans runs on Microsoft Windows, macOS, Linux and Solaris. In addition to Java development, it has extensions for other languages like PHP, C, C++, HTML5, and Javascript. Applications based on NetBeans, including the NetBeans IDE, can be extended by third party developers.', 12, 9, 0, 1, 7, 3)
INSERT [dbo].[Product] ([ProductID], [ProductName], [BriefDescription], [FullDescription], [Price], [ImageID], [Featured], [ProductStatus], [CategoryID], [Type]) VALUES (10, N'Photoshop', N'Adobe Photoshop is a raster graphics editor developed and published by Adobe Systems for macOS and Windows.', N'Photoshop was created in 1988 by Thomas and John Knoll. Since then, it has become the de facto industry standard in raster graphics editing, to the point that Photoshop has become a generic trademark leading to its use as a verb such as "to Photoshop an image," "photoshopping" and "photoshop contest", though Adobe discourages such use.[5] It can edit and compose raster images in multiple layers and supports masks, alpha compositing and several color models including RGB, CMYK, CIELAB, spot color and duotone. Photoshop has vast support for graphic file formats but also uses its own PSD and PSB file formats which support all the aforementioned features. In addition to raster graphics, it has limited abilities to edit or render text, vector graphics (especially through clipping path), 3D graphics and video. Photoshop''s feature set can be expanded by Photoshop plug-ins, programs developed and distributed independently of Photoshop that can run inside it and offer new or enhanced features.', 450, 10, 1, 1, 8, 3)
INSERT [dbo].[Product] ([ProductID], [ProductName], [BriefDescription], [FullDescription], [Price], [ImageID], [Featured], [ProductStatus], [CategoryID], [Type]) VALUES (11, N'Star Wars', N'khgkgk', N'iugiukg', 12.99, 1, 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[ProductStatus] ON 

INSERT [dbo].[ProductStatus] ([StatusID], [StatusDescription]) VALUES (1, N'Available')
INSERT [dbo].[ProductStatus] ([StatusID], [StatusDescription]) VALUES (2, N'Out of Stock')
INSERT [dbo].[ProductStatus] ([StatusID], [StatusDescription]) VALUES (3, N'Back Ordered')
INSERT [dbo].[ProductStatus] ([StatusID], [StatusDescription]) VALUES (4, N'Temporarily Available')
INSERT [dbo].[ProductStatus] ([StatusID], [StatusDescription]) VALUES (5, N'Discontinued')
SET IDENTITY_INSERT [dbo].[ProductStatus] OFF
INSERT [dbo].[ProductType] ([TypeID], [Name]) VALUES (1, N'VHS')
INSERT [dbo].[ProductType] ([TypeID], [Name]) VALUES (2, N'Cassettes')
INSERT [dbo].[ProductType] ([TypeID], [Name]) VALUES (3, N'Floppy Disks')
ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Cart_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_IsVerified]  DEFAULT ((0)) FOR [IsVerified]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_IsArchived]  DEFAULT ((0)) FOR [IsArchived]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Cart] FOREIGN KEY([CartID])
REFERENCES [dbo].[Cart] ([CartID])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Cart]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Product1] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Product1]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Categories]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Images] FOREIGN KEY([ImageID])
REFERENCES [dbo].[Images] ([ImageID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Images]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductStatus] FOREIGN KEY([ProductStatus])
REFERENCES [dbo].[ProductStatus] ([StatusID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductStatus]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductType] FOREIGN KEY([Type])
REFERENCES [dbo].[ProductType] ([TypeID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductType]
GO
/****** Object:  StoredProcedure [dbo].[spAddItemToCart]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spAddItemToCart] @CartID smallint, @ProductID smallint, @Quantity int
AS
Begin
IF exists(Select * From CartItems Where ProductID = @ProductID AND CartID = @CartID)
Begin
Update CartItems Set Quantity = Quantity + 1 Where ProductID = @ProductID AND CartID = @CartID;

END
ElSE
Insert Into CartItems(ProductID, CartID, Quantity) Values(@ProductID, @CartID, @Quantity)
END
GO
/****** Object:  StoredProcedure [dbo].[spArchiveCustomer]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spArchiveCustomer] @CustomerID smallint
AS
BEGIN
    UPDATE
        Customer
    SET
        IsArchived = 1
    WHERE
        CustomerID = @CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[spConfirmAccount]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConfirmAccount] @CustomerID smallint
AS 
Update Customer
Set isVerified = 1
Where CustomerID = @CustomerID
GO
/****** Object:  StoredProcedure [dbo].[spCreateAccount]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCreateAccount] @FirstName nvarchar(20), @MiddleInitial char(2) = null, @LastName nvarchar(30), @UserName nvarchar(20), @UserPassword nvarchar(20), @DateOfBirth date, @Street nvarchar(20), @City nvarchar(20),@PostalCode nvarchar(10), @Province char(2), @Country nvarchar(20), @PhoneNumber char(10), @EmailAddress nvarchar(30), @CustomerID int OUTPUT
AS
BEGIN
    INSERT INTO
        Customer
    VALUES
        (@FirstName, @MiddleInitial, @LastName, @UserName, @UserPassword, @DateOfBirth,  @PhoneNumber, @EmailAddress)

    SET @CustomerID = (SELECT CustomerID FROM Customer WHERE FirstName = @FirstName)
    EXEC spCreateAddress @Street, @City, @Province, @Country, @PostalCode, @CustomerID, 'billing'
END
GO
/****** Object:  StoredProcedure [dbo].[spCreateAddress]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCreateAddress] @Street nvarchar(50), @City nvarchar(50), @Province char(2), @Country nvarchar(50), @PostalCode char(6), @CustomerID smallint, @AddressType nvarchar(10)
AS
BEGIN
    INSERT INTO    
        Address
    VALUES
        (@Street, @City, @Province, @Country, @PostalCode, @CustomerID, @AddressType)
END
GO
/****** Object:  StoredProcedure [dbo].[spCreateCart]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spCreateCart]
@CustomerID smallint null = null,
@CartID smallint Output
as
Begin
Insert into Cart Values( @CustomerID, GETDATE())
SET @CartID = @@IDENTITY
END 
GO
/****** Object:  StoredProcedure [dbo].[spCustomerSearch]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spCustomerSearch] @Term varchar(20)
AS
	Declare @TempTerm varchar(25)
	Set @TempTerm = '"*' + @Term + '*"'
    Select 
        (LastName + ', ' + FirstName) AS CustomerName, IsArchived  
    From 
        Customer 
    Where 
        CustomerID LIKE @Term OR Contains(*, @TempTerm)
GO
/****** Object:  StoredProcedure [dbo].[spDeleteCategory]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeleteCategory] @CategoryID int
AS
BEGIN TRY
	DELETE FROM Categories WHERE CategoryID = @CategoryID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spDeleteProduct]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteProduct] @ProductID smallint
AS
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM CartItems WHERE ProductID = @ProductID)
        DELETE FROM Product WHERE ProductID = @ProductID
    ELSE
        THROW 170000,'Item cannot be deleted as it is in 1 or more carts.',1
END TRY
BEGIN CATCH
    THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCategories]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllCategories]
AS
BEGIN TRY
	SELECT Name, Description, CategoryID FROM Categories
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCategoryID]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllCategoryID]
AS
BEGIN TRY
    Select CategoryID,Name From Categories
END TRY
BEGIN CATCH
    Throw
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCustomers]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetAllCustomers]
AS
BEGIN
    SELECT
        (LastName + ', ' + FirstName) AS CustomerName, IsArchived 
    FROM 
        Customer 
    WHERE
        IsArchived = 0
    ORDER BY 
        LastName

END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllProductInfoByID]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllProductInfoByID] @ID smallint
AS
BEGIN TRY
	SELECT ProductName, BriefDescription, FullDescription, Price, Product.ImageID, ImageURL, AltText, Featured, ProductStatus, CategoryID, Type  FROM Product INNER JOIN Images on Images.ImageID = Product.ImageID WHERE ProductID = @ID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetAllProductSatus]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllProductSatus]
AS
BEGIN TRY
    SELECT StatusID,StatusDescription FROM ProductStatus
END TRY
BEGIN CATCH
    THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetAllProductStatus]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllProductStatus]
AS
BEGIN TRY
    SELECT StatusID,StatusDescription FROM ProductStatus
END TRY
BEGIN CATCH
    THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetCartItems]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetCartItems] @CartID smallint
AS
BEGIN
Select ProductName, Price, Quantity, CartItems.ProductID, (Price * Quantity) as ItemSubtotal From CartItems INNER JOIN  Product on CartItems.ProductID = Product.ProductID WHERE CartID = @CartID
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoryByTypeID]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetCategoryByTypeID] @ID int
as
BEGIN TRY
	Select Distinct  Categories.Name, Categories.Description, Categories.CategoryID as 'CatID', Type From Categories Inner Join Product on Product.CategoryID = Categories.CategoryID Inner Join ProductType on ProductType.TypeID = Product.Type Where TypeID = @ID
END TRY
BEGIN CATCH
	THROW;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoryInfo]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCategoryInfo] @ID int
AS
BEGIN TRY
    IF EXISTS(SELECT * FROM Categories WHERE CategoryID = @ID)
        SELECT Name, Description FROM Categories WHERE CategoryID = @ID
    ELSE
        THROW 140000,'No Category exists with the given ID.',1
END TRY
BEGIN CATCH
    THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetFeaturedProducts]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetFeaturedProducts]
AS
BEGIN TRY
	SELECT ProductID, ProductName, BriefDescription, ImageURL, Price, AltText, Categories.Name  FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID INNER JOIN Categories ON Product.CategoryID = Categories.CategoryID Where Featured = 1
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetFullProductByID]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetFullProductByID] @ID smallint
AS
BEGIN TRY
    SELECT ProductName,FullDescription,Price,Product.ImageID,Featured,ProductStatus,CategoryID,Type,ImageURL,AltText FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID WHERE ProductID = @ID
END TRY
BEGIN CATCH
    THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetImageURL]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetImageURL]
AS
BEGIN TRY
	Select ImageURL, ImageID From Images
END TRY
BEGIN CATCH
	Throw;
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetProductsByCategory]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProductsByCategory] @CategoryID int
AS
BEGIN TRY
	SELECT ProductID, ProductName, Price, ImageURL, BriefDescription, Name FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID Inner Join Categories on Categories.CategoryID = Product.CategoryID WHERE Product.CategoryID = @CategoryID 
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetProductsByType]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetProductsByType] @TypeID int
AS
BEGIN TRY
	SELECT ProductID, ProductName, Price, ImageURL, BriefDescription, Name  FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID INNER JOIN Categories ON Product.CategoryID = Categories.CategoryID WHERE Type = @TypeID
END TRY 
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetProductType]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProductType]
AS
BEGIN TRY
	Select TypeID, Name From ProductType
END TRY
BEGIN CATCH
	Throw
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spGetSearchResults]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetSearchResults] @Input varchar(50)
AS
BEGIN TRY
    IF EXISTS(SELECT * FROM Product WHERE ProductName LIKE '%' + @Input + '%' OR FullDescription LIKE '%' + @Input + '%' OR BriefDescription LIKE '%' + @Input + '%')
        SELECT ProductID, ProductName, Price, ImageURL, BriefDescription  FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID WHERE ProductName LIKE '%' + @Input + '%' OR FullDescription LIKE '%' + @Input + '%' OR BriefDescription LIKE '%' + @Input + '%'
    ELSE
        THROW 120000,'There are no products that meet the search term.',1
END TRY
BEGIN CATCH
    THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spInsertCategory]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertCategory] @CategoryName varchar(15), @CategoryDescription varchar(200)
AS
BEGIN TRY
	INSERT INTO Categories (Name, Description) VALUES (@CategoryName, @CategoryDescription)
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spInsertProduct]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertProduct] @ProductName varchar(30), @BriefDescription varchar(200), @FullDescription varchar(max), @Price float, @ImageID int, @Featured bit, @ProductStatus char(1), @CategoryID int, @Type tinyint
AS
BEGIN TRY
	INSERT INTO Product (ProductName, BriefDescription, FullDescription, Price, ImageID, Featured, ProductStatus, CategoryID,Type) VALUES (@ProductName, @BriefDescription, @FullDescription, @Price, @ImageID, @Featured, @ProductStatus, @CategoryID, @Type)
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spRemoveFromCart]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spRemoveFromCart] @ProductID smallint, @CartID smallint
AS 
BEGIN
Delete From CartItems Where ProductID = @ProductID AND CartID = @CartID
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCategory]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateCategory] @CategoryID int, @Name varchar(15), @Description varchar(200)
AS
BEGIN TRY
	Update Categories SET Name = @Name, Description = @Description WHERE CategoryID = @CategoryID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spUpdateProduct]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateProduct] @ProductID smallint, @ProductName varchar(30), @BriefDescription varchar(200), @FullDescription varchar(max), @Price float, @ImageID int, @Featured bit, @ProductStatus char(1), @CategoryID int, @ProductType int
AS
BEGIN TRY
	UPDATE Product SET ProductName = @ProductName, BriefDescription = @BriefDescription, FullDescription = @FullDescription, Price = @Price, ImageID = @ImageID, Featured = @Featured, CategoryID = @CategoryID, Type = @ProductType WHERE ProductID = @ProductID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spUpdateQuantity]    Script Date: 22/10/2018 14:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spUpdateQuantity] @CartID smallint, @ProductID smallint, @Quantity int
AS
BEGIN
Update CartItems
Set Quantity = @Quantity
Where CartID = @CartID AND ProductID = @ProductID
END
GO
USE [master]
GO
ALTER DATABASE [Vidiots] SET  READ_WRITE 
GO
