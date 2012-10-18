USE [Geosoft]
GO

/****** Object:  Table [dbo].[TeZhengShuTmp]    Script Date: 02/24/2012 15:28:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TeZhengShuTmp](
	[prj_no] [varchar](18) NOT NULL,
	[stra_no] [varchar](10) NOT NULL,
	[sub_no] [varchar](4) NOT NULL,
	[v_id] [char](1) NOT NULL,
	[aquiferous_rate] [decimal](8, 1) NULL,
	[wet_density] [decimal](8, 2) NULL,
	[dry_density] [decimal](8, 2) NULL,
	[soil_proportion] [decimal](8, 2) NULL,
	[gap_rate] [decimal](8, 3) NULL,
	[gap_degree] [decimal](8, 1) NULL,
	[saturation] [smallint] NULL,
	[liquid_limit] [decimal](8, 1) NULL,
	[shape_limit] [decimal](8, 1) NULL,
	[shape_index] [decimal](8, 1) NULL,
	[liquid_index] [decimal](8, 2) NULL,
	[zip_coef] [decimal](8, 3) NULL,
	[zip_modulus] [decimal](8, 2) NULL,
	[cohesion] [decimal](8, 2) NULL,
	[friction_angle] [decimal](8, 2) NULL,
	[cohesion_gk] [decimal](8, 2) NULL,
	[friction_gk] [decimal](8, 2) NULL,
	[wcx_yuanz] [decimal](8, 1) NULL,
	[wcx_chsu] [decimal](8, 1) NULL,
	[wcx_lmd] [decimal](8, 1) NULL,
	[cpt_qc] [decimal](8, 2) NULL,
	[cpt_fs] [decimal](8, 2) NULL,
	[cpt_ps] [decimal](8, 2) NULL,
	[spt_real_num] [decimal](8, 1) NULL,
	[spt_amend_num] [decimal](8, 2) NULL,
	[dpt_real_num] [decimal](8, 1) NULL,
	[dpt_amend_num] [decimal](8, 1) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO