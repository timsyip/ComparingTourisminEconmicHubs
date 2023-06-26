--Finding Countries I want to looking. I am looking at Spain, Singapore, Hong Kong, United Kingdom and the United States
SELECT *FROM Country c 
WHERE CountryCode  IN  ('FRA','ESP', 'SGP', 'HKG', 'GBR', 'USA')


  --Narrowing down my research to tourism

--Looking at different indicator for tourism
SELECT IndicatorName, LongDefinition, LimitationsAndExceptions, DevelopmentRelevance  
FROM Series s 
LEFT JOIN SeriesNotes sn ON s.SeriesCode = sn.Seriescode 
WHERE Topic LIKE ('%tourism%')

--Narrowing down the years to 10 year time frame from 2003-2013
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('FRA','ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

  --International Tourism coming to the 5 Countries

--selecting all the countries and looking at their international arrival data
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('FRA','ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%arvl%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

--Payments to national carriers for international transport. These receipts include any other PREPAYMENT made for goods or services received in the destination country.
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('FRA','ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%rcpt.cd%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"


--The goods and services are purchased by, or on behalf of, the traveler or provided, without a quid pro quo, for the traveler to use or give away.
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('FRA','ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%tvlr%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

--% of total exports per year
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('FRA','ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%INT.RCPT.xp%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

--International tourism, receipts for passenger transport items (current US$)
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('FRA','ESP', 'SGP', 'HKG', 'GBR', 'USA')  
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%TRNR%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

  --International Tourism leaving the 5 Countries

--selecting all the countries and looking at their international departure data
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%dprt%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

--% of total imports per year
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%xpnd.mp%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

--International Tourism Expenditure
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%xpnd.cd%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"

--international tourism for Travel Items
SELECT * 
FROM Indicators i 
WHERE CountryCode IN ('ESP', 'SGP', 'HKG', 'GBR', 'USA') 
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%tvlx%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"




--Inbound Tourism Top 5
WITH all_country
AS 
(
SELECT *, DENSE_RANK()over(PARTITION BY "YEAR" ORDER BY Value DESC) AS rankperyear
FROM Indicators i 
WHERE CountryCode NOT in ('ARB','CSS','CEB','EAS','EAP','EMU','ECS','ECA','EUU','FCS','HPC','HIC', 
				       'NOC','OEC','LCN','LAC','LDC','LMY','LIC','LMC','MEA','MNA','MIC','NAC', 
			           'OED','OSS','PSS','SST','SAS','SSF','SSA', 'UMC','WLD') 
    AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%arvl%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"  
)
SELECT *
FROM all_country
WHERE rankperyear <=5

--Outbound Tourism Top 5
WITH all_country
AS 
(
SELECT *, DENSE_RANK()over(PARTITION BY "YEAR" ORDER BY Value DESC) AS rankperyear
FROM Indicators i 
WHERE CountryCode NOT in ('ARB','CSS','CEB','EAS','EAP','EMU','ECS','ECA','EUU','FCS','HPC','HIC', 
				       'NOC','OEC','LCN','LAC','LDC','LMY','LIC','LMC','MEA','MNA','MIC','NAC', 
			           'OED','OSS','PSS','SST','SAS','SSF','SSA', 'UMC','WLD') 
    AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%dprt%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"  
)
SELECT *
FROM all_country
WHERE rankperyear <=5

--Total Tourism
SELECT * 
FROM Indicators i 
WHERE CountryCode = 'WLD'
	AND IndicatorName LIKE ('%tourism%')
	AND IndicatorCode LIKE ('%dprt%')
	AND "Year"  BETWEEN '2003' AND '2013'
ORDER BY "Year"