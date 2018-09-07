DBCC CHECKIDENT('dimGeography', RESEED, 0)

delete from dimGeography

insert dimGeography
(
	state_key,
	state_name
)
select 
	ROW_NUMBER() OVER (ORDER BY state),
	state
from
	superstore_report.dbo.customer
group by
	state