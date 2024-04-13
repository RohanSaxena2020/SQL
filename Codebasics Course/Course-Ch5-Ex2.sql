SELECT *, 
CONCAT(name," ",variant_name) as full_name, 
price+variant_price as total_price from food_db.items
CROSS JOIN food_db.variants;