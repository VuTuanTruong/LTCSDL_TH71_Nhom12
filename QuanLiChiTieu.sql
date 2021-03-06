USE [QuanLyChiTieu]
GO
/****** Object:  Table [dbo].[Chi_Tieu]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chi_Tieu](
	[MaChi] [int] NOT NULL,
	[SoTien] [int] NULL,
	[NgayChi] [date] NULL,
	[MaND] [int] NULL,
 CONSTRAINT [PK_Chi_Tieu] PRIMARY KEY CLUSTERED 
(
	[MaChi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Noi_Dung]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Noi_Dung](
	[MaND] [int] NOT NULL,
	[TenND] [nvarchar](50) NULL,
 CONSTRAINT [PK_Noi_Dung] PRIMARY KEY CLUSTERED 
(
	[MaND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tai_Khoan]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tai_Khoan](
	[ID] [int] NOT NULL,
	[TenTK] [nchar](30) NOT NULL,
	[MatKhauTK] [nchar](30) NOT NULL,
 CONSTRAINT [PK_Tai_Khoan] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Thong_Ke_Chi_Tieu]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thong_Ke_Chi_Tieu](
	[MaTk] [int] NOT NULL,
	[MaChi] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Thong_Ke_Thu_Nhap]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thong_Ke_Thu_Nhap](
	[MaTK] [int] NOT NULL,
	[MaThu] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Thong_TIn_TK]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thong_TIn_TK](
	[MaTK] [int] NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[QueQuan] [nvarchar](50) NULL,
	[MaID] [int] NOT NULL,
 CONSTRAINT [PK_Thong_TIn_TK] PRIMARY KEY CLUSTERED 
(
	[MaTK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Thu_Nhap]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thu_Nhap](
	[MaThu] [int] NOT NULL,
	[SoTien] [int] NULL,
	[NgayThu] [date] NULL,
	[MaND] [int] NULL,
 CONSTRAINT [PK_Thu_Nhap] PRIMARY KEY CLUSTERED 
(
	[MaThu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_TongChi]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_TongChi]
AS
SELECT        dbo.Thong_TIn_TK.HoTen, dbo.Chi_Tieu.SoTien, dbo.Chi_Tieu.NgayChi, dbo.Noi_Dung.TenND, dbo.Thong_TIn_TK.MaTK
FROM            dbo.Chi_Tieu INNER JOIN
                         dbo.Thong_Ke_Chi_Tieu ON dbo.Chi_Tieu.MaChi = dbo.Thong_Ke_Chi_Tieu.MaChi INNER JOIN
                         dbo.Thong_TIn_TK ON dbo.Thong_Ke_Chi_Tieu.MaTk = dbo.Thong_TIn_TK.MaTK INNER JOIN
                         dbo.Tai_Khoan ON dbo.Thong_TIn_TK.MaID = dbo.Tai_Khoan.ID INNER JOIN
                         dbo.Noi_Dung ON dbo.Chi_Tieu.MaND = dbo.Noi_Dung.MaND

GO
/****** Object:  View [dbo].[View_TongThu]    Script Date: 6/23/2020 12:31:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_TongThu]
AS
SELECT        dbo.Thong_TIn_TK.HoTen, dbo.Thu_Nhap.SoTien, dbo.Thu_Nhap.NgayThu, dbo.Noi_Dung.TenND, dbo.Thong_Ke_Thu_Nhap.MaTK
FROM            dbo.Thong_TIn_TK INNER JOIN
                         dbo.Tai_Khoan ON dbo.Thong_TIn_TK.MaID = dbo.Tai_Khoan.ID INNER JOIN
                         dbo.Thong_Ke_Thu_Nhap ON dbo.Thong_TIn_TK.MaTK = dbo.Thong_Ke_Thu_Nhap.MaTK INNER JOIN
                         dbo.Thu_Nhap ON dbo.Thong_Ke_Thu_Nhap.MaThu = dbo.Thu_Nhap.MaThu INNER JOIN
                         dbo.Noi_Dung ON dbo.Thu_Nhap.MaND = dbo.Noi_Dung.MaND

GO
INSERT [dbo].[Chi_Tieu] ([MaChi], [SoTien], [NgayChi], [MaND]) VALUES (0, 30000, CAST(N'2020-06-13' AS Date), 0)
INSERT [dbo].[Chi_Tieu] ([MaChi], [SoTien], [NgayChi], [MaND]) VALUES (2, 300000, CAST(N'2020-06-11' AS Date), 1)
INSERT [dbo].[Chi_Tieu] ([MaChi], [SoTien], [NgayChi], [MaND]) VALUES (3, 200000, CAST(N'2020-06-10' AS Date), 3)
INSERT [dbo].[Chi_Tieu] ([MaChi], [SoTien], [NgayChi], [MaND]) VALUES (4, 15000, CAST(N'2020-06-09' AS Date), 4)
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (0, N'Ăn uống')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (1, N'Mua sắm')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (2, N'Lương')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (3, N'Hoá đơn điện')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (4, N'Hoá đơn nước')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (5, N'Tiền nhà')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (6, N'Lãi')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (7, N'Thưởng')
INSERT [dbo].[Noi_Dung] ([MaND], [TenND]) VALUES (8, N'Khác')
INSERT [dbo].[Tai_Khoan] ([ID], [TenTK], [MatKhauTK]) VALUES (0, N'minh0                         ', N'12121                         ')
INSERT [dbo].[Tai_Khoan] ([ID], [TenTK], [MatKhauTK]) VALUES (1, N'minh1                         ', N'2111                          ')
INSERT [dbo].[Tai_Khoan] ([ID], [TenTK], [MatKhauTK]) VALUES (2, N'minh2                         ', N'2610                          ')
INSERT [dbo].[Thong_Ke_Chi_Tieu] ([MaTk], [MaChi]) VALUES (0, 2)
INSERT [dbo].[Thong_Ke_Chi_Tieu] ([MaTk], [MaChi]) VALUES (0, 2)
INSERT [dbo].[Thong_Ke_Chi_Tieu] ([MaTk], [MaChi]) VALUES (1, 3)
INSERT [dbo].[Thong_Ke_Chi_Tieu] ([MaTk], [MaChi]) VALUES (1, 4)
INSERT [dbo].[Thong_Ke_Chi_Tieu] ([MaTk], [MaChi]) VALUES (2, 0)
INSERT [dbo].[Thong_Ke_Chi_Tieu] ([MaTk], [MaChi]) VALUES (2, 4)
INSERT [dbo].[Thong_Ke_Thu_Nhap] ([MaTK], [MaThu]) VALUES (0, 1)
INSERT [dbo].[Thong_Ke_Thu_Nhap] ([MaTK], [MaThu]) VALUES (0, 3)
INSERT [dbo].[Thong_Ke_Thu_Nhap] ([MaTK], [MaThu]) VALUES (1, 1)
INSERT [dbo].[Thong_Ke_Thu_Nhap] ([MaTK], [MaThu]) VALUES (1, 2)
INSERT [dbo].[Thong_TIn_TK] ([MaTK], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [MaID]) VALUES (0, N'Phạm Tuấn Minh', CAST(N'1999-11-21' AS Date), 0, N'Thái Bình', 0)
INSERT [dbo].[Thong_TIn_TK] ([MaTK], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [MaID]) VALUES (1, N'Nguyễn Lan', CAST(N'1999-01-01' AS Date), 1, N'TP.Hồ Chí Minh', 1)
INSERT [dbo].[Thong_TIn_TK] ([MaTK], [HoTen], [NgaySinh], [GioiTinh], [QueQuan], [MaID]) VALUES (2, N'Lê Tuấn', CAST(N'1999-02-02' AS Date), 0, N'Huế', 2)
INSERT [dbo].[Thu_Nhap] ([MaThu], [SoTien], [NgayThu], [MaND]) VALUES (0, 30000000, CAST(N'2020-06-01' AS Date), 2)
INSERT [dbo].[Thu_Nhap] ([MaThu], [SoTien], [NgayThu], [MaND]) VALUES (1, 50000000, CAST(N'2020-06-01' AS Date), 2)
INSERT [dbo].[Thu_Nhap] ([MaThu], [SoTien], [NgayThu], [MaND]) VALUES (2, 50000000, CAST(N'2020-06-01' AS Date), 6)
INSERT [dbo].[Thu_Nhap] ([MaThu], [SoTien], [NgayThu], [MaND]) VALUES (3, 50000000, CAST(N'2020-06-01' AS Date), 7)
ALTER TABLE [dbo].[Chi_Tieu]  WITH CHECK ADD  CONSTRAINT [FK_Chi_Tieu_Noi_Dung] FOREIGN KEY([MaND])
REFERENCES [dbo].[Noi_Dung] ([MaND])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chi_Tieu] CHECK CONSTRAINT [FK_Chi_Tieu_Noi_Dung]
GO
ALTER TABLE [dbo].[Thong_Ke_Chi_Tieu]  WITH CHECK ADD  CONSTRAINT [FK_Thong_Ke_Chi_Tieu_Chi_Tieu] FOREIGN KEY([MaChi])
REFERENCES [dbo].[Chi_Tieu] ([MaChi])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Thong_Ke_Chi_Tieu] CHECK CONSTRAINT [FK_Thong_Ke_Chi_Tieu_Chi_Tieu]
GO
ALTER TABLE [dbo].[Thong_Ke_Chi_Tieu]  WITH CHECK ADD  CONSTRAINT [FK_Thong_Ke_Chi_Tieu_Thong_TIn_TK] FOREIGN KEY([MaTk])
REFERENCES [dbo].[Thong_TIn_TK] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Thong_Ke_Chi_Tieu] CHECK CONSTRAINT [FK_Thong_Ke_Chi_Tieu_Thong_TIn_TK]
GO
ALTER TABLE [dbo].[Thong_Ke_Thu_Nhap]  WITH CHECK ADD  CONSTRAINT [FK_Thong_Ke_Thu_Nhap_Thong_TIn_TK] FOREIGN KEY([MaTK])
REFERENCES [dbo].[Thong_TIn_TK] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Thong_Ke_Thu_Nhap] CHECK CONSTRAINT [FK_Thong_Ke_Thu_Nhap_Thong_TIn_TK]
GO
ALTER TABLE [dbo].[Thong_Ke_Thu_Nhap]  WITH CHECK ADD  CONSTRAINT [FK_Thong_Ke_Thu_Nhap_Thu_Nhap] FOREIGN KEY([MaThu])
REFERENCES [dbo].[Thu_Nhap] ([MaThu])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Thong_Ke_Thu_Nhap] CHECK CONSTRAINT [FK_Thong_Ke_Thu_Nhap_Thu_Nhap]
GO
ALTER TABLE [dbo].[Thong_TIn_TK]  WITH CHECK ADD  CONSTRAINT [FK_Thong_TIn_TK_Tai_Khoan] FOREIGN KEY([MaID])
REFERENCES [dbo].[Tai_Khoan] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Thong_TIn_TK] CHECK CONSTRAINT [FK_Thong_TIn_TK_Tai_Khoan]
GO
ALTER TABLE [dbo].[Thu_Nhap]  WITH CHECK ADD  CONSTRAINT [FK_Thu_Nhap_Noi_Dung] FOREIGN KEY([MaND])
REFERENCES [dbo].[Noi_Dung] ([MaND])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Thu_Nhap] CHECK CONSTRAINT [FK_Thu_Nhap_Noi_Dung]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Chi_Tieu"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Thong_Ke_Chi_Tieu"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Thong_TIn_TK"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 232
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tai_Khoan"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Noi_Dung"
            Begin Extent = 
               Top = 234
               Left = 246
               Bottom = 330
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TongChi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'50
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TongChi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TongChi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Thong_TIn_TK"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tai_Khoan"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Thong_Ke_Thu_Nhap"
            Begin Extent = 
               Top = 120
               Left = 246
               Bottom = 216
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Thu_Nhap"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Noi_Dung"
            Begin Extent = 
               Top = 216
               Left = 246
               Bottom = 312
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TongThu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TongThu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TongThu'
GO
