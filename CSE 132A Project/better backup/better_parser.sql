SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[parser]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Clearing tables, must be in correct order.
	delete from Orders_Products
	delete from Orders
	delete from Product
	delete from Shipping
	delete from Sub_Category
	delete from Categories

	
	-- Reset next_id table
	update 
		next_id
	set 
		next_id_value=1
	
	-- Declaring variables
	declare @Order_ID		int,
	@Order_Product_ID		int,
	@Order_Date				date,
	@Order_Priority			varchar(50),
	@Order_Quantity			int,
	@Sales					float,
	@Discount				float,
	@Ship_Mode				varchar(50),
	@Profit					float,
	@Unit_Price				float,
	@Shipping_Cost			float,
	@Province				varchar(50),
	@Region					varchar(50),
	@Product_Category		varchar(50),
	@Product_Sub_Category	varchar(500),
	@Product_Name			varchar(500),
	@Product_Container		varchar(500),
	@Ship_Date				date
	
	-- Other ids
	declare @shipping_id	int,
	@category_id			int,
	@product_id				int,
	@sub_category_id		int
	
	declare @exist			int
	
	declare curs1 cursor
	for
	select
		Order_ID,
		Order_Product_ID,
		Order_Date,
		Order_Priority,
		Order_Quantity,
		Sales,
		Discount,
		Ship_Mode,
		Profit,
		Unit_Price,
		Shipping_Cost,
		Province,
		Region,
		Product_Category,
		Product_Sub_Category,
		Product_Name,
		Product_Container,
		Ship_Date
	from
		data

	open curs1
	

	
	-- Inserting into the various tables...
	fetch next from curs1 into @Order_ID, @Order_Product_ID, @Order_Date, @Order_Priority, @Order_Quantity, @Sales, @Discount, @Ship_Mode, @Profit, @Unit_Price, @Shipping_Cost, @Province, @Region, @Product_Category, @Product_Sub_Category, @Product_Name, @Product_Container, @Ship_Date
	while (@@FETCH_STATUS = 0)
	begin 
		
		-- Insert into orders
		if(not exists(select * from Orders where orders_id=@Order_ID))
		begin
			exec insert_orders @Order_ID, @Order_Date, @Order_Priority
		end
		
		-- Insert into Shipping
		
		select
			@shipping_id = null
			
		select
			@shipping_id = shipping_id
		from
			Shipping
		where
			shipping_id = @shipping_id
			and ship_date = @Ship_Date
			and mode = @Ship_Mode
			and cost = @Shipping_Cost
			and province = @Province
			and region = @Region
	
			
		if(@shipping_id is null)
		begin
			exec insert_shipping @Ship_Date, @Ship_Mode, @Shipping_Cost, @shipping_id output, @Province, @Region
		end
		
		
		-- Insert into categories
		select
			@category_id = null
		
		select
			@category_id = category_id
		from
			Categories
		where
			category_name = @Product_Category
			
		if(@category_id is null)
		begin
			exec insert_catagory @Product_Category, @category_id output
		end
		
		-- Insert into sub-categories
		select
			@sub_category_id = null
			
		select
			@sub_category_id = sub_category_id
		from
			Sub_Category
		where
			sub_category_id = @sub_category_id
			and category_id = @category_id
		
		if(@sub_category_id is null)
		begin
			exec insert_sub_catagory @Product_Sub_Category, @category_id, @sub_category_id
		end
		
		-- Insert into Products
		select
			@product_id = null
			
		select
			@product_id = product_id
		from 
			Product
		where
			product_name = @Product_Name
			and container = @Product_Container
			and category_id = @category_id
			and unit_price = @Unit_Price
		
		if(@product_id is null)
		begin
			exec insert_product @Product_Name, @Product_Container, @Order_ID, @category_id, @Unit_Price, @product_id output
		end
		
		
		-- Insert into Orders Products
		
		select
			@exist = COUNT(*)
		from
			Orders_Products
		where
			product_id = @product_id
			and orders_id = @Order_ID
			
		if(@exist = 0)
		begin
			exec insert_orders_products @Order_Quantity, @Sales, @Discount, @shipping_id, @Profit, @product_id, @Order_ID, @Order_Product_ID
		end
					
		-- Get the next position in the cursor
		fetch next from curs1 into @Order_ID, @Order_Product_ID, @Order_Date, @Order_Priority, @Order_Quantity, @Sales, @Discount, @Ship_Mode, @Profit, @Unit_Price, @Shipping_Cost, @Province, @Region, @Product_Category, @Product_Sub_Category, @Product_Name, @Product_Container, @Ship_Date
	end
	
	close curs1
	deallocate curs1
	
		
END
GO