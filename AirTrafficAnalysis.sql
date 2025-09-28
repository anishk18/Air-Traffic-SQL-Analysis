
/* Setting default schema to AirTraffic*/
USE AirTraffic; 

/* Viewing the data for first look*/

SELECT *
FROM 
	flights; 
/* All field and data match those that were given in the question, have 23 columns with data types int, date, string and float*/

SELECT COUNT(*)
FROM 
	flights; 
/* Total rows '6,521,361' */

SELECT *
FROM 
	airports;
/* All field and data match those that were given in the question, have 8 columns with data types int, string and float*/

SELECT COUNT(*)
FROM 
	airports; 
/* Total rows '6638'*/

/* Question 1:
The managers of the BrainStation Mutual Fund want to know some basic details about the data. 
Use fully commented SQL queries to address each of the following questions: */


/* Q1.1. How many flights were there in 2018 and 2019 separately?*/
SELECT 
	YEAR(FlightDate) AS flight_year,    -- Taking Year from Flight Date column
	COUNT(*) AS Total_flights           -- Counting all flights 
FROM 	                                 -- Taking from flights table
	flights                            
GROUP BY                                -- Grouping flight date by Year
	YEAR(FlightDate);                    
    
/* Answer: 2018 Flights:3,218,653 ; 2019 Flights: 3,302,708 . Higher # of flights in 2019*/


/*  Q1.2.In total, how many flights were cancelled or departed late over both years?*/
SELECT 	                                      
	COUNT(*) AS Flights_Cancelled_Departed     -- Counting all cancelled or departed late flights 
FROM 
	flights                                     -- Taking from flights table
WHERE 
	Cancelled = 1 OR DepDelay > 0;              -- Filtering for Cancelled or departured flights
/* Answer: Total Flights departed late or cancelled  over both years: '2,633,237'. 
Roughly 1/3 flights cancelled from total of 6.5 million flights over 2 years */


/*  Q.1.3.Show the number of flights that were cancelled broken down by the reason for cancellation.*/
SELECT 
	CancellationReason, COUNT(*) as Num_flights_cancelled        -- Counting flights Grouping by Cancellation reason
FROM 
	flights                                                      -- Taking from flights table
WHERE
	Cancelled = 1                                                -- Filtering for Cancelled  flights 
GROUP BY 	                                                     -- Grouping by Cancellation reason
		CancellationReason;
/* Ans:
Weather: 50,225
Carrier: 34,141
National Air System: 7,962
Security:35
 Highest cancellation is seen based on Weather related events. */

/* Q.1.4. For each month in 2019, report both the total number of flights and percentage of flights cancelled. 
Based on your results, what might you say about the cyclic nature of airline reveune?*/

SELECT 
	YEAR(FlightDate) AS flight_year,                                                      -- Selecting year from Flight date column
    MONTH(FlightDate) AS flight_month,                                                     -- Selecting month from Flight date column
    COUNT(*) AS total_flights,                                                             -- Count rows to get  total flights
    SUM(Cancelled) AS cancelled_flights,                                                   -- Suming cancelled flights as to get total cancelled flight
    ROUND((SUM(Cancelled)/COUNT(*)*100),2) AS percentage_flights_cancelled                 -- Calculating % of flights cancelled and round the numbers to 2 decimal places
FROM 
	flights                                                                              -- Taking from flights table
WHERE 
	YEAR(FlightDate) = 2019                                                              -- Filtering from Year 2019 only  
GROUP BY                                                                                
	flight_month, flight_year                                                            -- Group by month and year
ORDER BY
	flight_month;                                                                         -- Ordering rows by months

/* Comment on results -- search for answers online
 Cancellation Rate decrease as we go from Jan to Dec, with variations in the summer months were it increases.
Sesonal varation and operational challenges are some factors that could influencing airline reveune, the cyclicality is due to 
strong earning during peak travel times where cancellation rate is lower summer and winter break,
but more anlysis needs to conducted to understand the cyclic nature.
*/

