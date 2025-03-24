/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */


SELECT name, title, "total rentals"
FROM (
    SELECT cat.name,
           f.title,
           COUNT(r.rental_id) AS "total rentals",
           RANK() OVER (PARTITION BY cat.name ORDER BY COUNT(r.rental_id) DESC, f.title DESC) AS rank
    FROM category cat
    JOIN film_category fc ON cat.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY cat.name, f.title
) AS ranked_films
WHERE rank <= 5
ORDER BY name, "total rentals" DESC, title;

