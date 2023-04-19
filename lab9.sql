--H�y t?o c�c Trigger ki?m so�t r�ng bu?c to�n v?n v� ki?m tra r�ng bu?c d? li?u sau:
--1. T?o trigger ki?m so�t vi?c nh?p d? li?u cho b?ng nh?p, h�y ki?m tra c�c r�ng bu?c to�n v?n: 
--masp c� trong b?ng s?n ph?m ch?a? many c� trong b?ng nh�n vi�n ch?a? ki?m tra c�c r�ng bu?c d? li?u: 
--soluongN v� dongiaN>0? Sau khi nh?p th� soluong ? b?ng Sanpham s? ???c c?p nh?t theo.
create trigger kiemSoatSP
on Nhap 
for insert
as
begin
	if (select masp from inserted) in (select masp from Nhap)
	begin
		print N'?� c� m� s?n ph?m n�y r?i'
		rollback transaction
	end
	if (select manv from inserted) in (select manv from Nhanvien)
	begin 
		print N'?� c� m� s?n ph?m n�y r?i'
		rollback transaction
	end
	if ((select soluongN from inserted) <= 0 and (select dongiaN from inserted) <= 0)
    begin
        print N'Nh?p sai s? l??ng ho?c ??n gi�'
        rollback transaction
    end
	else
		declare @sl int
		set @sl = (select soluongN from inserted)
		
		update Sanpham set soluong = soluong + @sl 
		where masp = (select masp from inserted)	
end	
go
--2. T?o trigger ki?m so�t vi?c nh?p d? li?u cho b?ng xu?t, h�y ki?m tra c�c r�ng bu?c to�n v?n: 
--masp c� trong b�ng s?n ph?m ch?a? many c� trong b?ng nh�n vi�n ch?a? ki?m tra c�c r�ng bu?c d? li?u: 
--soluongX< soluong trong b?ng sanpham? Sau khi xu?t th� soluong ? b?ng Sanpham s? ???c c?p nh?t theo.
create trigger kiemSoatXuat
on Xuat
for insert
as
begin
    if (select masp from inserted) in (select masp from Sanpham)
    begin
        print N'S?n ph?m kh�ng t?n t?i trong danh m?c s?n ph?m.'
        rollback transaction
    end
    if (select manv from inserted) in (select manv from Nhanvien)
    begin
        print N'Nh�n vi�n kh�ng t?n t?i trong danh m?c nh�n vi�n.'
        rollback transaction
    end
    if (select soluongX from inserted) < (select soluong from Sanpham sp join inserted i on sp.masp = i.masp
		where sp.masp = i.masp)
    begin
        print N'S? l??ng ho?c ??n gi� xu?t kh�ng h?p l?.'
        rollback transaction
    end
    if ((select soluongX from inserted) > (SELECT soluong FROM Sanpham sp join inserted i on sp.masp = i.masp
		where sp.masp = i.masp))
    begin
        print N'S? l??ng s?n ph?m trong kho kh�ng ?? ?? xu?t.'
        rollback transaction
    end
    else
    begin
        update SanPham set soluong = soluong - (select soluongX from inserted) 
		where masp in (select masp from inserted)
    end
end
go
--| 3. T?o trigger ki?m so�t vi?c x�a phi?u xu?t,
--khi phi?u xu?t x�a th� s? l??ng h�ng trong b?ng sanpham s? ???c c?p nh?t t?ng l�n.
create trigger xoaXuat
on Xuat
after delete
as
begin
  declare @masp nvarchar(10), @soln int;

  select @masp = d.masp, @soln = d.soluongX
  from deleted d;

  update Sanpham
  set soluong = soluong + @soln
  where masp = @masp;
end
go
--4. T?o trigger cho vi?c c?p nh?t l?i s? l??ng xu?t trong b?ng xu?t,
--h�y ki?m tra xem s? l??ng xu?t thay ??i c� nh? h?n soluong trong b?ng sanpham hay ko? s? b?n ghi thay ??i
-->1 b?n ghi hay kh�ng? n?u th?a m�n th� cho ph�p update b?ng xu?t v� update l?i soluong trong b?ng sanpham.
create trigger capNhatXuat
on Xuat
after update
as
begin
    declare @Count int, @masp nvarchar(10), @sln int, @sln_old int

    select @Count = COUNT(*) from inserted

    if @Count > 1
    begin
        print N'S? b?n ghi thay ??i > 1 b?n ghi'
        rollback transaction
    end

    select @masp = i.masp, @sln = i.soluongX, @sln_old = d.soluongX
    from INSERTED i INNER JOIN DELETED d ON i.sohdx = d.sohdx AND i.masp = d.masp

    if @sln < @sln_old
    begin
        print N'S? l??ng xu?t thay ??i nh? h?n s? l??ng trong b?ng s?n ph?m'
        rollback transaction
    end

    update Xuat set soluongX = @sln where sohdx = (select sohdx from inserted)

    update Sanpham set soluong = soluong + (@sln_old - @sln) where masp = @masp
end
go
--5. T?o trigger cho vi?c c?p nh?t l?i s? l??ng Nh?p trong b?ng Nh?p,
--H�y ki?m tra xem s? b?n ghi thay ??i >1 b?n ghi hay kh�ng?
--n?u th?a m�n th� cho ph�p update b?ng Nh?p v� update l?i soluong trong b?ng sanpham.
create trigger capNhatSoLuongNhap
on Nhap
after update
as
begin
    if (select COUNT(*) from inserted) > 1
    begin
        print N'Ch? ???c ph�p c?p nh?t m?t b?n ghi t?i m?t th?i ?i?m'
        rollback transaction
    end
    else
    begin
        declare @masp nvarchar(10), @slnOld int, @slnNew int
        
        select @masp = i.masp, @slnOld = d.soluongN, @slnNew = i.soluongN
        from inserted i join deleted d on i.masp = d.masp
        
        if @slnNew < @slnOld
        begin
            print N'S? l??ng nh?p m?i ph?i l?n h?n s? l??ng c?!'
            rollback transaction
        end
		else
		begin
            update Sanpham
            set soluong = soluong + (@slnNew - @slnOld)
            where masp = @masp
        end
    end
end
go
--6. T?o trigger ki?m so�t vi?c x�a phi?u nh?p,
--khi phi?u nh?p x�a th� s? l??ng h�ng trong b?ng sanpham s? ???c c?p nh?t gi?m xu?ng.
create trigger kiemSoatNhap
on Nhap
after delete 
as begin
	declare @soluongD int
	set @soluongD = (select soluongN from deleted)

	update Sanpham set soluong = soluong - @soluongD where masp in (select masp from deleted)
end
go