/* Question 2
Q.2.1. Create two new tables, one for each year (2018 and 2019) showing the total miles travelled 
and number of flights broken down by airline.*/

DROP TABLE IF EXISTS year_2018; -- Dropping table if exists
CREATE TABLE year_2018 AS       -- Creating new table  for 2018
SELECT  
	AirlineName, 
    SUM(Distance) as Total_miles,  -- Sum total miles 
    COUNT(*) as Num_flights       -- Count # of flights 
FROM 
	flights                         -- Taking from flights table
WHERE
	YEAR(FlightDate) = 2018       -- Filtering from Year 2018 only 
GROUP BY
	AirlineName                   -- Group by Airline Name 
ORDER BY
	AirlineName;                   -- Ordering by Airline Name 

/* 
Answer:
# AirlineName	Total_miles	           Num_flights
American Airlines Inc.	933,094,276	     916,818
Delta Air Lines Inc.	842,409,169	      949,283
Southwest Airlines Co.	1,012,847,097	 1,352,552
*/


DROP TABLE IF EXISTS year_2019; -- Dropping table if exists
CREATE TABLE year_2019 AS       -- Creating new table for 2019 
SELECT  
	AirlineName, 
    SUM(Distance) as Total_miles,  -- Sum total miles 
    COUNT(*) as Num_flights        -- Count # of flights 
FROM 
	flights                       -- Taking from flights table
WHERE
	YEAR(FlightDate) = 2019 -- Filtering from Year 2019 only 
GROUP BY
	AirlineName             -- Group by Airline Name 
ORDER BY
	AirlineName;            -- Ordering by Airline Name 

/* Answer:
# AirlineName	      Total_miles	        Num_flights
American Airlines Inc.	938,328,443	         946,776
Delta Air Lines Inc.	889,277,534	          991,986
Southwest Airlines Co.	1,011,583,832	     1,363,946
*/


/* Q.2.2. Using your new tables, find the year-over-year percentage change in total flights and miles travelled for each airline*/
SELECT 	year_2018.AirlineName,
		ROUND(((year_2019.Total_miles-year_2018.Total_miles)/year_2018.Total_miles*100), 2) AS percentage_total_flights, -- Calculating year over year % for  total flights and round to two digits
		ROUND(((year_2019.Num_flights-year_2018.Num_flights)/year_2018.Num_flights*100),2) AS percentage_miles_travelled  -- Calculating year over year % for miles traveled and round to two digits
FROM 
	year_2018             -- Taking from 2018 table
 JOIN 
	year_2019             -- Joining from 2018 table
ON 
	year_2018.AirlineName=year_2019.AirlineName; -- Joining on Airline Name

/* Answer:
# AirlineName	   percentage_total_flights	 percentage_miles_travelled
American Airlines Inc.	0.56	                3.27
Delta Air Lines Inc.	5.56	                4.50
Southwest Airlines Co.	-0.12	               0.84

From 2018 to 2019, 
 American Airlines increased total flights, which resulted in a increase in miles travelled, similarly Delta airlines
 also had a significantly higher total flights which increased their miles travelled, for
 Southwest Airline,  total flights decreased over the years, but this saw a small increase in miles travelled.
 
 Investing in Delta seems beneficial as over the years they have had a higher # of flights, which have resulted in more revenue for the airline
 hence increasing their profit.
    */
    
    
/* Question 3
Another critical piece of information is what airports the three airlines utilize the most commonly.*/

 /*
 Q.3.1.What are the names of the 10 most popular destination airports overall?
For this question, generate a SQL query that first joins flights and airports then does the necessary aggregation.
 */
 
SELECT 
	AirportName, COUNT(*) as flights_arriving  -- Counting  most popular destination airports
FROM 
	flights                                              -- From flights table
JOIN 
	airports                                             -- joining on airports table
