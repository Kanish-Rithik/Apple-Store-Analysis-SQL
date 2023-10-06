Create table appleStore_description_coimbined AS
select * from appleStore_description1
union ALL
select * from appleStore_description2
union ALL
select * from appleStore_description3
union ALL
select * from appleStore_description4

**EXPLORATORY DATA ANALYSIS**

--check the number of unique apps in both tablesAppleStores--

select count(Distinct id) as UniqueAppleIDs
from AppleStore

Select count(Distinct id) as UniqueAppleIDs
from appleStore_description_coimbined

--check for any missing values in key fields--

select count(*) as MissingValues
from AppleStore
where track_name is null or user_rating is null or prime_genre is null

select count(*) as MissingValues
from appleStore_description_coimbined
where app_desc is null

--find out the number of apps per genre--

select prime_genre, count(*) as NumApps
from AppleStore
group by prime_genre
order by NumApps Desc

--get the overview of the app ratting--

select min(user_rating) as MinRating,
       max(user_rating) AS MaxRating,
       avg(user_rating) as AvgRating
from AppleStore

--Determine paid apps have higher rating then free apps--

select CASE
when price > 0 then 'Paid'
else 'Free'
end as App_type,
avg(user_rating) as Avg_Rating
from AppleStore
group by App_type

--checking if apps with more supported language have higher rattings--

select case 
when lang_num < 10 then '<10 languages'
when lang_num between 10 and 30 then '10-30 between'
else '>30 languages'
end as language_bucket,
avg(user_rating) as Avg_rating
from AppleStore
group by Language_bucket
order by Avg_rating Desc

--check genres with low rattings--

select prime_genre,
avg(user_rating) as Avg_Rating
from AppleStore
group by prime_genre
order by Avg_Rating ASC
limit 10

--check if there is correlation between the length of the app description and the use ratting--

select Case
when length(B.app_desc) <500 then 'short'
when length(B.app_desc) BETWEEN 500 and 1000 then 'Medium'
else 'Big'
end as descrption_length_Bucket,
avg(user_rating) as AvgRating
from AppleStore as A
join 
appleStore_description_coimbined as B
on A.id = B.id
group by descrption_length_Bucket
order by AvgRating desc




