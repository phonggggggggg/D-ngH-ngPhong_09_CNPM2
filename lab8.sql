--1. Vi?t th? t?c th�m m?i nh�n vi�n bao g?m c�c tham s?: manv, tennv, gioitinh, diachi, sodt, email, phong v� 1 bi?n Flag, N?u Flag=0 th� nh?p m?i, ng??c l?i th� c?p nh?t th�ng tin nh�n vi�n theo m�. H�y ki?m tra:
--- gioitinh nh?p v�o c� ph?i l� Nam ho?c N? kh�ng, n?u kh�ng tr? v? m� l?i 1. - Ng??c l?i n?u th?a m�n th� cho ph�p nh?p v� tr? v? m� l?i 0..
create proc themMoiNhanV 
@manv nchar(10),@tennv nvarchar(20), @gioitinh nchar(10), @diachi varchar(30),
@sodt varchar(20), @email varchar(30), @phong nvarchar(30), @flag int
as
begin

	--flag 0 v� 1 th� ta x? l�
	if(@flag = 0)
	begin

		--Gi?i t�nh nh?p v�o l� nam hay n?
		if @gioitinh not in (N'Nam', N'N?')
		begin 
			select 1 as Maloi1
			return
		end

		insert into Nhanvien(manv, tennv, gioitinh, diachi, sodt, email, phong) values 
		(@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)

		select 0 as Maloi0
		return
	end
	else
	begin
		update Nhanvien set manv = @manv, tennv = @tennv, gioitinh = @gioitinh, diachi = @diachi, 
		sodt = @sodt, email = @email, phong = @phong where manv = @manv
	end
end 
go
exec themMoiNhanV N'NV04', N'Ph?m Th�y Nga',N'Nam' , N'??ng Nai', '0975436464', 'gh@gmail.com', N'K? to�n', 1
go
--2. Vi?t th? t?c th�m m?i s?n ph?m v?i c�c tham bi?n masp, tenhang, tensp, soluong, mausac, giaban, donvitinh, mota v� 1 bi?n Flag. N?u Flag=0 th� th�m m?i s?n ph?m, ng??c l?i c?p nh?t s?n ph?m. H�y ki?m tra:
--- N?u tenhang kh�ng c� trong b?ng hangsx th� tr? v? m� l?i 1 - N?u soluong <0 th� tr? v? m� l?i 2
--- Ng??c l?i tr? v? m� l?i 0.
create proc themSP 
@masp nchar(10), @tenhang nchar(10), @tensp  nvarchar(20), @soluong int, @mausac nvarchar(20),
@giaban money, @donvitinh nchar(10), @mota  nchar(200), @flag int
as begin
	--flag 0 v� 1
	if(@flag = 0)
	begin

			--tenhang kh�ng c� trong h�ng sx
		if @tenhang not in (select tenhang from Hangsx)
		begin
			select 1 as N'M� l?i 1'
		end
		if @soluong < 0
		begin 
			select 2 as N'M� l?i 2'
		end

		--Th�m v�o
		insert into Sanpham(masp, tensp, soluong, mausac, giaban, donvitinh, mota) values 
		(@masp, @tensp, @soluong, @mausac,@giaban, @donvitinh, @mota)

		select 0 as N'M� l?i 0'
		return
	end
	else
	begin
		update Sanpham set masp = @masp, tensp = @tensp, soluong = @soluong, mausac = @mausac, 
		giaban = @giaban, donvitinh = @donvitinh, mota = @mota where masp = @masp
	end
end
go
exec themSP N'SP07', 'Samsung', N'Plus3000', 50, N'??', 5000000, N'Chi?c', N'H�ng cao c?p', 1
go
--3. Vi?t th? t?c x�a d? li?u b?ng nhanvien v?i tham bi?n l� manv. N?u many ch?a c� th� tr? v? 1, ng??c l?i x�a nhanvien v?i nhanvien b? x�a l� many v� tr? v? 0. (L?u �: x�a nhanvien th� ph?i x�a c�c b?ng Nhap, Xuat m� nh�n vi�n n�y tham gia).
create proc xoa_DL @manv varchar(20)
as begin 
	if @manv is null
	begin 
		return 1;
	end
	else 
	begin 
		delete from Nhanvien where manv = @manv
		return 0
	end
end
go
exec xoa_DL 'NV04'
go
--4. Vi?t th? t?c x�a d? li?u b?ng sanpham v?i tham bi?n l� masp. N?u masp ch?a c� th� tr? v? 1, ng??c l?i x�a sanpham v?i sanpham b? x�a l� masp v� tr? v? 0. (L?u �: x�a sanpham th� ph?i x�a c�c b?ng Nhap, Xuat m� sanpham n�y cung ?ng).
create proc xoa_SP @masp varchar(20)
as begin 
	if @masp is null
	begin 
		return 1
	end
	else
	begin 
		delete from Nhap where masp in (select masp from Sanpham where masp = @masp)
		delete from Sanpham where masp = @masp
		return 0
	end