ON 
	flights.DestAirportID = airports.AirportID             -- on  destination airports in both tables
GROUP BY 
	AirportName                                            -- Grouping by airline name
ORDER BY
	 flights_arriving DESC                                  -- Ordering on  total flights arriving
LIMIT 10;                                                   -- Limit  to 10 popular destinations
 /*
# AirportName: flights_arriving
Hartsfield-Jackson Atlanta International:595527
Dallas/Fort Worth International: 314423
Phoenix Sky Harbor International: 253697
Los Angeles International:238092
Charlotte Douglas International:216389
Harry Reid International: 200121
Denver International: 184935
Baltimore/Washington International Thurgood Marshall:	168334
Minneapolis-St Paul International:165367
Chicago Midway International:165007
 */
 
/*
Q.3.2.
Answer the same question but using a subquery to aggregate & limit the flight data before your join with the airport information, 
hence optimizing your query runtime.
*/
SELECT  a.AirportName, f.flights_arriving  -- Selecting  AirportName from airport table and flights_arriving from flights table
FROM
	(
    SELECT  
		DestAirportID,
        COUNT(*) as flights_arriving     -- Counting  all flights based on destinationairportsID
	FROM
		flights                        -- From flights table
	GROUP BY
		DestAirportID                    -- Grouping by destinationairportsID
	
    ) as f                              -- making a subquery from flights table
INNER JOIN                               -- inner join  airports table and subquery
    airports AS a
ON f.DestAirportID = a.AirportID          -- on airport id in both tables
ORDER BY 
		f.flights_arriving DESC           -- ordering by highest number of flights
LIMIT 10;                                 -- Limit to top 10 popular destinations.
 
 /*
# AirportName: flights_arriving
Hartsfield-Jackson Atlanta International:595527
Dallas/Fort Worth International: 314423
Phoenix Sky Harbor International: 253697
Los Angeles International:238092
Charlotte Douglas International:216389
Harry Reid International: 200121
Denver International: 184935
Baltimore/Washington International Thurgood Marshall:	168334
Minneapolis-St Paul International:165367
Chicago Midway International:165007
 */
 
/* 
 Answer: The second approach (Case 2) of filtering and aggregrateing and then joining the subquery is 
much more efficient~ 9.1 secs vs ~ 83 secs in Case 1 as we join a smaller table
*/


/* Question 4 
The fund managers are interested in operating costs for each airline. We don't have actual cost or revenue information available,
 but we may be able to infer a general overview of how each airline's costs compare by looking at data that reflects equipment and fuel costs.
Q.4.1. A flights's tail number is the actual number affixed to the fuselage of an aircraft, much like a car license plate.
As such, each plane  has a unique tail number and the number of unique tail numbers for each airline should approximate how many planes the airline operates in total.
Using this information, determine the unique aircrafts each airline operated in total over 2018-2019 
*/
SELECT 
    AirlineName,
    COUNT(DISTINCT Tail_Number) as num_aircrafts     -- counting all distinct tail number for airline
FROM                             -- from flights table
	flights                    
WHERE Tail_Number IS NOT NULL   -- Filtering on Tail Number and eliminating any null values 
GROUP BY 
	AirlineName                -- Group by Airline
ORDER BY
	num_aircrafts DESC;        -- Ordering by highest number of aircrafts
/* Answer:
# AirlineName	num_aircrafts
American Airlines Inc.	993
Delta Air Lines Inc.	988
Southwest Airlines Co.	754
*/


/* Q.4.2. Similarly, the total miles traveled by each airline gives an idea of total fuel costs and the distance traveled per plane gives an approximation of total equipment costs.
What is the average distance traveled per aircraft for each of the three airlines?

As before, use fully commented SQL queries to address the questions. Compare the three airlines with respect to your findings:
how to these results impact your estimates of each airline's finances?
*/

 -- Method 1: find  average for the airline sum all aircrafts
