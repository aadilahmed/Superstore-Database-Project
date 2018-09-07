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
CREATE PROCEDURE insert_shipping
	-- Add the parameters for the stored procedure here
	@ship_date date,
	@ship_mode varchar(50),
	@ship_cost float,
	@shipping_id int output,
	@ship_province varchar(50),
	@ship_region varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN		
		if (@shipping_id > 0)
		begin
			insert Shipping
			(
			ship_date,
			[mode],
			cost,
			shipping_id,
			province,
			region
			)
			select
				@ship_date,
				@ship_mode,
				@ship_cost,
				@shipping_id,
				@ship_province,
				@ship_region
		end
		commit
	END TRY
	BEGIN CATCH
	END CATCH
END
GO
