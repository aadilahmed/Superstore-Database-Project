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
CREATE PROCEDURE insert_orders
	-- Add the parameters for the stored procedure here
	@orders_id int,
	@order_date date,
	@order_priority varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN		
		if (@orders_id > 0)
		begin
			insert Orders
			(
			orders_id,
			[date],
			priority
			)
			select
				@orders_id,
				@order_date,
				@order_priority
		end
		commit
	END TRY
	BEGIN CATCH
	END CATCH
END
GO