SELECT
	AirlineName, COUNT(DISTINCT Tail_Number) as num_aircrafts,  -- counting all distinct tail number for airline
    SUM(DISTANCE) as total_miles, -- suming distance from all flights as total_miles
    ROUND(SUM(DISTANCE)/COUNT(Tail_Number),2) as average_distance_traveled_aircraft  -- calculating average distance per airline per aircraft
FROM 
	flights                      -- From flights table
WHERE Tail_Number IS NOT NULL  -- Filtering on Tail Number and eliminating any null values
GROUP BY
	AirlineName -- Group by each airline
ORDER BY
	average_distance_traveled_aircraft DESC;  -- ordering on highest average distance traveled per air aircraft
/*
Answer:

# AirlineName	num_aircrafts	total_miles	average_distance_traveled_aircraft
American Airlines Inc.	993	1,870,581,324	1004.2
Delta Air Lines Inc.	988	1,731,685,970	892.04
Southwest Airlines Co.	754	2,017,051,073	744.89

Average distance travelled for American Airlines Inc. is the highest travelled among the three airlines, while the total miles travelled is the highest for Southwest Airlines Co.
Based on these numbers Southwest Airlines reflect to have the lowest costs to related to equipment as they have the smallest fleet size compared to the other two.
Southwest Airlines Co. however likely has the highest fuel cost due to the total number of miles travelled by their fleet,
however their mileage per plane seems most effecient probably due to thier plane effiencies.
*/
 -- Method 2: find  average per aircraft of  the airline
SELECT
    AirlineName,
    Tail_Number,
    ROUND(AVG(DISTANCE), 2) as avg_distance_traveled_per_aircraft_perTail_Number  -- average distance travelled per airline per plane
FROM 
	flights                                 -- From flights table
WHERE Tail_Number IS NOT NULL              -- Filtering on Tail Number and eliminating any null values
GROUP BY 
	AirlineName,                          -- Group by each airline and Tail Number
	Tail_Number
ORDER BY
	AirlineName;                       -- order by airline name
    /* 2735 enteries for all aircrafts found and each have a average distance between 900-1300 miles*/

/* Question 5
Finally, the fund managers would like you to investigate the three airlines and major airports in terms of on-time performance as well. 
For each of the following questions, consider early departures and arrivals (negative values) as on-time (0 delay) in your calculations.
*/
/* 
Q.5.1.Next, we will look into on-time performance more granularly in relation to the time of departure. We can break up the departure times into three categories as follows: 
    CASE
    WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
    WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
    ELSE "4-night"
END AS "time_of_day"
    
Find the average departure delay for each time-of-day across the whole data set. Can you explain the pattern you see? 
*/
    
-- Looking at flights table
SELECT f.time_of_day, AVG(f.time_delayed) as average_time_delay -- averaging time delay column based on time of day grouping
FROM 
(SELECT id, DepDelay, CRSDepTime, -- selecting id, DepDelay and CRS Deptime from flights table
CASE
	WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
	WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
	WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
	ELSE "4-night"
		END AS "time_of_day",
CASE
    WHEN DepDelay >= 0 THEN DepDelay    -- casing statements to calculate average time delay based on DepDelay column
    ELSE 0
END AS "time_delayed"
FROM
	flights) as f -- Subquery for making time of day  column
GROUP BY f.time_of_day      -- Grouping and ordering by time of the day
ORDER BY f.time_of_day;

/* Answer:
1-morning	7.8045
2-afternoon	13.4777
3-evening	18.0383
4-night	7.6691

Average time delay seems to be the highest for 3- evening flights followed by 2-afternoon, while 1-morning and 4-night flights seem to have the smalles time delay.
*/

/* Q5.2.Now, find the average departure delay for each airport and time-of-day combination */

