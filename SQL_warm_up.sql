-- "Some" Operator
-- "Some" is almost works as "Any" for SQL.
-- Q: Find the film with rating higher than film with replacement cost over 15 dollars. 

SELECT title, rating
FROM film
WHERE rating > SOME (
    SELECT rating
    FROM film
    WHERE replacement_cost > 15
);


-- "CTE" and "Concat" Operator
-- Q: Find the actor who played the most films.
-- We may want to use CTE here to find the times actors appear in all films, and finally connect the full name with ”Concat” operator.
WITH Frequency AS(
SELECT actor_id, COUNT(f.film_id) AS participation
FROM film AS f 
JOIN film_actor AS fa ON f.film_id = fa.film_id
GROUP BY fa.Actor_id
ORDER BY COUNT(actor_id) ASC)

SELECT f.actor_id, concat(ac.first_name,' ', ac.last_name), f.participation FROM Frequency AS f
JOIN actor AS ac ON ac.actor_id = f.actor_id;


-- "Group by" and "Order by" clause filtered by "Having" instead of "Where"
-- Q: Find customers with higher average cost.

Select c.first_name, c.customer_id, AVG(amount) As AC
From customer AS c 
Join payment AS p on c.customer_id = p.customer_id
Group by c.customer_id
Having AVG(amount) > 5
Order by AVG(amount) DESC



-- Be careful when we deal with "NULL" value, we prefer "Is" instead of "=".
-- Q: Find the number of rental not be returned yet
SELECT COUNT(customer_id)
FROM rental
WHERE return_date IS NULL

SELECT COUNT(customer_id)
FROM rental
WHERE return_date IS NOT NULL



-- "Exists" Operator
-- Q:Find customers’ first names who return before 2007 and the store id

SELECT first_name, store_id
FROM customer
WHERE EXISTS (SELECT return_date FROM rental WHERE customer.customer_id = rental.customer_id AND rental_date < '2007-01-01')



