-- quan ly nhan su

-- 1. Hiển thị thông tin của những nhân viên ở phòng số 5
SELECT 
    *
FROM
    nhanvien
WHERE
    pgh = 5;

-- 2. Hiển thị mã nhân viên, họ nhân viên, tên lót và tên nhân viên của những nhân viên ở phòng số 5 và có lương >= 3000
select manv, honv, tenlot, tennv from nhanvien where pgh=5 and luong >= 3000;

-- 3. Hiển thị mã nhân viên, tên nhân viên của những nhân viên có lương từ 2000 đến 8000
select manv, tennv from nhanvien where luong between 2000 and 8000;

-- 4. Hiển thị thông tin của những nhân viên ở địa chỉ có tên đường là Nguyễn ??
-- Câu này em sẽ hiều là tên đường bắt đầu là Nguyễn 
select * from nhanvien where diachi like "Nguyễn%";

-- 5. Cho biết số lượng nhân viên
select count(manv) as soluongnv from nhanvien;

-- 6. Cho biết số lượng nhân viên trong từng phòng ban
select phongban.tenpgh,count(manv) as soluongnv from phongban left join nhanvien on nhanvien.pgh = phongban.pgh
group by phongban.pgh;

-- 7. Hiển thị thông tin về mã nhân viên, tên nhân viên và tên phòng ban ở phòng kế toán
select manv, tennv, tenpgh from nhanvien inner join phongban on nhanvien.pgh = phongban.pgh
where tenpgh = "Kế toán";

-- 8 .Tìm thông tin của nhân viên làm từ 2 đề án trở lên.
select nhanvien.* from nhanvien inner join phancong on nhanvien.manv = phancong.manv
group by nhanvien.manv
having count(nhanvien.manv) >= 2;

-- thuc tap
-- 1.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên
select Magv, Hotengv, Tenkhoa from TBLGiangVien left join TBLKhoa on TBLGiangVien.Makhoa = TBLKhoa.Makhoa;

-- 2.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
select Magv, Hotengv, Tenkhoa from TBLGiangVien left join TBLKhoa on TBLGiangVien.Makhoa = TBLKhoa.Makhoa
where Tenkhoa = 'DIA LY va QLTN';

-- 3.Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
select count(TBLSinhVien.Masv) as svCNSH from TBLSinhVien left join TBLKhoa on TBLSinhVien.Makhoa = TBLKhoa.Makhoa
where TBLKhoa.Tenkhoa = 'CONG NGHE SINH HOC'
group by TBLKhoa.Makhoa;

-- 4.Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’

select Masv, Hotensv, year(curdate()) - TBLSinhVien.Namsinh as Tuoi from TBLSinhVien left join TBLKhoa on TBLKhoa.Makhoa = TBLSinhVien.Makhoa
where Tenkhoa = 'TOAN';

-- 5.Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’

select count(TBLGiangVien.Magv) as gvCNSH from TBLGiangVien left join TBLKhoa on TBLGiangVien.Makhoa = TBLKhoa.Makhoa
where TBLKhoa.Tenkhoa = 'CONG NGHE SINH HOC';

-- 6.Cho biết thông tin về sinh viên không tham gia thực tập
select TBLSinhVien.* from TBLSinhVien left join TBLHuongDan on TBLSinhVien.Masv = TBLHuongDan.Masv
where Madt is null;

-- 7.Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
select TBLKhoa.Makhoa, Tenkhoa, count(TBLGiangVien.Magv) as SoLuongGV
from TBLGiangVien left join TBLKhoa on TBLGiangVien.Makhoa = TBLKhoa.Makhoa
group by TBLKhoa.Makhoa;

-- 8.Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
select TBLKhoa.Dienthoai from TBLSinhVien left join TBLKhoa on TBLSinhVien.Makhoa = TBLKhoa.Makhoa
where Hotensv = 'Le van son';

-- 9.Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
select Madt, Tendt from TBLDeTai
where Madt in
(
select Madt from TBLHuongDan inner join TBLGiangVien on TBLHuongDan.Magv = TBLGiangVien.Magv
where TBLGiangVien.Hotengv = 'Tran son'
);

-- 10.Cho biết tên đề tài không có sinh viên nào thực tập

select Tendt from TBLDeTai where Madt not in
(select Madt from TBLHuongDan);

-- 11.Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
select Magv, Hotengv, Tenkhoa from TBLGiangVien left join TBLKhoa on TBLGiangVien.Makhoa = TBLKhoa.Makhoa
where TBLGiangVien.Magv
in
(select Magv from TBLHuongDan group by Magv having count(Masv) >= 3);

-- 12.Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
select Madt, TenDt from TBLDeTai where Kinhphi = 
(select max(Kinhphi) from TBLDeTai);

-- 13.Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
select TBLDeTai.Madt, TenDt from TBLHuongDan left join TBLDeTai
on TBLDeTai.Madt = TBLHuongDan.Madt
group by Madt
having count(Masv) > 2;

-- 14.Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
select TBLSinhVien.Masv, Hotensv, KetQua from TBLSinhVien left join TBLHuongDan
on TBLSinhVien.Masv = TBLHuongDan.Masv 
where TBLSinhVien.Makhoa
in
(select Makhoa from TBLKhoa where Tenkhoa = 'Dia ly va QLTN');

-- 15.Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
select Tenkhoa, count(TBLSinhVien.Masv) as SoLuongSV from TBLSinhVien left join TBLKhoa
on TBLSinhVien.Makhoa = TBLKhoa.Makhoa
group by TBLKhoa.Makhoa;

-- 16.Cho biết thông tin về các sinh viên thực tập tại quê nhà
select TBLSinhVien.* from TBLHuongDan left join TBLDeTai
on TBLHuongDan.Madt = TBLDeTai.Madt
left join TBLSinhVien on TBLSinhVien.Masv = TBLHuongDan.Masv
where TBLSinhVien.Quequan = TBLDeTai.Noithuctap;

-- 17.Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
select TBLSinhVien.* from TBLHuongDan left join TBLSinhVien on TBLHuongDan.Masv = TBLSinhVien.Masv
where KetQua is null;
