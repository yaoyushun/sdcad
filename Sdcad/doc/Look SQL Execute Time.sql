declare @dt1 datetime
set @dt1=getdate()
select * from cpt
print datediff(ms,@dt1,getdate())
