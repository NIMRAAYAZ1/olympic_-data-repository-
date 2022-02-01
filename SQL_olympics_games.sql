use [portfolio project ]
select * from dbo.athlete_events
select * from  dbo.noc_regions

--Problem Statement:
--1. Write a SQL query to find the total no of Olympic Games held as per the dataset.
select count (distinct(games)) as total_games  
from dbo.athlete_events
--2. Problem Statement: Write a SQL query to list down all the Olympic Games held so far.
select year, season,city 
from dbo.athlete_events
group by year,Season,city 
order by year 
--Another way 
select distinct year, season,city from dbo.athlete_events
order by Year
--3. Mention the total no of nations who participated in each olympics game?
--Problem Statement: SQL query to fetch total no of countries participated 
--in each olympic games.
WITH ALL_COUNTRIES AS 
(select EVENTS.games,REGIONS.region
FROM  dbo.athlete_events AS EVENTS INNER JOIN dbo.noc_regions AS REGIONS 
ON EVENTS.NOC = REGIONS.NOC
GROUP BY EVENTS.games,REGIONS.region)
SELECT games, COUNT(*) AS TOTAL 
FROM ALL_COUNTRIES
GROUP BY games
--4. Which year saw the highest and lowest no of countries participating in olympics
--Problem Statement: Write a SQL query to return the Olympic Games 
--which had the highest participating countries and the lowest participating countries.
with all_countries as
              (select games, nr.region
              from dbo.athlete_events oh
              join dbo.noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
          tot_countries as
              (select games, count(1) as total_countries
              from all_countries
              group by games)
      select distinct
      concat(first_value(games) over(order by total_countries)
      , ' - '
      , first_value(total_countries) over(order by total_countries)) as Lowest_Countries,
      concat(first_value(games) over(order by total_countries desc)
      , ' - '
      , first_value(total_countries) over(order by total_countries desc)) as Highest_Countries
      from tot_countries
      order by 1;
      







