-- For a high-level overview of the hotels, provide us the top 5 most voted hotels in the delivery category.
select distinct name, votes, rating
from zomato
where type = 'delivery'
order by votes desc
limit 5;

-- The rating of a hotel is a key identifier in determining a restaurant’s performance. 
-- Hence for a particular location called Banashankari find out the top 5 highly rated hotels in the delivery category.
select distinct name, rating, location, type
from zomato
where type = 'delivery' and location = 'Banashankari'
order by rating desc 
limit 5;

-- compare the ratings of the cheapest and most expensive hotels in Indiranagar.
select distinct (Select distinct rating from zomato where rating = 3.6 and location = 'indiranagar') ranking1,
first_value(rating) over ( order by approx_cost) rating2
from zomato
where location = 'Indiranagar';

-- Online ordering of food has exponentially increased over time. 
-- Compare the total votes of restaurants that provide online ordering services and those who don’t provide online ordering service.
select sum(votes), online_order as total_votes
from zomato
group by online_order;

-- Number of votes defines how much the customers are involved with the service provided by the restaurants
-- For each Restaurant type, find out the number of restaurants, total votes, and average rating. 
-- Display the data with the highest votes on the top( if the first row of output is NA display the remaining rows).

select type, count(*) number_of_restaurants, 
sum(votes) total_votes, 
avg(rating) avg_rating
from zomato
group by type
having type != 'NA'
order by total_votes desc;

-- What is the most liked dish of the most-voted restaurant on Zomato(as the restaurant has a tie-up with Zomato, 
-- the restaurant compulsorily provides online ordering and delivery facilities.
select name, dish_liked, rating, votes
from zomato
where online_order = 'yes'
order by votes desc 
limit 1;

-- To increase the maximum profit, Zomato is in need to expand its business. For doing so Zomato wants 
-- the list of the top 15 restaurants which have min 150 votes, have a rating greater than 3, and is 
-- currently not providing online ordering. Display the restaurants with highest votes on the top.
select name, votes, rating, online_order
from zomato
where rating > 3 and online_order = 'no' and votes >=150
order by votes desc
limit 15;