select 
	Orders.orders_id
	,Orders_Products.order_product_id
	,Orders.[date]
	,Orders.priority
	,Orders_Products.quantity
	,Orders_Products.sales
	,Orders_Products.discount
	,Shipping.mode
	,Orders_Products.profit
	,Product.unit_price
	,Shipping.cost
	,Shipping.province
	,Shipping.region
	,Categories.category_name
	,Sub_Category.sub_category_name
	,Product.product_name	
	,Product.container
	,Shipping.ship_date
from
	Orders_Products
join Product
	on Product.product_id=Orders_Products.product_id
join Sub_Category
	on Orders_Products.order_product_id=Sub_Category.sub_category_id
join Orders
	on Orders.orders_id=Orders_Products.orders_id
join Categories
	on Categories.category_id=Product.category_id
join Shipping
	on Shipping.shipping_id=Orders_Products.shipping_id
order by Orders_Products.order_product_id