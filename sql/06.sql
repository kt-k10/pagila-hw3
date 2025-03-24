/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */


SELECT DISTINCT UPPER(a.first_name || ' ' || a.last_name) AS "Actor Name"
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a ON fa1.actor_id = a.actor_id
JOIN actor b ON fa2.actor_id = b.actor_id
WHERE b.first_name = 'RUSSELL'
  AND b.last_name = 'BACALL'
  AND NOT (a.first_name = 'RUSSELL' AND a.last_name = 'BACALL')
ORDER BY "Actor Name";

