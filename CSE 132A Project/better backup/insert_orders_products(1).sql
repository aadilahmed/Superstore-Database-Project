-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[insert_orders_products]
	@quantity int,
	@sales float,
	@discount float,
	@shipping_id int,
	@profit float,
	@product_id int,
	@order_id int,
	@order_product_id int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    begin try
		begin tran
		
		exec Superstore.dbo.get_next_id 'orders_products', @order_product_id
		
		if(@order_product_id > 0)
		begin
			insert Orders_Products
			(
				order_product_id,
				quantity,
				sales,
				discount,
				shipping_id,
				profit,
				product_id,
				orders_id
			)
			select
				@order_product_id,
				@quantity,
				@sales,
				@discount,
				@shipping_id,
				@profit,
				@product_id,
				@order_id
			end
			commit		
				
	END TRY
	BEGIN CATCH
	END CATCH						
END
GO
