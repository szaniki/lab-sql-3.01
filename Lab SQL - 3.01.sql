-- Activity 1
USE Sakila;
-- 1. Drop column picture from staff.

ALTER TABLE staff
DROP COLUMN picture;

SELECT * FROM Staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.

INSERT INTO sakila.staff (first_name, last_name, address_id, email, store_id, active, username)
SELECT first_name, last_name, address_id, email, store_id, active, first_name
FROM sakila.customer
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

select *from staff; -- Tammy is added -- ooops, checked 3 times so added 3 times :D 


-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there.
-- You can query those pieces of information. For eg., you would notice that you need customer_id 
-- information as well. To get that you can use the following query:
-- Use similar method to get inventory_id, film_id, and staff_id.


INSERT INTO sakila.rental(rental_date,inventory_id, customer_id, return_date, staff_id)
SELECT CURDATE() AS 'rental_date',i.inventory_id, c.customer_id, CURDATE() + f.rental_duration AS 'return_date', s.staff_id
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN staff s ON s.store_id = s.store_id
INNER JOIN customer c ON c.store_id = s.store_id
WHERE title = 'Academy Dinosaur' AND c.first_name = 'CHARLOTTE' and c.last_name = 'HUNTER'
LIMIT 1;

SELECT * from rental;


---------------------

-- Activity 2: Optimising Sakila db 

-- 1. Concat: Address + City + Country as they belong to the same category
-- 2. Concat: Language + Film; drop language_id as it would be duplicated; 
-- 3. Rename language table last_update to language_last_update
-- 4. Drop Address2 and Location from from address table


