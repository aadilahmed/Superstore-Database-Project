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
CREATE PROCEDURE insert_sub_catagory
	-- Add the parameters for the stored procedure here
	@sub_category_name varchar(50),
	@category_id int,
	@sub_category_id int output
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			exec Superstore.dbo.get_next_id 'sub_category', @sub_category_id output
		
		if (@sub_category_id > 0)
		begin
			insert Sub_Category
			(
			sub_category_name,
			category_id,
			sub_category_id
			)
			select
				@sub_category_name,
				@category_id,
				@sub_category_id
		end
		commit
	END TRY
	BEGIN CATCH
	END CATCH
END
GO
