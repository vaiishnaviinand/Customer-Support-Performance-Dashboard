SELECT
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (
        WHERE ticket_status = 'Closed'
    ) AS closed_tickets,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE ticket_status = 'Closed'
        ) / COUNT(*),
        2
    ) AS closure_rate_pct,
    ROUND(
        AVG(customer_satisfaction_rating)
            FILTER (WHERE ticket_status = 'Closed'),
        2
    ) AS avg_customer_satisfaction,
    COUNT(*) FILTER (
        WHERE ticket_status = 'Open'
    ) AS open_tickets,
    COUNT(*) FILTER (
        WHERE ticket_status = 'Pending Customer Response'
    ) AS pending_tickets
FROM customer_support_tickets;

SELECT
    COUNT(*) AS closed_tickets_with_both_timestamps,
    COUNT(*) FILTER (
        WHERE time_to_resolution < first_response_time
    ) AS suspicious_tickets,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE time_to_resolution < first_response_time
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS suspicious_percentage
FROM customer_support_tickets
WHERE ticket_status = 'Closed'
  AND first_response_time IS NOT NULL
  AND time_to_resolution IS NOT NULL;

  SELECT
    product_purchased,
    COUNT(*) AS closed_tickets,
    ROUND(
        AVG(customer_satisfaction_rating),
        2
    ) AS avg_satisfaction
FROM customer_support_tickets
WHERE ticket_status = 'Closed'
GROUP BY product_purchased
ORDER BY avg_satisfaction ASC;

SELECT
    ticket_priority,
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (
        WHERE ticket_status = 'Closed'
    ) AS closed_tickets,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE ticket_status = 'Closed'
        ) / COUNT(*),
        2
    ) AS closure_rate_pct
FROM customer_support_tickets
GROUP BY ticket_priority
ORDER BY closure_rate_pct DESC;

SELECT
    product_purchased,
    ticket_priority,
    COUNT(*) AS total_tickets
FROM customer_support_tickets
WHERE product_purchased IN (
    'Nintendo Switch Pro Controller',
    'Lenovo ThinkPad',
    'Dell XPS'
)
GROUP BY product_purchased, ticket_priority
ORDER BY product_purchased, total_tickets DESC;

SELECT
    product_purchased,
    ticket_status,
    COUNT(*) AS total_tickets
FROM customer_support_tickets
WHERE product_purchased IN (
    'Nintendo Switch Pro Controller',
    'Lenovo ThinkPad',
    'Dell XPS'
)
GROUP BY product_purchased, ticket_status
ORDER BY product_purchased, ticket_status;

SELECT
    product_purchased,
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (
        WHERE ticket_status = 'Closed'
    ) AS closed_tickets,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE ticket_status = 'Closed'
        ) / COUNT(*),
        2
    ) AS closure_rate_pct
FROM customer_support_tickets
GROUP BY product_purchased
ORDER BY closure_rate_pct ASC;

SELECT
    product_purchased,
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (
        WHERE ticket_status = 'Closed'
    ) AS closed_tickets,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE ticket_status = 'Closed'
        ) / COUNT(*),
        2
    ) AS closure_rate_pct
FROM customer_support_tickets
GROUP BY product_purchased
ORDER BY closure_rate_pct DESC;

SELECT
    product_purchased,
    ticket_status,
    COUNT(*) AS total_tickets
FROM customer_support_tickets
GROUP BY product_purchased, ticket_status
ORDER BY product_purchased, total_tickets DESC;

SELECT
    product_purchased,
    COUNT(*) AS closed_tickets
FROM customer_support_tickets
WHERE ticket_status = 'Closed'
GROUP BY product_purchased
ORDER BY closed_tickets DESC
LIMIT 10;

SELECT
    ticket_status,
    COUNT(*) AS total_tickets,
    COUNT(first_response_time) AS records_with_first_response,
    COUNT(time_to_resolution) AS records_with_resolution_time,
    COUNT(customer_satisfaction_rating) AS rated_tickets
FROM customer_support_tickets
GROUP BY ticket_status
ORDER BY ticket_status;

SELECT
    ticket_priority,
    COUNT(*) AS closed_tickets,
    COUNT(*) FILTER (
        WHERE time_to_resolution < first_response_time
    ) AS suspicious_tickets,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE time_to_resolution < first_response_time
        ) / COUNT(*),
        2
    ) AS suspicious_percentage
FROM customer_support_tickets
WHERE ticket_status = 'Closed'
  AND first_response_time IS NOT NULL
  AND time_to_resolution IS NOT NULL
GROUP BY ticket_priority
ORDER BY suspicious_percentage DESC;

SELECT
    ticket_priority,
    COUNT(*) AS suspicious_tickets
FROM customer_support_tickets
WHERE ticket_status = 'Closed'
  AND first_response_time IS NOT NULL
  AND time_to_resolution IS NOT NULL
  AND time_to_resolution < first_response_time
GROUP BY ticket_priority
ORDER BY suspicious_tickets DESC;

SELECT
    COUNT(*) AS suspicious_timestamp_rows
FROM customer_support_tickets
WHERE ticket_status = 'Closed'
  AND first_response_time IS NOT NULL
  AND time_to_resolution IS NOT NULL
  AND time_to_resolution < first_response_time;

  SELECT
    COUNT(*) AS total_tickets,
    COUNT(*) - COUNT(ticket_priority) AS missing_priority,
    COUNT(*) - COUNT(ticket_channel) AS missing_channel,
    COUNT(*) - COUNT(first_response_time) AS missing_first_response,
    COUNT(*) - COUNT(time_to_resolution) AS missing_resolution_time,
    COUNT(*) - COUNT(customer_satisfaction_rating) AS missing_satisfaction
FROM customer_support_tickets;

SELECT
    customer_satisfaction_rating,
    COUNT(*) AS total_count
FROM customer_support_tickets
WHERE ticket_status = 'Closed'
GROUP BY customer_satisfaction_rating
ORDER BY customer_satisfaction_rating;

