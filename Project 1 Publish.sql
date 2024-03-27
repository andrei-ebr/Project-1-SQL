SELECT
	orders.region,
	people.person AS regional_manager,
	ROUND((COUNT (DISTINCT returns.order_id)::numeric / COUNT(DISTINCT orders.order_id)) * 100, 1) || '%' AS return_count_rate,
	ROUND((SUM(
		CASE
			WHEN returns.returned = 'Yes' THEN orders.sales
			ELSE 0
		END
	)::numeric / SUM(sales)::numeric) * 100, 1) || '%' AS return_sales_rate
FROM orders
LEFT JOIN returns
	ON orders.order_id = returns.order_id
LEFT JOIN people
	ON people.region = orders.region
GROUP BY orders.region, people.person
ORDER BY orders.region;

SELECT
	category,
	SUM(profit) AS total_profit,
	ROUND(SUM(profit)::numeric / COUNT(order_id), 2) AS profit_per_order,
	ROUND(SUM(profit)::numeric / SUM(quantity), 2) AS profit_per_unit
FROM orders
GROUP BY category;

SELECT
	category,
	sub_category,
	SUM(profit) AS total_profit,
	ROUND(SUM(profit)::numeric / COUNT(order_id), 2) AS profit_per_order,
	ROUND(SUM(profit)::numeric / SUM(quantity), 2) AS profit_per_unit
FROM orders
GROUP BY category, sub_category
ORDER BY 1, 5;