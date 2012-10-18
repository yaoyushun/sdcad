ALTER TABLE [dpt] 
        ADD 	[stra_no] [varchar] (10) NULL ,
	            [sub_no] [varchar] (4) NULL 
GO

ALTER TABLE [TeZhengShuTmp] 
        ADD dpt_real_num decimal(8, 1) null
 
GO