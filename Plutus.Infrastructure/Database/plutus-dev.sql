USE [plutus-dev]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Receipt]') AND type in (N'U'))
ALTER TABLE [dbo].[Receipt] DROP CONSTRAINT IF EXISTS [FK_Receipt_Payment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Receipt]') AND type in (N'U'))
ALTER TABLE [dbo].[Receipt] DROP CONSTRAINT IF EXISTS [FK_Receipt_Category]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Receipt]') AND type in (N'U'))
ALTER TABLE [dbo].[Receipt] DROP CONSTRAINT IF EXISTS [FK_Receipt_Account]
GO
DROP TABLE IF EXISTS [dbo].[Receipt]
GO
DROP TABLE IF EXISTS [dbo].[Payment]
GO
DROP TABLE IF EXISTS [dbo].[Category]
GO
DROP TABLE IF EXISTS [dbo].[Account]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Account]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Account](
	[AccountId] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Picture] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Icon] [varchar](max) NOT NULL,
	[Color] [varchar](10) NOT NULL,
	[TypeId] [int] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Payment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Color] [varchar](10) NOT NULL,
	[Icon] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Receipt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Receipt](
	[ReceiptId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[PaymentId] [int] NOT NULL,
	[Description] [varchar](500) NOT NULL,
	[AccountId] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Receipt] PRIMARY KEY CLUSTERED
(
	[ReceiptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipt_Account]') AND parent_object_id = OBJECT_ID(N'[dbo].[Receipt]'))
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipt_Account]') AND parent_object_id = OBJECT_ID(N'[dbo].[Receipt]'))
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_Account]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipt_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Receipt]'))
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipt_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Receipt]'))
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_Category]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipt_Payment]') AND parent_object_id = OBJECT_ID(N'[dbo].[Receipt]'))
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_Payment] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([PaymentId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Receipt_Payment]') AND parent_object_id = OBJECT_ID(N'[dbo].[Receipt]'))
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_Payment]
GO
