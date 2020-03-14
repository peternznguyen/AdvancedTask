
CREATE TABLE [dbo].[DimAuLocalSchool](
	[AuLocalSchoolKey] [int] IDENTITY(1,1) NOT NULL,
	[SchoolId] [int] NULL,
	[PostCode] [nvarchar](6) NULL,
	[SchoolName] [nvarchar](100) NULL,
	[SchoolAddress] [nvarchar](200) NULL,
	[SchoolLat] [float] NULL,
	[SchoolLong] [float] NULL,
	[StudentNumber] [int] NULL,
	[ICSEAValue] [int] NULL,
	[LevelOfSchooling] [nvarchar](100) NULL,
	[SchoolSpecialtyType] [nvarchar](200) NULL,
	[SchoolSubType] [nvarchar](200) NULL,
	[SchoolGender] [nvarchar](20) NULL,
	[PreSchoolInd] [nvarchar](2) NULL,
	[DistanceEducation] [nvarchar](2) NULL,
	[IntensiveEnglishCentre] [nvarchar](2) NULL,
	[Phone] [nvarchar](20) NULL,
	[SchoolEmail] [nvarchar](40) NULL,
	[Fax] [nvarchar](20) NULL,
	[LateOpeningSchool] [nvarchar](2) NULL,
	[Date1stTeacher] [datetime] NULL,
	[lga] [nvarchar](50) NULL,
	[Electorate] [nvarchar](200) NULL,
	[FedElectorate] [nvarchar](200) NULL,
	[OperationalDirectorate] [nvarchar](200) NULL,
	[PrincipalNetwork] [nvarchar](200) NULL,
	[FacsDistrict] [nvarchar](128) NULL,
	[LocalHealthDistrict] [nvarchar](200) NULL,
	[AecgRegion] [nvarchar](200) NULL,
	[ASGSRemoteness] [nvarchar](200) NULL,
	[DateExtracted] [datetime] NULL,
	[AgeId] [int] NULL,
	[IndigenousPct] [nvarchar](10) NULL,
	[lbotePct] [nvarchar](10) NULL,
	[SelectiveSchool] [nvarchar](50) NULL,
	[ClassYN] [nvarchar](2) NULL,
	[StateCode] [nvarchar](3) NOT NULL,
	[SuburbIdAltKey] [int] NOT NULL,
	[TownSuburb] [nvarchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_DimAuLocalSchool_AuLocalSchoolKey] PRIMARY KEY CLUSTERED 
(
	[AuLocalSchoolKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DimAuLocalSchool]  WITH CHECK ADD  CONSTRAINT [FK_DimAuLocalSchool_DimGeography] FOREIGN KEY([SuburbIdAltKey])
REFERENCES [dbo].[DimGeography] ([GeographyAltKey])
GO

ALTER TABLE [dbo].[DimAuLocalSchool] CHECK CONSTRAINT [FK_DimAuLocalSchool_DimGeography]
GO

ALTER TABLE [dbo].[DimAuLocalSchool]  WITH CHECK ADD  CONSTRAINT [FK_DimAuLocalSchool_DimGeography_SuburbIdAltKey] FOREIGN KEY([SuburbIdAltKey])
REFERENCES [dbo].[DimGeography] ([GeographyAltKey])
GO

ALTER TABLE [dbo].[DimAuLocalSchool] CHECK CONSTRAINT [FK_DimAuLocalSchool_DimGeography_SuburbIdAltKey]
GO