SELECT  airports.AirportName, f.time_of_day, AVG(f.time_delayed) as average_time_delay -- calculating average time delay  for each airport
FROM 
(SELECT id, FlightDate, Reporting_airline,Tail_Number, DepTime, DepDelay, CRSDepTime, DestAirportID, 
CASE
	WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
	WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
	WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
	ELSE "4-night"
		END AS "time_of_day",
CASE
    WHEN DepDelay >= 0 THEN DepDelay
    ELSE 0
END AS "time_delayed"
FROM
	flights) as f  -- subquery to  make time of day column using case statements
    
JOIN 
	airports    
ON 
	f.DestAirportID = airports.AirportID    -- joining airports table on the subquery
GROUP BY 
	f.time_of_day,                -- grouping and ordering by time of day and airport name
    airports.AirportName
ORDER BY 
	airports.AirportName,
	f.time_of_day;
    
/* Q.5.3.Next, limit your average departure delay analysis to morning delays and airports with at least 10,000 flights*/
SELECT  airports.AirportName, f.time_of_day,  AVG(f.time_delayed) as average_time_delay, COUNT(f.id) as num_flights -- calculating average time delay and counting flights delayed for each airport
FROM 
(SELECT id, FlightDate, Reporting_Airline, DepTime, DepDelay, CRSDepTime, DestAirportID,
CASE
	WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
	WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
	WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
	ELSE "4-night"
		END AS "time_of_day",
CASE
    WHEN DepDelay >= 0 THEN DepDelay
    ELSE 0
END AS "time_delayed"
FROM
	flights) as f  -- subquery to  make time of day column using case statements
JOIN 
	airports
ON 
	f.DestAirportID = airports.AirportID
WHERE f.time_of_day= "1-morning"                   -- Filtering for time of day for morning 
GROUP BY                                          -- grouping by time of day and airport name
	airports.AirportName,
    f.time_of_day
HAVING num_flights >=10000                       -- Showing atleast 10,000 flights delayed
ORDER BY 
    num_flights DESC;
    
/* Answer: Table results showing  average time delay and number of flights in  morning
 

# AirportName	time_of_day	average_time_delay	num_flights
Hartsfield-Jackson Atlanta International	1-morning	7.0153	191222
Dallas/Fort Worth International	1-morning	11.3024	103726
Phoenix Sky Harbor International	1-morning	8.2363	78238
Los Angeles International	1-morning	8.0183	72804
Charlotte Douglas International	1-morning	8.6069	72104
Harry Reid International	1-morning	6.5999	62979
Chicago O'Hare International	1-morning	11.0928	57578
Denver International	1-morning	7.1805	54833
Baltimore/Washington International Thurgood Marshall	1-morning	6.2013	51001
Orlando International	1-morning	7.8518	49191
Minneapolis-St Paul International	1-morning	7.8971	48687
Detroit Metro Wayne County	1-morning	7.4195	42835
Chicago Midway International	1-morning	6.3433	41602
Philadelphia International	1-morning	10.6010	41142
Miami International	1-morning	9.2598	37916
San Diego International	1-morning	6.6139	37825
Dallas Love Field	1-morning	6.6340	37519
LaGuardia	1-morning	10.1623	37325
Salt Lake City International	1-morning	6.9868	36473
St Louis Lambert International	1-morning	6.2624	34636
John F. Kennedy International	1-morning	11.6657	34571
Logan International	1-morning	8.5523	34553
Tampa International	1-morning	7.0087	33338
San Francisco International	1-morning	14.2314	31747
Ronald Reagan Washington National	1-morning	6.6670	31420
Seattle/Tacoma International	1-morning	8.8360	31388
William P Hobby	1-morning	6.2262	30896
Nashville International	1-morning	6.2353	30476
Fort Lauderdale-Hollywood International	1-morning	6.5343	30193
Norman Y. Mineta San Jose International	1-morning	6.1163	27618
Austin - Bergstrom International	1-morning	6.6748	26782
Metro Oakland International	1-morning	6.2941	26733
Louis Armstrong New Orleans International	1-morning	6.6985	23927
Sacramento International	1-morning	6.0112	22263
Kansas City International	1-morning	6.3355	21656
Raleigh-Durham International	1-morning	7.2050	21488
John Wayne Airport-Orange County	1-morning	6.3301	18428
Portland International	1-morning	5.9337	17828
San Antonio International	1-morning	7.3602	16240
Pittsburgh International	1-morning	7.1089	13826
Newark Liberty International	1-morning	15.7447	13353
Indianapolis International	1-morning	7.5885	13335
Bob Hope	1-morning	5.3024	13252
Southwest Florida International	1-morning	6.4960	13211
John Glenn Columbus International	1-morning	7.5791	12873
General Mitchell International	1-morning	6.6001	12051
Luis Munoz Marin International	1-morning	7.9781	10616
Jacksonville International	1-morning	6.0420	10068
*/


