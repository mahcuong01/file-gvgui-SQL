-- Tạo cơ sở dữ liệu
CREATE DATABASE [tên csdl muốn tạo] CHARACTER SET UTF8 -- Tạo csdl lưu được tiếng việt

-- Tạo bảng sinhvien trong database quanlysinhvien
CREATE TABLE sinhvien
(
	MaSV integer PRIMARY KEY AUTO_INCREMENT,-- khóa chính tự động tăng
	TenSV varchar(255) NOT NULL, -- tensv có kiểu dữ liệu là varchar chứa tối đa 255 ký tự
	NgaySinh DATE, -- NgaySinh có kiểu dữ liệu là date định dạng kiểu (yyyy-mm-dd)
	SDT varchar(10) -- SDT có kiểu dữ liệu là varchar chứa tối đa 10 ký tự
)

-- Lệnh thêm dữ liệu vào table sinhvien với các field (TenSV, NgaySinh)
INSERT INTO sinhvien(TenSV,NgaySinh) VALUES("Nguyễn Văn A","1990-12-12")

/* Bài tập: 
	+ Tạo thêm bảng môn học trong csdl quanlysinhvien: Mã môn học (tự động tăng), tên môn học, số tiết
	+ Thêm dữ liệu vào trong bảng môn học: 
		- Tin học - 45,
		- Toan	- 60,
		- Hoa - 45
*/

-- Cập nhật dữ liệu trong 1 bảng
UPDATE [table] SET [cột] = "[dữ liệu thay đổi]" WHERE [cột khóa chính] = [giá trị] LIMIT 1;
/*
VD: cập nhật thông tin tên sinh viên có mã sinh viên là 1;
*/
UPDATE sinhvien SET TenSV = "Nguyễn văn C" WHERE MaSV = 1 LIMIT 1;

-- Xóa dữ liệu trong 1 bảng
DELETE FROM [ten bang] WHERE [cột] = "giá trị"

/*
Bài tập
Tạo CSDL Quản Lý Đề Tài
Khoa(makhoa varchar(10), tenkhoa varchar(30), dienthoai varchar(10))

GiangVien(magv int, hotengv varchar(55), luong decimal(5,2), makhoa varchar(10))

SinhVien(masv int, hotensv varchar(55), makhoa varchar(10), namsinh int, quequan varchar(30))

DeTai(madt varchar(10), tendt varchar(30), kinhphi int, NoiThucTap varchar(30))

HuongDan(masv int, madt varchar(10), magv int, ketqua decimal(5,2))

*/
CREATE DATABASE QUANLYDETAI CHARACTER SET UTF8; -- Tạo CSDL lưu tiếng Việt
USE QUANLYDETAI; -- Chọn cơ sở dữ liệu QUANLYDETAI

/*
	Tạo ra các bảng cho csdl QUANLYDETAI
*/
CREATE TABLE Khoa (
    MaKhoa varchar(10) PRIMARY KEY,
    TenKhoa varchar(30),
    DienThoai varchar(10)
);

CREATE TABLE GiangVien
(
	magv int PRIMARY KEY AUTO_INCREMENT,
    hoten varchar(55),
    luong decimal(5,2),
    makhoa varchar(10)
);
 
CREATE TABLE sinhvien(
    masv int PRIMARY KEY AUTO_INCREMENT,
    hoten varchar(55),
    makhoa varchar(10),
    namsinh int,
    quequan varchar(30)
);

CREATE TABLE detai (
madt varchar(10) PRIMARY KEY,
    tendt varchar(30),
    kinhphi int,
    noithuctap varchar(30)
);

CREATE TABLE huongdan(
	masv int, 
    madt varchar(10),
    magv int ,
    ketqua decimal(5,2)
	PRIMARY KEY (masv, madt, magv)-- masv, madt, magv điều là khóa chính
);

/*
	Câu lệnh thêm dữ liệu vào CSDL QUANLYDETAI
*/
INSERT INTO Khoa VALUES
("Geo", "Dla ly" , 3855413)
("Math", "Toan hoc",3855411)
( "BIO", "Cong nghe sinh hoc" , 3855412);

INSERT INTO Giangvien VALUES
(01, "Thanh Binh" ,700, "Geo"),
(02, "Thu Huong" , 500, "math"),
(03, "Chu Vinh",650,"Gse") ,
(04, "Thi Ly", 500, "Bio"),
(05, "Tran Son", 90, "math");

