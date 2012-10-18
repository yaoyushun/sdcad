ALTER TABLE [earthtype] 
        ADD ea_name_en varchar(30) null
 
GO

ALTER TABLE [projects] 
        ADD prj_name_en varchar(50) null
 
GO

ALTER TABLE [stratum_description] 
        ADD description_en varchar(300) null
 
GO

ALTER TABLE [stratum] 
        ADD description_en varchar(300) null
 
GO

ALTER TABLE [legend_type] 
        ADD l_name_en varchar(50) null
 
GO