/* Q.5.4.By extending the query from the previous question, name the top-10 airports (with >10000 flights) with the highest average morning delay. 
In what cities are these airports located? */
SELECT  airports.AirportName, airports.City, f.time_of_day,  AVG(f.time_delayed) as average_time_delay, COUNT(f.Reporting_Airline) as num_flights  -- calculating average time delay and counting flights delayed for each airport
FROM 
(SELECT id, FlightDate, Reporting_Airline, DepTime, DepDelay, CRSDepTime, DestAirportID,
CASE
	WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
	WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
	WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
	ELSE "4-night"
		END AS "time_of_day",
CASE
    WHEN DepDelay >= 0 THEN DepDelay
    ELSE 0
END AS "time_delayed"
FROM
	flights) as f -- subquery to  make time of day column using case statements
JOIN 
	airports
ON 
	f.DestAirportID = airports.AirportID
WHERE 
	f.time_of_day="1-morning"   -- Filtering for time of day for morning 
GROUP BY 
	airports.AirportName,  -- grouping by time of day, airport name and city
    airports.City,
	f.time_of_day
HAVING 
	num_flights>10000     -- Showing atleast 10,000 flights delayed
ORDER BY 
	average_time_delay DESC   --  ordering for by highest time delayed for airplanes departing in the morning by airports
LIMIT 10; -- Limit results to top 10 airports and cities

/*
Answer:
top 10 cities for highest average morning delay for flights:

Newark Liberty International	Newark, NJ	

San Francisco International	San Francisco, CA
	
John F. Kennedy International	New York, NY	

Dallas/Fort Worth International	Dallas/Fort Worth, TX
	
Chicago O'Hare International	Chicago, IL	

Philadelphia International	Philadelphia, PA
	
LaGuardia	New York, NY	

Miami International	Miami, FL	

Seattle/Tacoma International	Seattle, WA	

Charlotte Douglas International	Charlotte, NC	

# AirportName	City	time_of_day	average_time_delay	num_flights
Newark Liberty International	Newark, NJ	1-morning	15.7447	13353
San Francisco International	San Francisco, CA	1-morning	14.2314	31747
John F. Kennedy International	New York, NY	1-morning	11.6657	34571
Dallas/Fort Worth International	Dallas/Fort Worth, TX	1-morning	11.3024	103726
Chicago O'Hare International	Chicago, IL	1-morning	11.0928	57578
Philadelphia International	Philadelphia, PA	1-morning	10.6010	41142
LaGuardia	New York, NY	1-morning	10.1623	37325
Miami International	Miami, FL	1-morning	9.2598	37916
Seattle/Tacoma International	Seattle, WA	1-morning	8.8360	31388
Charlotte Douglas International	Charlotte, NC	1-morning	8.6069	72104
*/

/* Answer Q5:
Based on above sections we found that highest number of flights were delayed on 'Hartsfield-Jackson Atlanta International'  in Atlanta, GA (191,222 flights)
 however, the highest average time delay was at  'Newark Liberty International' in 	Newark, NJ (15.7447 average mins delayed)
