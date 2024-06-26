USE [master]
GO
/****** Object:  Database [sasha]    Script Date: 21.04.2024 14:40:39 ******/
CREATE DATABASE [sasha]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sasha', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\sasha.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'sasha_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\sasha_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [sasha] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sasha].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sasha] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sasha] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sasha] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sasha] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sasha] SET ARITHABORT OFF 
GO
ALTER DATABASE [sasha] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [sasha] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sasha] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sasha] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sasha] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sasha] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sasha] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sasha] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sasha] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sasha] SET  DISABLE_BROKER 
GO
ALTER DATABASE [sasha] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sasha] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sasha] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sasha] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sasha] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sasha] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sasha] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sasha] SET RECOVERY FULL 
GO
ALTER DATABASE [sasha] SET  MULTI_USER 
GO
ALTER DATABASE [sasha] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sasha] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sasha] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sasha] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [sasha] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [sasha] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'sasha', N'ON'
GO
ALTER DATABASE [sasha] SET QUERY_STORE = ON
GO
ALTER DATABASE [sasha] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [sasha]
GO
/****** Object:  Table [dbo].[Loans]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[LoanID] [int] NOT NULL,
	[UserID] [int] NULL,
	[BookID] [int] NULL,
	[LoanDate] [date] NULL,
	[ReturnDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[LoanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OverdueLoansView]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OverdueLoansView] AS
SELECT *
FROM Loans
WHERE ReturnDate < GETDATE();
GO
/****** Object:  View [dbo].[ActiveLoansView]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ActiveLoansView] AS
SELECT *
FROM Loans
WHERE ReturnDate IS NULL;
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[AuthorID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Nationality] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[BookID] [int] NOT NULL,
	[Title] [nvarchar](200) NULL,
	[AuthorID] [int] NULL,
	[GenreID] [int] NULL,
	[PublishDate] [date] NULL,
	[ISBN] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BookAuthorView]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BookAuthorView] AS
SELECT b.Title, b.PublishDate, b.ISBN, a.Name AS Author
FROM Books b
INNER JOIN Authors a ON b.AuthorID = a.AuthorID;
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[GenreID] [int] NOT NULL,
	[GenreName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[LanguageID] [int] NOT NULL,
	[LanguageName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Libraries]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Libraries](
	[LibraryID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[LibraryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[StatusID] [int] NOT NULL,
	[StatusName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Authors] ([AuthorID])
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genres] ([GenreID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Books] ([BookID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[DeleteBook]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBook]
    @BookID INT
AS
BEGIN
    DELETE FROM Books
    WHERE BookID = @BookID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetBookLoans]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBookLoans]
    @BookID INT
AS
BEGIN
    SELECT *
    FROM Loans
    WHERE BookID = @BookID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetBooksAndAuthors]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBooksAndAuthors]
AS
BEGIN
    SELECT b.Title, b.PublishDate, b.ISBN, a.Name AS Author
    FROM Books b
    INNER JOIN Authors a ON b.AuthorID = a.AuthorID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUnavailableBooks]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUnavailableBooks]
AS
BEGIN
    SELECT *
    FROM Books
    WHERE BookID IN (SELECT BookID FROM Loans WHERE ReturnDate IS NULL)
    OR BookID IN (SELECT BookID FROM LostBooks);
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUserActiveLoans]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserActiveLoans]
    @UserID INT
AS
BEGIN
    SELECT *
    FROM Loans
    WHERE UserID = @UserID
    AND ReturnDate IS NULL;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertBook]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBook]
    @Title NVARCHAR(200),
    @AuthorID INT,
    @GenreID INT,
    @PublishDate DATE,
    @ISBN NVARCHAR(20)
AS
BEGIN
    INSERT INTO Books (Title, AuthorID, GenreID, PublishDate, ISBN)
    VALUES (@Title, @AuthorID, @GenreID, @PublishDate, @ISBN);
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateBook]    Script Date: 21.04.2024 14:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBook]
    @BookID INT,
    @Title NVARCHAR(200),
    @AuthorID INT,
    @GenreID INT,
    @PublishDate DATE,
    @ISBN NVARCHAR(20)
AS
BEGIN
    UPDATE Books
    SET Title = @Title,
        AuthorID = @AuthorID,
        GenreID = @GenreID,
        PublishDate = @PublishDate,
        ISBN = @ISBN
    WHERE BookID = @BookID;
END;
GO
USE [master]
GO
ALTER DATABASE [sasha] SET  READ_WRITE 
GO
