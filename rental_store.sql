USE [master]
GO
/****** Object:  Database [rental_store]    Script Date: 02-10-2019 12:57:16 ******/
CREATE DATABASE [rental_store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'rental_store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\rental_store.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'rental_store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\rental_store_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [rental_store] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [rental_store].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [rental_store] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [rental_store] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [rental_store] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [rental_store] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [rental_store] SET ARITHABORT OFF 
GO
ALTER DATABASE [rental_store] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [rental_store] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [rental_store] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [rental_store] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [rental_store] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [rental_store] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [rental_store] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [rental_store] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [rental_store] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [rental_store] SET  DISABLE_BROKER 
GO
ALTER DATABASE [rental_store] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [rental_store] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [rental_store] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [rental_store] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [rental_store] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [rental_store] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [rental_store] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [rental_store] SET RECOVERY FULL 
GO
ALTER DATABASE [rental_store] SET  MULTI_USER 
GO
ALTER DATABASE [rental_store] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [rental_store] SET DB_CHAINING OFF 
GO
ALTER DATABASE [rental_store] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [rental_store] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [rental_store] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [rental_store] SET QUERY_STORE = OFF
GO
USE [rental_store]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 02-10-2019 12:57:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[PhoneNumber] [nvarchar](11) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 02-10-2019 12:57:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[MovieTitle] [nvarchar](max) NOT NULL,
	[MovieReleaseDate] [datetime] NOT NULL,
	[MovieRatings] [float] NOT NULL,
	[MovieCopies] [int] NOT NULL,
	[MovieRatingCost] [nvarchar](9) NOT NULL,
	[MovieGenre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rented]    Script Date: 02-10-2019 12:57:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rented](
	[RentalID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[RentFrom] [datetime] NOT NULL,
	[RentTill] [datetime] NOT NULL,
 CONSTRAINT [PK_Rented] PRIMARY KEY CLUSTERED 
(
	[RentalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Rented]  WITH CHECK ADD  CONSTRAINT [FK_Rented_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Rented] CHECK CONSTRAINT [FK_Rented_Customers]
GO
ALTER TABLE [dbo].[Rented]  WITH CHECK ADD  CONSTRAINT [FK_Rented1_Rented1] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Rented] CHECK CONSTRAINT [FK_Rented1_Rented1]
GO
USE [master]
GO
ALTER DATABASE [rental_store] SET  READ_WRITE 
GO
