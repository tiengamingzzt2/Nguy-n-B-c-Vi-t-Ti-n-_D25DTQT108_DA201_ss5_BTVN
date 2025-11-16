------ Bài 1 ------

create database btvn_ss05;
CREATE TABLE KhachHang(
 MaKH INT primary key auto_increment,
 HoTen VARCHAR(255),
 Email VARCHAR(255),
 SoDienThoai VARCHAR(15),
 NgayDangKy DATE
);
 
INSERT INTO KhachHang (MaKH, HoTen, Email, SoDienThoai, NgayDangKy) 
VALUES(1, 'Nguyễn Văn An', 'an.nguyen@email.com', '0901234567', '2023-10-25'),
	(2, 'Trần Thị Bình', 'binh.tran@email.com', '0912345678', '2023-10-26'),
	(3, 'Lê Minh Cường', 'cuong.le@email.com', '0987654321', '2023-11-01');

INSERT INTO KhachHang (MaKH, HoTen, Email, SoDienThoai, NgayDangKy) 
VALUES(4, ' Phạm Thị Dung','dung.pham@email.com', ' 0934567890', '2023-11-02'),
	(5, 'Hoàng Văn Em', 'em.hoang@email.com' , '0945678901', '2023-11-03');
select *
from khachhang;

select a.HoTen, a.Email
from khachhang a;

------- Bài 2 -------

CREATE TABLE Sach (
    MaSach VARCHAR(10) primary key ,
    TenSach VARCHAR(255),
    TacGia VARCHAR(255),
    TheLoai VARCHAR(100),
    GiaBan INT
);
 
INSERT INTO Sach (MaSach, TenSach, TacGia, TheLoai, GiaBan) VALUES
('SGK01', 'Đắc Nhân Tâm', 'Dale Carnegie', 'Kỹ năng sống', 120000),
('SVK02', 'Nhà Giả Kim', 'Paulo Coelho', 'Văn học', 89000),
('STN03', 'Lược Sử Loài Người', 'Yuval Noah Harari', 'Lịch sử', 150000),
('SKD04', 'Tư Duy Nhanh và Chậm', 'Daniel Kahneman', 'Kinh doanh', 99000);
 
update sach
set GiaBan = 180000
where MaSach = 'SKD04';

update sach
set tacgia = 'Paulo Coelho'
where  MaSach = 'SVK02';

DELETE FROM sach
where masach = 'SGK01';

SELECT *
FROM SACH ;

------- bài 3 -------

CREATE TABLE DonHang (
 MaDonHang INT,
 NgayDatHang DATE,
 TongGiaTri INT,
 ThanhPhoGiaoHang VARCHAR(100)
);

INSERT INTO DonHang (MaDonHang, NgayDatHang, TongGiaTri, ThanhPhoGiaoHang) 
VALUES
(101, '2023-10-15', 1500000, 'Hà Nội'),
(102, '2023-10-18', 800000, 'Đà Nẵng'),
(103, '2023-10-20', 2200000, 'TP. Hồ Chí Minh'),
(104, '2023-10-22', 750000, 'Hà Nội'),
(105, '2023-10-25', 3100000, 'TP. Hồ Chí Minh');

select *
from DonHang
where TongGiaTri>1000000;

select *
from DonHang
where ThanhPhoGiaoHang='TP. Hồ Chí Minh';

select *
from DonHang
order by TongGiaTri desc;

select distinct ThanhPhoGiaoHang
from DonHang;


------- bài 4 -----

CREATE TABLE NhanVien(
 MaNV VARCHAR(10),
 HoTen VARCHAR(255),
 PhongBan VARCHAR(100),
 ChucVu VARCHAR(100),
 NamSinh INT
);

INSERT INTO NhanVien (MaNV, HoTen, PhongBan, ChucVu, NamSinh) VALUES
('NV01', 'Trần Văn Mạnh', 'Kinh doanh', 'Nhân viên', 1995),
('NV02', 'Lê Thị Hoa', 'Marketing', 'Trưởng phòng', 1990),
('NV03', 'Nguyễn Anh Dũng', 'Kinh doanh', 'Nhân viên', 1998),
('NV04', 'Phạm Thị Lan', 'Nhân sự', 'Chuyên viên', 1992),
('NV05', 'Hoàng Minh Tuấn', 'Kỹ thuật', 'Trưởng nhóm', 1991);