INSERT INTO SinhVien VALUES
(1,"Le Van Son" , "Bio" ,199e, "Nghe An"),
(2,"Nguyen Thi Mai" "Geo" , 1990, "Thanh Hoa"),
(3, "Bui Xuan Due" , "Math" , 1992, "Ha Noi"),
(4,"Nguyen Van Tung" , "Bio" , null, "Ha Tinh"),
(5, "Le Khanh Linh", "Bio " , 1989, "Ha Nam"),
(6, "Tran Khac Trong" , "Geo" , 1991, "Ninh Binh"),
(7, "Le Hong Van" , "Math" , null, "null" ) ,
(8, "Hoang Anh Duc", "Bio" ,1992, "Nghe An");

INSERT INTO TBLDeTai VALUES
("Dtel" , "GIS" , 100, "Nghe An"),
("Dter" , "ARC GIS", 500, "Vinh Phuc"),
("Dte3" , "Spatial DB" , 100, "Ha Tinh"),
( "Dte4" , "MAP" ,300, "Quang Binh");

INSERT INTO HuongDan VALUES
(1,"dt01", 13, 8)
(2,"dt03", 14, 0)
(3,"dt03", 12, 10)
(4,"dt04", 14, 7)
(5,"dt01", 13, null)
(6,"dt04", 11, 10)
(7,"dt03", 15, 6);


/*
==== TRUY VẤN DỮ LIỆU =======
*/

--Câu 1: Đưa ra thông tin gồm mã khoa, họ tên va tên khoa của tất cả các giảng viên
SELECT khoa.makhoa, tenkhoa, magv, hoten 
FROM khoa, giangvien 
WHERE khoa.makhoa = giangvien.makhoa

-- Câu 2: Đưa ra thông tin gồm mã khoa, họ tên va tên khoa của tất cả các giảng viên của khoa "Địa lý"
	SELECT
		khoa.makhoa,
		khoa.tenkhoa,
		giangvien.magv,
		giangvien.hoten
	FROM
		giangvien,
		khoa
	WHERE
	   giangvien.makhoa = khoa.makhoa and giangvien.makhoa = 'Geo' -- khoa.tenkhoa = "Địa lý"
 -------------------------------------------------------------
 
 -- Câu 3: Đưa ra số sinh viên thuộc khoa "Công Nghệ Sinh Học"
	
	-- Cách 1: 
	SELECT
		COUNT(makhoa)
	FROM
		sinhvien
	WHERE makhoa = "BIO"
	
	-- Cách 2: 
	SELECT
		COUNT(sinhvien.makhoa)-- Hàm Count điếm dòng trong bảng được lấy ra
	FROM
		sinhvien,
		khoa
	WHERE
	   sinhvien.makhoa = khoa.makhoa -- Khóa Liên Kết 2 bảng
	AND khoa.tenkhoa = 'Cong nghe sinh hoc' -- Điều kiện lọc dữ liệu

-- Câu 4: Đưa ra danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa ‘Toan hoc’
	
	-- Cách 1: Khi biết mã khoa
		SELECT 
			masv, 
			hoten, 
			namsinh as "Tuoi"
		FROM sinhvien
		WHERE makhoa = 'math'
	-- Cách 2: chỉ biết tên khoa mà không biết mã khoa
		SELECT masv, hoten, namsinh
		FROM sinhvien
		INNER JOIN khoa ON sinhvien.makhoa = khoa.makhoa
		WHERE khoa.tenkhoa = "toan hoc"
		
-- Câu 5: Cho biết số giảng viên của khoa ‘Cong nghe sinh hoc’
	
	-- Cách 1: khi mình biết tên khoa mà không biết mã khoa
	SELECT COUNT(magv)
	FROM giangvien
	JOIN khoa ON GiangVien.makhoa = khoa.makhoa
	WHERE khoa.tenkhoa = "Cong nghe sinh hoc" 
	-- WHERE khoa.tenkhoa like "Cong nghe sinh hoc"

-- Câu 6: Cho biết thông tin về sinh viên không tham gia thực tập
	SELECT *
	FROM sinhvien 
	WHERE NOT EXISTS (
		SELECT huongdan.masv 
		FROM huongdan
		WHERE sinhvien.masv = huongdan.masv
	)
	
-- Câu 7: Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
	SELECT khoa.makhoa, khoa.tenkhoa, COUNT(khoa.makhoa) as "số GV"
	FROM giangvien JOIN Khoa ON khoa.makhoa = giangvien.makhoa
	GROUP BY khoa.makho, khoa.tenkhoa

-- Câu 8:Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le Van Son’ đang theo học
	SELECT DienThoai
	FROM khoa JOIN sinhvien ON khoa.makha = sinhvien.makhoa
	WHERE sinhvien.hotensv = "Le Van Son"