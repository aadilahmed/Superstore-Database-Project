DBCC CHECKIDENT('dimTime', RESEED, 0)

delete from dimTime

declare @start_date datetime,
    @end_date datetime,
    @increment datetime

select @increment = '01/01/2014'
select @end_date = '12/31/2016'

while(@increment < @end_date)
begin
    insert dimTime(
        date_key
        )
    select
        @increment

    select @increment = DATEADD(DAY, 1, @increment)
end

update dimTime set day_name = CONVERT(varchar, date_key, 106)

update dimTime set year_key = DATEPART(year, date_key)

update dimTime set year_name = DATEPART(year, date_key)

update dimTime set month_key =
SUBSTRING(replace(convert(varchar, date_key, 102),'.',''),0, 7) 

update dimTime set month_name =
replace(SUBSTRING(convert(varchar,date_key,106),4,8),'','-')

update dimTime set quarter_key =
convert(varchar,DATEPART(year,date_key))
+ CONVERT(varchar, DATEPART(quarter, date_key))

update dimTime set day_of_week_name =
    case DATEPART(weekday,date_key)
    when 1 then 'Sunday'
    when 2 then 'Monday'
    when 3 then 'Tuesday'
    when 4 then 'Wednesday'
    when 5 then 'Thursday'
    when 6 then 'Friday'
    when 7 then 'Saturday'
    end