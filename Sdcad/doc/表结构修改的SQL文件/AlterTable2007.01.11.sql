ALTER TABLE [earthsample] 
        ADD yssy_yali varchar(176) null,
            yssy_bxl varchar(176) null,
            yssy_kxb varchar(176) null,
            yssy_ysxs varchar(176) null,
            yssy_ysml varchar(176) null 
 
GO

CREATE TABLE [FenCengYaSuo] (
	[prj_no] [varchar] (18) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[stra_no] [varchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[sub_no] [varchar] (4) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[yssy_yali] [varchar] (176) COLLATE Chinese_PRC_CI_AS NULL ,
	[yssy_bxl] [varchar] (176) COLLATE Chinese_PRC_CI_AS NULL ,
	[yssy_kxb] [varchar] (176) COLLATE Chinese_PRC_CI_AS NULL ,
	[yssy_ysxs] [varchar] (176) COLLATE Chinese_PRC_CI_AS NULL ,
	[yssy_ysml] [varchar] (176) COLLATE Chinese_PRC_CI_AS NULL ,
	CONSTRAINT [PK_FenCengYaSuo] PRIMARY KEY  CLUSTERED 
	(
		[prj_no],
		[stra_no],
		[sub_no]
	)  ON [PRIMARY] ,
	CONSTRAINT [FK_FenCengYaSuo_projects] FOREIGN KEY 
	(
		[prj_no]
	) REFERENCES [projects] (
		[prj_no]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
) ON [PRIMARY]
GO

ALTER TABLE [section] 
        ADD Cpt_print_scale int null 
GO