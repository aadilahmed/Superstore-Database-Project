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
CREATE PROCEDURE insert_product
	-- Add the parameters for the stored procedure here
	@product_name varchar(50),
	@container varchar(50),
	@base_margin float,
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
				base_margin,
				orders_id,
				category_id,
				unit_price,
				product_id
			)
			select
				@product_name,
				@container,
				@base_margin,
				@orders_id,
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
