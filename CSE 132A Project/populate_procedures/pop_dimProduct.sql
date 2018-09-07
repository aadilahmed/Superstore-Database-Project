DBCC CHECKIDENT('dimProduct', RESEED, 0)

delete from dimProduct

insert dimProduct
(
	product_key,
	product_name
)
select 
	product_id,
	product_name
from
	superstore_report.dbo.customer