-- 1.
-- Compare the final_assignments_qa table to the assignment events we captured for user_level_testing. 
-- Write an answer to the following question: Does this table have everything you need to compute metrics like 30-day view-binary?

-- No, The created_at date is needed.


-- 2.
-- Write a query and table creation statement to make final_assignments_qa look like the final_assignments table.
-- If you discovered something missing in part 1, you may fill in the value with a place holder of the appropriate data type.

(
  SELECT
    item_id,
    test_a AS test_assignment,
    COALESCE('test_a') AS test_number,
    COALESCE('2013-01-05 00:00:00') AS test_start_day
  FROM
    dsv1069.final_assignments_qa
  UNION
  SELECT
    item_id,
    test_b AS test_assignment,
    COALESCE('test_b') AS test_number,
    COALESCE('2013-01-05 00:00:00') AS test_start_day
  FROM
    dsv1069.final_assignments_qa
  UNION
  SELECT
    item_id,
    test_c AS test_assignment,
    COALESCE('test_c') AS test_number,
    COALESCE('2013-01-05 00:00:00') AS test_start_day
  FROM
    dsv1069.final_assignments_qa
  UNION
  SELECT
    item_id,
    test_d AS test_assignment,
    COALESCE('test_d') AS test_number,
    COALESCE('2013-01-05 00:00:00') AS test_start_day
  FROM
    dsv1069.final_assignments_qa
  UNION
  SELECT
    item_id,
    test_e AS test_assignment,
    COALESCE('test_e') AS test_number,
    COALESCE('2013-01-05 00:00:00') AS test_start_day
  FROM
    dsv1069.final_assignments_qa
  UNION
  SELECT
    item_id,
    test_f AS test_assignment,
    COALESCE('test_f') AS test_number,
    COALESCE('2013-01-05 00:00:00') AS test_start_day
  FROM
    dsv1069.final_assignments_qa
)
ORDER BY
  test_number
 
 
-- 3.
-- Use the final_assignments table to calculate the order binary for the 30 day window after the test assignment for item_test_2
-- (You may include the day the test started)

SELECT
  COUNT(item_id) AS totalnum_items,
  SUM(order_binary) AS items_ordered_30d
FROM
  (
    SELECT
      item_id,
      MAX(
        CASE
          WHEN date(created_at) - date(test_start_date) <= 30
          AND date(created_at) >= date(test_start_date) THEN 1
          ELSE 0
        END
      ) AS order_binary
    FROM
      (
        SELECT
          final_assignments.item_id,
          test_start_date,
          created_at
        FROM
          dsv1069.final_assignments
          LEFT JOIN dsv1069.orders ON final_assignments.item_id = orders.item_id
        WHERE
          test_number = 'item_test_2'
          AND test_assignment = '1'
      ) AS item_test_2
    GROUP BY
      item_id
  ) AS result


-- 4.
-- Use the final_assignments table to calculate the view binary, and average views for the 30 day window after the test assignment for item_test_2.
-- (You may include the day the test started)

SELECT
  item_id,
  MAX(
    CASE
      WHEN date(event_time) - date(test_start_date) <= 30
      AND date(event_time) >= date(test_start_date) THEN 1
      ELSE 0
    END
  ) AS view_binary,
  SUM(
    CASE
      WHEN date(event_time) - date(test_start_date) <= 30
      AND date(event_time) >= date(test_start_date) THEN 1
      ELSE 0
    END
  ) AS total_views,
  SUM(
    CASE
      WHEN date(event_time) - date(test_start_date) <= 30
      AND date(event_time) >= date(test_start_date) THEN (1/30.0)
      ELSE 0
    END
  ) AS avg_views
FROM
  (
    SELECT
      final_assignments.item_id,
      test_start_date,
      event_time,
      test_assignment
    FROM
      dsv1069.final_assignments
      LEFT JOIN (
        SELECT
          CAST(parameter_value AS FLOAT) AS item_id,
          event_time
        FROM
          dsv1069.events
        WHERE
          event_name = 'view_item'
          AND parameter_name = 'item_id'
      ) AS viewitems ON final_assignments.item_id = viewitems.item_id
    WHERE
      test_number = 'item_test_2'
  ) AS item_test_2
GROUP BY
  item_id,
  test_assignment
HAVING
  test_assignment != '0'
  
