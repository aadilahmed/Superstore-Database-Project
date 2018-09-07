SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE insert_product
	-- Add the parameters for the stored procedure here
	@product_name varchar(50),
	@container varchar(50),
	@orders_id int,
	@category_id int,
	@unit_price float,
	@product_id int output
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
		exec Superstore.dbo.get_next_id 'product', @product_id output
		
		if (@product_id > 0)
		begin
			insert Product
			(
				product_name,
				container,
				category_id,
				unit_price,
				product_id
			)
			select
				@product_name,
				@container,
				@category_id,
				@unit_price,
				@product_id
		end
		commit
	END TRY
	BEGIN CATCH
	END CATCH
END
GO
