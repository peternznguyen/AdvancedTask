CREATE PROCEDURE [dbo].[Proc_CalDistFromSuburbToSuburb_PropertyMedianValueDW]
--Calculate distance from one (Latitude,Longitude) position to other (Latitude,Longitude) position within one table
--Option: Add condition to WHERE in the ToSuburb_Cursor to get desired distance
--Option: Results can be printed here or inserted into a table
--Author: Peter Nguyen
--Updated: October 2019
AS
BEGIN   
		DECLARE @GeographyAltKey nvarchar(50);
		DECLARE @FromSuburb nvarchar(50);
		DECLARE @FromLat float;
		DECLARE @FromLong float;
		DECLARE @GeoDistance GEOGRAPHY;
		DECLARE FromSuburb_Cursor CURSOR FOR SELECT S1.GeographyAltKey, S1.Suburb, S1.Latitude, S1.Longitude  FROM DimGeography S1 ORDER BY SuburbId;
		OPEN FromSuburb_Cursor;
		FETCH NEXT FROM FromSuburb_Cursor INTO  @GeographyAltKey, @FromSuburb, @FromLat,@FromLong;
		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			SET @GeoDistance= geography::Point(@FromLat, @FromLong, 4326);    
			DECLARE @ToSuburbIDAltKey int;
			DECLARE @ToSuburb nvarchar(50);
			DECLARE @DateKey int;
			DECLARE @PropertyMedianValue int;
			DECLARE @NearDistance_Radius float;
			DECLARE ToSuburb_Cursor CURSOR FOR SELECT DISTINCT DG.GeographyAltKey, DG.Suburb, FP.PropertyMedianValue,FP.DateKey, (@GeoDistance.STDistance(geography::Point(ISNULL(DG.Latitude,0),ISNULL(DG.Longitude,0), 4326)))/1000 as DISTANCE 
			 								   FROM DimGeography DG
											   INNER JOIN FactMedianPropertyValueByYear FP ON FP.SuburbPropertyMedianValueAltKey=DG.GeographyAltKey
											   WHERE (@GeoDistance.STDistance(geography::Point(ISNULL(DG.Latitude,0),ISNULL(DG.Longitude,0), 4326)))/1000>0
											   AND (@GeoDistance.STDistance(geography::Point(ISNULL(DG.Latitude,0),ISNULL(DG.Longitude,0), 4326)))/1000 <= 1 --Display distance from FromSuburb to ToSuburb within 1km radius
						    OPEN ToSuburb_Cursor;
							FETCH NEXT FROM ToSuburb_Cursor INTO @ToSuburbIDAltKey, @ToSuburb, @PropertyMedianValue,@DateKey, @NearDistance_Radius;
							WHILE @@FETCH_STATUS = 0  
								BEGIN
								   -- PRINT N'From Suburb: ' +Cast(@FromSuburbID as nvarchar(10))+','+ @FromSuburb +' '+ N' To Suburb: ' +Cast(@ToSuburbID as nvarchar(10))+','+@ToSuburb +' '+ Cast(@NearDistance_Radius as nvarchar(20));
									INSERT INTO DimSuburbDistance(FromSuburbIDAltKey,FromSuburb,ToSuburbIDAltKey,ToSuburb,DisplayTypeID,DisplayType,DescriptionType,Distance,ValueType,AddInfor) 
									VALUES(@GeographyAltKey, @FromSuburb,@ToSuburbIDAltKey,@ToSuburb,7,'PropertyValue',NULL,@NearDistance_Radius,@PropertyMedianValue, @DateKey);
									
								FETCH NEXT FROM ToSuburb_Cursor INTO @ToSuburbIDAltKey, @ToSuburb, @PropertyMedianValue,@DateKey, @NearDistance_Radius;
								END;
						  CLOSE ToSuburb_Cursor;
						  DEALLOCATE ToSuburb_Cursor ;
 			FETCH NEXT FROM FromSuburb_Cursor INTO  @GeographyAltKey, @FromSuburb, @FromLat,@FromLong;
		END;
		CLOSE FromSuburb_Cursor;
		DEALLOCATE FromSuburb_Cursor;
END
