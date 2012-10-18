ALTER TABLE [projects] 
        ADD [isGongDian] [bit] null 
GO
ALTER TABLE [stratum] 
        ADD [stra_qpk] [int] null,
            [stra_es1_2] [numeric](18, 1) NULL,
            [stra_zlmd] [numeric](18, 1) NULL,
            [stra_djt_njlbzz] [int] NULL,
            [stra_djt_nmcjbzz] [int] NULL,
            [stra_zkgzz] [int] NULL
GO
ALTER TABLE [stratum_description] 
        ADD [stra_qpk] [int] null,
            [stra_es1_2] [numeric](18, 1) NULL,
            [stra_zlmd] [numeric](18, 1) NULL,
            [stra_djt_njlbzz] [int] NULL,
            [stra_djt_nmcjbzz] [int] NULL,
            [stra_zkgzz] [int] NULL
GO