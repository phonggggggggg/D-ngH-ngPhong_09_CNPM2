USE [QLBanHang]
GO
INSERT [dbo].[Sanpham] ([masp], [mahangsx], [tensp], [soluong], [mausac], [giaban], [donvitinh], [mota]) VALUES (N'SP01      ', N'H02       ', N'F1 Plus', 100, N'Xám', 7000000.0000, N'Chi?c     ', N'Hàng c?n cao c?p')
INSERT [dbo].[Sanpham] ([masp], [mahangsx], [tensp], [soluong], [mausac], [giaban], [donvitinh], [mota]) VALUES (N'SP02      ', N'H01       ', N'Galaxy Note11', 50, N'Ð?', 19000000.0000, N'Chi?c     ', N'Hàng cao c?p')
INSERT [dbo].[Sanpham] ([masp], [mahangsx], [tensp], [soluong], [mausac], [giaban], [donvitinh], [mota]) VALUES (N'SP03      ', N'H02       ', N'F3 lite', 200, N'Nâu', 3000000.0000, N'Chi?c     ', N'Hàng ph? thông')
INSERT [dbo].[Sanpham] ([masp], [mahangsx], [tensp], [soluong], [mausac], [giaban], [donvitinh], [mota]) VALUES (N'SP04      ', N'H03       ', N'Vjoy3', 200, N'Xám', 1500000.0000, N'Chi?c     ', N'Hàng ph? thông')
INSERT [dbo].[Sanpham] ([masp], [mahangsx], [tensp], [soluong], [mausac], [giaban], [donvitinh], [mota]) VALUES (N'SP05      ', N'H01       ', N'Galaxy', 500, N'Nâu', 8000000.0000, N'Chi?c     ', N'Hàng V21 c?n cao c?p')
GO
INSERT [dbo].[Nhanvien] ([manv], [tennv], [gioitinh], [diachi], [sodt], [email], [phong]) VALUES (N'NV01      ', N'Nguy?n Th? Thu', N'N?        ', N'Hà N?i', N'0982626521', N'thu@gmail.com', N'K? toán')
INSERT [dbo].[Nhanvien] ([manv], [tennv], [gioitinh], [diachi], [sodt], [email], [phong]) VALUES (N'NV02      ', N'Lê Van Nam', N'Nam       ', N'B?c Ninh', N'0972525252', N'nam@gmail.com', N'V?t tu')
INSERT [dbo].[Nhanvien] ([manv], [tennv], [gioitinh], [diachi], [sodt], [email], [phong]) VALUES (N'NV03      ', N'Tr?n Hòa Bình', N'N?        ', N'Hà N?i', N'0328388388', N'hb@gmail.com', N'K? toán')
GO
INSERT [dbo].[Xuat] ([sohdx], [masp], [manv], [ngayxuat], [soluongX]) VALUES (N'X01       ', N'SP03      ', N'NV02      ', CAST(N'2020-06-14' AS Date), 5)
INSERT [dbo].[Xuat] ([sohdx], [masp], [manv], [ngayxuat], [soluongX]) VALUES (N'X02       ', N'SP01      ', N'NV03      ', CAST(N'2019-03-05' AS Date), 3)
INSERT [dbo].[Xuat] ([sohdx], [masp], [manv], [ngayxuat], [soluongX]) VALUES (N'X03       ', N'SP02      ', N'NV01      ', CAST(N'2020-12-12' AS Date), 1)
INSERT [dbo].[Xuat] ([sohdx], [masp], [manv], [ngayxuat], [soluongX]) VALUES (N'X04       ', N'SP03      ', N'NV02      ', CAST(N'2020-06-02' AS Date), 2)
INSERT [dbo].[Xuat] ([sohdx], [masp], [manv], [ngayxuat], [soluongX]) VALUES (N'X05       ', N'SP05      ', N'NV01      ', CAST(N'2020-05-18' AS Date), 1)
GO
INSERT [dbo].[Hangsx] ([mahangsx], [tenhang], [diachi], [sodt], [email]) VALUES (N'H01       ', N'Samsung', N'Korea', N'011-08271717', N'ss@gmail.com.kr')
INSERT [dbo].[Hangsx] ([mahangsx], [tenhang], [diachi], [sodt], [email]) VALUES (N'H02       ', N'OPPO', N'China', N'081-08626262', N'oppo@gmail.com.cn')
INSERT [dbo].[Hangsx] ([mahangsx], [tenhang], [diachi], [sodt], [email]) VALUES (N'H03       ', N'Vinfone', N'Vi?t nam', N'084-098262626', N'vf@gmail.com.vn')
GO
INSERT [dbo].[Nhap] ([sohdn], [masp], [manv], [ngaynhap], [soluongN], [dongiaN]) VALUES (N'N01       ', N'SP02      ', N'NV01      ', CAST(N'2019-05-02' AS Date), 10, 17000000.0000)
INSERT [dbo].[Nhap] ([sohdn], [masp], [manv], [ngaynhap], [soluongN], [dongiaN]) VALUES (N'N02       ', N'SP01      ', N'NV02      ', CAST(N'2020-07-04' AS Date), 30, 6000000.0000)
INSERT [dbo].[Nhap] ([sohdn], [masp], [manv], [ngaynhap], [soluongN], [dongiaN]) VALUES (N'N03       ', N'SP04      ', N'NV02      ', CAST(N'2020-05-17' AS Date), 20, 1200000.0000)
INSERT [dbo].[Nhap] ([sohdn], [masp], [manv], [ngaynhap], [soluongN], [dongiaN]) VALUES (N'N04       ', N'SP01      ', N'NV03      ', CAST(N'2020-03-22' AS Date), 10, 6200000.0000)
INSERT [dbo].[Nhap] ([sohdn], [masp], [manv], [ngaynhap], [soluongN], [dongiaN]) VALUES (N'N05       ', N'SP05      ', N'NV01      ', CAST(N'2020-07-07' AS Date), 20, 7000000.0000)
GO