end
go
exec xoa_SP 'SP06'
go
--5. T?o th? t?c nh?p li?u cho b?ng H?ngsx, v?i c�c tham bi?n truy?n v�o mahangsx, tenhang, diachi, sodt, email. H�y ki?m tra xem tenhang ?� t?n t?i tr??c ?� hay ch?a, n?u r?i tr? v? m� l?i 1? N?u c� r?i th� kh�ng cho nh?p v� tr? v? m� l?i 0.
create proc nhapHangsx
@mahangsx varchar(20), @tenhang nvarchar(20), @diachi varchar(20), @sodt varchar(20), @email varchar(20)
as begin
	if @tenhang in (select tenhang from Hangsx)
	begin 
		select 1 as N'M� l?i 1'
	end

	insert into Hangsx (mahangsx, tenhang, diachi, sodt, email) values
	(@mahangsx, @tenhang, @diachi, @sodt, @email)
end
go
--6. Vi?t th? t?c nh?p d? li?u cho b?ng Nhap v?i c�c tham bi?n sohdn, masp, many, ngaynhap, soluongN, dongiaN. Ki?m tra xem masp c� t?n t?i trong b?ng Sanpham hay kh�ng, n?u kh�ng tr? v? 1? many c� t?n t?i trong b?ng nhanvien hay kh�ng n?u kh�ng tr? v? 2?
--ng??c l?i th� h�y ki?m tra: N?u sohdn ?� t?n t?i th� c?p nh?t b?ng Nhap theo sohdn, ng??c l?i th�m m?i b?ng Nhap v� tr? v? m� l?i 0.
create proc nhapChoNhap
    @sohdn nchar(10),
    @masp nchar(10),
    @manv nchar(10),
    @ngaynhap date,
    @soluongN int,
    @dongiaN money
as
begin

    if @masp not in (select masp from Sanpham where masp = @masp)
    begin
        select 1 as N'M� l?i 1'
        return
    end

    IF @manv not in (SELECT manv FROM Nhanvien WHERE manv = @manv)
    BEGIN
        select 2 as N'M� l?i 2' 
        RETURN;
    END

    IF @sohdn in (SELECT sohdn FROM Nhap WHERE sohdn = @sohdn)
    BEGIN
        -- N?u ?� t?n t?i th� c?p nh?t b?ng Nhap
        UPDATE Nhap 
        SET masp = @masp, manv = @manv, ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN 
        WHERE sohdn = @sohdn;
    END
    ELSE
    BEGIN
        -- N?u ch?a t?n t?i th� th�m m?i b?ng Nhap
        INSERT INTO Nhap (sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES (@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN);
    END

    select 0 as N'M� l?i 0'
	return
END
go
exec nhapChoNhap 'N07', 'SP02', 'NV04', '2020-09-15', 16, 50000
go
--7. Vi?t th? t?c nh?p d? li?u cho b?ng xuat v?i c�c tham bi?n sohdx, masp, many, ngayxuat, soluongX. Ki?m tra xem masp c� t?n t?i trong b�ng Sanpham hay kh�ng n?u kh�ng tr? v? 1? many c� t?n t?i trong b?ng nhanvien hay kh�ng n?u kh�ng tr? v? 2?
--soluongX<= Soluong n?u kh�ng tr? v? 3? ng??c l?i th� h�y ki?m tra: N?u sohdx ?� t?n t?i th� c?p nh?t b?ng Xuat theo sohdx, ng??c l?i th�m m?i b?ng Xuat v� tr? v? m� l?i 0
create PROCEDURE xuatSP
    @sohdx nchar(10),
	@masp nchar(10),
    @manv nchar(10),
    @ngayxuat date,
    @soluongX int
AS
BEGIN
    -- Ki?m tra s? t?n t?i c?a masp trong b?ng Sanpham
    IF NOT EXISTS(SELECT masp FROM Sanpham WHERE masp = @masp)
        RETURN 1

    -- Ki?m tra s? t?n t?i c?a many trong b?ng Nhanvien
    IF NOT EXISTS(SELECT manv FROM Nhanvien WHERE manv = @manv)
        RETURN 2

    -- Ki?m tra s? l??ng xu?t kh�ng v??t qu� s? l??ng t?n kho Soluong
    DECLARE @Soluong int
    SELECT @Soluong = soluong FROM Sanpham WHERE masp = @masp
    IF @soluongX > @Soluong
        RETURN 3

    -- Th�m ho?c c?p nh?t d? li?u v�o b?ng Xu?t
    IF EXISTS(SELECT sohdx FROM Xuat WHERE sohdx = @sohdx)
    BEGIN
        UPDATE Xuat
        SET masp = @masp,
            manv = @manv,
            ngayxuat = @ngayxuat,
            soluongX = @soluongX
        WHERE sohdx = @sohdx
    END
    ELSE
    BEGIN
        INSERT INTO Xuat (sohdx, masp, manv, ngayxuat, soluongX)
        VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX)
    END

    RETURN 0
END
go
exec xuatSP 'X06', 'SP03', 'NV01', '2020-09-15', 16
go