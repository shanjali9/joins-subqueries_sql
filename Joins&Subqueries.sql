-- 1. List all customers who live in Texas (use JOINs)
-- A: 5
-- SELECT COUNT(*) -- to get the exact number.
SELECT * -- to visualize the table of five values.
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
-- A: 1406
SELECT customer.first_name, customer.last_name
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

SELECT COUNT(payment.customer_id)
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
-- A: Six customers
SELECT store_id,first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id,first_name,last_name;

-- 4. List all customers that live in Nepal (use the city table)
-- A: 1 customer.
SELECT store_id,first_name,last_name,address,country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
-- A: John Stephens processed 7,304 transactions/payments.
-- Could use a MAX function here in theory.
SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id)
FROM staff
LEFT JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;

-- 6. How many movies of each rating are there?
-- A: 223 PG-13, 210 NC-17, 195 R, 194 PG, 178 G
SELECT COUNT(film_id), rating
FROM film
GROUP BY rating;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
-- A: 130 customers.

SELECT customer.customer_id, last_name, first_name
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount IN(
	SELECT payment.amount
	FROM payment
	WHERE amount > 6.99
	GROUP BY amount
)
GROUP BY customer.customer_id
HAVING COUNT(amount) = 1;

-- 8. How many free rentals did our stores give away?
-- A: 24
SELECT COUNT(rental_id)
FROM payment
WHERE amount = 0;