/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */



SELECT DISTINCT UPPER(a.first_name || ' ' || a.last_name) AS "Actor Name"
FROM film_actor fa
JOIN film_actor fb ON fa.film_id = fb.film_id
JOIN actor a ON fb.actor_id = a.actor_id
WHERE fa.actor_id IN (
  -- Bacall Number 1: all actors who appeared with Russell Bacall
  SELECT DISTINCT fa1.actor_id
  FROM film_actor fa1
  JOIN film_actor fb1 ON fa1.film_id = fb1.film_id
  JOIN actor r ON fb1.actor_id = r.actor_id
  WHERE r.first_name = 'RUSSELL'
    AND r.last_name = 'BACALL'
)
  -- Exclude actors who have already appeared with Russell (Bacall Number 1) using NOT EXISTS
  AND NOT EXISTS (
    SELECT 1
    FROM film_actor fa1
    JOIN film_actor fb1 ON fa1.film_id = fb1.film_id
    JOIN actor r ON fb1.actor_id = r.actor_id
    WHERE r.first_name = 'RUSSELL'
      AND r.last_name = 'BACALL'
      AND fa1.actor_id = a.actor_id
  )
  -- Also exclude Russell Bacall himself using NOT EXISTS
  AND NOT EXISTS (
    SELECT 1
    FROM actor r
    WHERE r.first_name = 'RUSSELL'
      AND r.last_name = 'BACALL'
      AND a.actor_id = r.actor_id
  )
ORDER BY "Actor Name";

