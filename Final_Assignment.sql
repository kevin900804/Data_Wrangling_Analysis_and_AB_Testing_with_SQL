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