SELECT *
FROM NhanVien
WHERE PhongBan = 'Kinh doanh'
AND NamSinh < 1996;

SELECT *
FROM NhanVien
WHERE ChucVu='Trưởng phòng'
OR ChucVu='Trưởng nhóm';

SELECT *
FROM NhanVien
WHERE PhongBan <> 'Kỹ thuật';

SELECT *
FROM NhanVien
WHERE PhongBan='Marketing'
AND ChucVu='Trưởng phòng';

------ bài 5 ------

CREATE TABLE KhachHangThanThiet (
 MaKH INT,
 HoTen VARCHAR(255),
 ThanhPho VARCHAR(100),
 TongChiTieu INT,
 SoDonHang INT,
 LanCuoiMuaHang DATE
);

INSERT INTO KhachHangThanThiet (MaKH, HoTen, ThanhPho, TongChiTieu, SoDonHang, LanCuoiMuaHang) VALUES
(1, 'Nguyễn Thị Mai', 'Hà Nội', 15000000, 12, '2023-10-28'),
(2, 'Trần Văn Nam', 'TP. Hồ Chí Minh', 25000000, 20, '2023-10-15'),
(3, 'Lê Minh Anh', 'Hà Nội', 3000000, 2, '2023-10-05'),
(4, 'Phạm Hồng Nhung', 'Đà Nẵng', 8000000, 8, '2023-05-20'),
(5, 'Hoàng Tuấn Kiệt', 'Hà Nội', 18000000, 15, '2023-09-30'),
(6, 'Vũ Bích Phương', 'TP. Hồ Chí Minh', 4500000, 3, '2023-04-11');

SELECT *
FROM KhachHangThanThiet
WHERE TongChiTieu > 10000000
AND SoDonHang >= 10
ORDER BY TongChiTieu DESC;

SELECT *
FROM KhachHangThanThiet
WHERE ThanhPho = 'Hà Nội'
AND SoDonHang < 5
AND TongChiTieu > 2000000;

SELECT *
FROM KhachHangThanThiet
WHERE LanCuoiMuaHang < '2023-09-01';

SET SQL_SAFE_UPDATES = 0;

UPDATE KhachHangThanThiet
SET ThanhPho = 'Khách hàng cũ'
WHERE LanCuoiMuaHang < '2023-09-01';

-------- bài 6 --------

CREATE TABLE SanPham (
 MaSP VARCHAR(10),
 TenSP VARCHAR(255),
 DanhMuc VARCHAR(100),
 SoLuongTon INT,
 NhaCungCap VARCHAR(100),
 NgayNhapKho DATE,
 TrangThai VARCHAR(50)
);

INSERT INTO SanPham (MaSP, TenSP, DanhMuc, SoLuongTon, NhaCungCap, NgayNhapKho, TrangThai) VALUES
('DB001', 'Nồi chiên không dầu', 'Đồ bếp', 25, 'Sunhouse Group', '2023-03-15', 'Bán chạy'),
('DD002', 'Máy sấy tóc', 'Điện gia dụng', 50, 'Philips VN', '2023-09-05', 'Hàng mới'),
('DB003', 'Bộ dao làm bếp', 'Đồ bếp', 15, 'Elmich', '2023-02-20', 'Bán chạy'),
('TT004', 'Bàn ủi hơi nước', 'Thiết bị tiện ích', 30, 'Philips VN', '2023-08-10', 'Bán chạy'),
('DB005', 'Máy xay sinh tố', 'Đồ bếp', 8, 'Sunhouse Group', '2023-04-01', 'Tồn kho');

UPDATE SanPham
SET NhaCungCap = 'Tập đoàn Sunhouse'
WHERE NhaCungCap = 'Sunhouse Group';

SELECT *
FROM SanPham
WHERE DanhMuc = 'Đồ bếp'
AND NgayNhapKho < '2023-05-01';

UPDATE SanPham
SET TrangThai = 'Xả hàng tồn kho'
WHERE DanhMuc = 'Đồ bếp'
AND NgayNhapKho < '2023-05-01';

SELECT *
FROM SanPham 
WHERE TrangThai = 'Xả hàng tồn kho'
OR SoLuongTon < 10
ORDER BY SoLuongTon ASC;




