DBCC CHECKIDENT('dimGender', RESEED, 0)

delete from dimGender

insert dimGender(gender_key, gender_name)
select 0, "Unknown"

insert dimGender(gender_key, gender_name)
select 1, "Male"

insert dimGender(gender_key, gender_name)
select 2, "Female"