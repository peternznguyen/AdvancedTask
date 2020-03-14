USE [AdvancedTasksDW]
GO

/****** Object:  Table [dbo].[FactSuburbRentalMedian]    Script Date: 3/4/2020 8:51:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactSuburbRentalMedian](
	[FactSuburbRentalMedianAltKey] [int] IDENTITY(1,1) NOT NULL,
	[SuburbRentalMedianAltKey] [int] NOT NULL,
	[RentalMedianValue] [decimal](18, 2) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_FactSuburbRentalMedian_FactSuburbRentalMedianAltKey] PRIMARY KEY CLUSTERED 
(
	[FactSuburbRentalMedianAltKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactSuburbRentalMedian]  WITH CHECK ADD  CONSTRAINT [FK_FactSuburbRentalMedian_DimGeography_SuburbRentalMedianAltKey] FOREIGN KEY([SuburbRentalMedianAltKey])
REFERENCES [dbo].[DimGeography] ([GeographyAltKey])
GO

ALTER TABLE [dbo].[FactSuburbRentalMedian] CHECK CONSTRAINT [FK_FactSuburbRentalMedian_DimGeography_SuburbRentalMedianAltKey]
GO


