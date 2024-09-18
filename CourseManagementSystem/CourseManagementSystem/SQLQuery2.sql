use master
go
create database AHUStudy
go
use AHUStudy
go
create table [users](
[userid] [int] identity(1,1) primary key not null,
[username] [nvarchar](50) not null,
[password] [nvarchar](50) not null,
[fullname] [nvarchar](50) not null,
[email] [nvarchar](100) not null,
[avatar] [nvarchar](200) null,
[role] [nvarchar](50) not null,
)
go
create table [category](
[categoryid] [int] identity(1,1) primary key not null,
[categoryname]  [nvarchar](50) not null,
)
go
create table [typecourse](
[typecourseid] [int] identity(1,1) primary key not null,
[typecoursename]  [nvarchar](50) not null,
[categoryid] [int] foreign key references [category]([categoryid])
)
go
create table [courses](
[courseid] [int] identity(1,1) primary key not null,
[title]  [nvarchar](50) not null,
[description] [nvarchar](50) not null,
[price] [int] not null,
[linkimg] [nvarchar] (200) not null,
[typecourseid] [int] foreign key references [typecourse]([typecourseid]),
[userid] [int] foreign key references [users]([userid])
)
go
create table [lessons](
[lessonid] [int] identity(1,1) primary key not null,
[lessonname]  [nvarchar](50) not null,
[courseid] [int] foreign key references [courses]([courseid])
)
go
create table [document](
[documentid] [int] identity(1,1) primary key not null,
[videourl] [nvarchar](200) null,
[slideurl] [nvarchar](200) null,
[lessonsid] [int] foreign key references [lessons]([lessonid])
)
go
create table [enrollments](
[enrollmentid] [int] identity(1,1) primary key not null,
[userid] [int] foreign key references [users]([userid]),
[courseid] [int] foreign key references [courses]([courseid])
)
go
create table [cart](
[cartid] [int] identity(1,1) primary key not null,
[userid] [int] foreign key references [users]([userid]),
[courseid] [int] foreign key references [courses]([courseid])
)
go
create table [reviews](
[reviewid] [int] identity(1,1) primary key not null,
[comment] [nvarchar](200) not null,
[rating] [int] not null,
[userid] [int] foreign key references [users]([userid]),
[courseid] [int] foreign key references [courses]([courseid])
)
go
create table [orders](
[orderid] [int] identity(1,1) primary key not null,
[orderdate] [date] not null,
[totalamount] [int] not null,
[note] [nvarchar](200) null,
[userid] [int] foreign key references [users]([userid]),
)
go
create table [orderdetails](
[orderdetailid] [int] identity(1,1) primary key not null,
[price] [int] not null,
[courseid] [int] foreign key references [courses]([courseid]),
[orderid] [int] foreign key references [orders]([orderid])
)
go
create table [shift](
[shiftid] [int] primary key not null,
[dayofweek] [nvarchar](50) not null,
[shiftname] [nvarchar](50)
)
go
create table [schedules](
[scheduleid] [int] identity(1,1) primary key not null,
[shiftid] [int] foreign key references [shift]([shiftid]),
[courseid] [int] foreign key references [courses]([courseid])
)
go
create table [grades](
    [gradeid] [int] identity(1,1) primary key not null,
    [midtermscore] [float] not null,
	[finalscore] [float] not null,
	[average] [float] not null,
    [enrollmentid] [int] foreign key references [enrollments]([enrollmentid])
)
go
create table [news](
    [newsid] [int] identity(1,1) primary key not null,
    [title] [nvarchar](100) not null,
    [content] [nvarchar](max) not null,
    [publisheddate] [date] not null,
    [userid] [int] foreign key references [users]([userid])
)
go
create table [bank](
    [bankid] [int] identity(1,1) primary key not null,
    [accountnumber] [nvarchar](100) not null,
    [bankname] [nvarchar](max) not null,
    [expirydate] [datetime] not null,
    [userid] [int] foreign key references [users]([userid])
)
go
create trigger trgAfterOrder
on orders
after insert
as
begin
    set nocount on;
    insert into enrollments (userid, courseid)
    select i.userid, od.courseid
    from inserted i
    join orderdetails od on i.orderid = od.orderid;
end;

go
set identity_insert [users] on 
insert into [users]([userid],[username],[password],[fullname],[email],[avatar],[role])
values  ( 1 , 'user1' , 'pass1' , N'name1' , 'email1' , 'member_1.jpg' , 'student'),
		( 2 , 'user2' , 'pass2' , N'name2' , 'email2' , 'member_2.jpg' , 'student'),
		( 3 , 'user3' , 'pass3' , N'name3' , 'email3' , 'member_3.jpg' , 'student'),
		( 4 , 'user4' , 'pass4' , N'name4' , 'email4' , 'member_4.jpg' , 'student'),
		( 5 , 'user5' , 'pass5' , N'name5' , 'email5' , 'member_5.jpg' , 'student'),
		( 6 , 'user6' , 'pass6' , N'name6' , 'email6' , 'member_6.jpg' , 'student'),
		( 7 , 'user7' , 'pass7' , N'name7' , 'email7' , 'member_7.jpg' , 'student'),
		( 8 , 'user8' , 'pass8' , N'name8' , 'email8' , 'member_8.jpg' , 'student'),
		( 9 , 'user9' , 'pass9' , N'name9' , 'email9' , 'member_9.jpg' , 'student'),
		( 10 , 'lect1' , 'lect1' , N'name10' , 'email10' , 'instructor_1.jpg' , 'lecturer'),
		( 11 , 'lect2' , 'lect2' , N'name11' , 'email11' , 'instructor_2.jpg' , 'lecturer'),
		( 12 , 'lect3' , 'lect3' , N'name12' , 'email12' , 'instructor_3.jpg' , 'lecturer'),
		( 13 , 'lect4' , 'lect4' , N'name13' , 'email13' , 'instructor_4.jpg' , 'lecturer'),
		( 14 , 'lect5' , 'lect5' , N'name14' , 'email14' , 'instructor_5.jpg' , 'lecturer'),
		( 15 , 'lect6' , 'lect6' , N'name15' , 'email15' , 'instructor_6.jpg' , 'lecturer'),
		( 16 , 'lect7' , 'lect7' , N'name16' , 'email16' , 'instructor_7.jpg' , 'lecturer'),
		( 17 , 'lect8' , 'lect8' , N'name17' , 'email17' , 'instructor_8.jpg' , 'lecturer'),
		( 18 , 'lect9' , 'lect9' , N'name18' , 'email18' , 'instructor_9.jpg' , 'lecturer'),
		( 19 , 'lect10' , 'lect10' , N'name19' , 'email19' , 'instructor_10.jpg' , 'lecturer'),
		( 20 , 'lect11' , 'lect11' , N'name20' , 'email20' , 'instructor_11.jpg' , 'lecturer'),
		( 21 , 'admin' , 'admin' , N'admin' , 'admin' , 'admin.jpg' , 'admin'),
		( 22 , N'thanhly567' , N'Thanhly567' , N'Lý Thị Thanh' , N'thanhly567@gmail.com' , N'member_4.jpg' , N'student'),
		( 23 , N'ducvtran' , N'Ducvtran' , N'Trần Văn Đức' , N'ducvtran@gmail.com' , N'member_5.jpg' , N'student'),
		( 24 , N'hathanh_dinh' , N'Hathanh1' , N'Đinh Thị Thu Hà' , N'hathanh_dinh@gmail.com' , N'member_6.jpg' , N'student'),
		( 25 , N'nampham87' , N'Nampham87' , N'Phạm Văn Nam' , N'nampham87@gmail.com' , N'member_7.jpg' , N'student'),
		( 26 , N'thuythuyn97' , N'Thuythuy97' , N'Nguyễn Thị Thu Thủy' , N'thuythuyn97@gmail.com' , N'member_8.jpg' , N'student'),
		( 27 , N'hangvu89' , N'Hangvu89' , N'Vũ Thị Hằng' , N'hangvu89@gmail.com' , N'member_9.jpg' , N'student'),
		( 28 , N'quantran567' , N'Quantran567' , N'Trần Văn Quân' , N'quantran567@gmail.com' , N'member_9.jpg' , N'student'),
		( 29 , N'hongle78' , N'Hongle78' , N'Lê Thị Hồng' , N'hongle78@gmail.com' , N'member_8.jpg' , N'student'),
		( 30 , N'anhhoang234' , N'Anhhoang234' , N'Hoàng Văn Anh' , N'anhhoang234@gmail.com' , N'member_7.jpg' , N'student'),
		( 31 , N'huongdang_90' , N'Huongdang90' , N'Đặng Thị Hương' , N'huongdang_90@gmail.com' , N'member_6.jpg' , N'student'),
		( 32 , N'haiphan345' , N'Haiphan345' , N'Phan Văn Hải' , N'haiphan345@gmail.com' , N'member_5.jpg' , N'student'),
		( 33 , N'linhtran_678' , N'Linhtran678' , N'Trần Thị Thùy Linh' , N'linhtran_678@gmail.com' , N'member_4.jpg' , N'student'),
		( 34 , N'hungnguyen_99' , N'Hungnguyen99' , N'Nguyễn Văn Hưng' , N'hungnguyen_99@gmail.com' , N'member_3.jpg' , N'student'),
		( 35 , N'halethu123' , N'Halethu123' , N'Lê Thị Thu Hà' , N'halethu123@gmail.com' , N'member_2.jpg' , N'student'),
		( 36 , N'toanvu_123' , N'Toanvu123' , N'Vũ Văn Toàn' , N'toanvu_123@gmail.com' , N'member_1.jpg' , N'student'),
		( 37 , N'yenhai.tran' , N'Yenhai0' , N'Trần Thị Hải Yến' , N'yenhai.tran@gmail.com' , N'member_1.jpg' , N'student'),
		( 38 , N'hunghoangv' , N'Hunghoangv' , N'Hoàng Văn Hùng' , N'hunghoangv@gmail.com' , N'member_2.jpg' , N'student'),
		( 39 , N'hoainguyen_89' , N'Hoainguyen89' , N'Nguyễn Thị Hoài An' , N'hoainguyen_89@gmail.com' , N'member_3.jpg' , N'student'),
		( 40 , N'datlyv' , N'Datlyv' , N'Lý Văn Đạt' , N'datlyv@gmail.com' , N'member_4.jpg' , N'student'),
		( 41 , N'tramngoc_tran' , N'Tramngoc123' , N'Trần Thị Ngọc Trâm' , N'tramngoc_tran@gmail.com' , N'member_5.jpg' , N'student'),
		( 42 , N'quanpham_88' , N'Quanpham88' , N'Phạm Văn Quân' , N'quanpham_88@gmail.com' , N'member_6.jpg' , N'student'),
		( 43 , N'trangthudo' , N'Trangthu0' , N'Đỗ Thị Thu Trang' , N'trangthudo@gmail.com' , N'member_7.jpg' , N'student'),
		( 44 , N'hoanguyen678' , N'Hoanguyen678' , N'Nguyễn Văn Hòa' , N'hoanguyen678@gmail.com' , N'member_8.jpg' , N'student'),
		( 45 , N'nhungle_hoang' , N'Nhunglehoang' , N'Lê Thị Hồng Nhung' , N'nhungle_hoang@gmail.com' , N'member_9.jpg' , N'student'),
		( 46 , N'hathi_vuthu' , N'Hathi1' , N'Vũ Thị Thu Hà' , N'hathi_vuthu@gmail.com' , N'member_9.jpg' , N'student'),
		( 47 , N'quangtran_098' , N'Quangtran098' , N'Trần Văn Quang' , N'quangtran_098@gmail.com' , N'member_8.jpg' , N'student'),
		( 48 , N'kimhoang_123' , N'Kimhoang123' , N'Hoàng Thị Kim' , N'kimhoang_123@gmail.com' , N'member_7.jpg' , N'student'),
		( 49 , N'ducnguyen_67' , N'Ducnguyen67' , N'Nguyễn Văn Đức' , N'ducnguyen_67@gmail.com' , N'member_6.jpg' , N'student'),
		( 50 , N'hanhpham_09' , N'Hanhpham09' , N'Phạm Thị Hạnh' , N'hanhpham_09@gmail.com' , N'member_5.jpg' , N'student'),
		( 51 , N'vuthithu' , N'VuThiThu123' , N'Vũ Thị Thu' , N'vuthithu@gmail.com' , N'instructor_1.jpg' , N'lecturer'),
		( 52 , N'tuannguyen' , N'TuanNguyen456' , N'Nguyễn Văn Tuấn' , N'tuannguyen@gmail.com' , N'instructor_2.jpg' , N'lecturer'),
		( 53 , N'ngocanhle' , N'NgocAnhLe789' , N'Lê Thị Ngọc Ánh' , N'ngocanhle@gmail.com' , N'instructor_3.jpg' , N'lecturer'),
		( 54 , N'hoavanh' , N'HoaVanH10' , N'Trần Văn Hòa' , N'hoavanh@gmail.com' , N'instructor_4.jpg' , N'lecturer'),
		( 55 , N'thuthupham' , N'ThuThuPham123' , N'Phạm Thị Thu Hà' , N'thuthupham@gmail.com' , N'instructor_5.jpg' , N'lecturer'),
		( 56 , N'hungnguyen' , N'HungNguyen999' , N'Nguyễn Văn Hưng' , N'hungnguyen@gmail.com' , N'instructor_6.jpg' , N'lecturer'),
		( 57 , N'halythu' , N'HaLyThu456' , N'Lý Thị Thu Hà' , N'halythu@gmail.com' , N'instructor_7.jpg' , N'lecturer'),
		( 58 , N'linhthuylinh' , N'LinhThuyLinh789' , N'Trần Thị Thùy Linh' , N'linhthuylinh@gmail.com' , N'instructor_8.jpg' , N'lecturer'),
		( 59 , N'hunghoang' , N'HungHoang567' , N'Hoàng Văn Hùng' , N'hunghoang@gmail.com' , N'instructor_9.jpg' , N'lecturer'),
		( 60 , N'hoaiannguyen' , N'HoaiAnNguyen123' , N'Nguyễn Thị Hoài An' , N'hoaiannguyen@gmail.com' , N'instructor_10.jpg' , N'lecturer'),
		( 61 , N'datlyvan' , N'DatLyVan456' , N'Lý Văn Đạt' , N'datlyvan@gmail.com' , N'instructor_11.jpg' , N'lecturer')
set identity_insert [users] off 

go
set identity_insert [news] on 
insert into [news] ( [newsid], [title], [content], [publisheddate], [userid])
values  ( 1 , N'New1' , N'Content1', '2023-10-11', 21),
		( 2 , N'New2' , N'Content2', '2023-10-11', 21),
		( 3 , N'New3' , N'Content3', '2023-10-11', 21),
		( 4 , N'New4' , N'Content4', '2023-10-11', 21)
set identity_insert [news] off

go
set identity_insert [category] on
insert into [category] ([categoryid] , [categoryname])
values  ( 1 , '1'),
		( 2 , '2'),
		( 3 , '3'),
		( 4 , '4'),
		( 5 , '5'),
		( 6 , '6'),
		( 7 , '7'),
		( 8 , '8'),
		( 9 , '9'),
		( 10 , '10'),
		( 11 , '11'),
		( 12 , '12'),
		( 13 , 'University')
set identity_insert [category] off

go
set identity_insert [typecourse] on
insert into [typecourse]([typecourseid] , [typecoursename] , [categoryid])
values  ( 1 , N'Math' , 1),
		( 2 , N'Literature' , 1),
		( 3 , N'English' , 1),
		( 4 , N'Math' , 2),
		( 5 , N'Literature' , 2),
		( 6 , N'English' , 2),
		( 7 , N'Math' , 3),
		( 8 , N'Literature' , 3),
		( 9 , N'English' , 3),
		( 10 , N'Math' , 4),
		( 11 , N'Literature' , 4),
		( 12 , N'English' , 4),
		( 13 , N'Math' , 5),
		( 14 , N'Literature' , 5),
		( 15 , N'English' , 5),
		( 16 , N'Math' , 6),
		( 17 , N'Literature' , 6),
		( 18 , N'English' , 6),
		( 19 , N'Math' , 7),
		( 20 , N'Literature' , 7),
		( 21 , N'English' , 7),
		( 22 , N'Math' , 8),
		( 23 , N'Literature' , 8),
		( 24 , N'English' , 8),
		( 25 , N'Math' , 9),
		( 26 , N'Literature' , 9),
		( 27 , N'English' , 9),
		( 28 , N'Math' , 10),
		( 29 , N'Literature' , 10),
		( 30 , N'English' , 10),
		( 31 , N'Math' , 11),
		( 32 , N'Literature' , 11),
		( 33 , N'English' , 11),
		( 34 , N'Math' , 12),
		( 35 , N'Literature' , 12),
		( 36 , N'English' , 12),
		( 37 , N'Advanced Math' , 13),
		( 38 , N'Software Technology' , 13),
		( 39 , N'General Physics' , 13)
set identity_insert [typecourse] off

go
set identity_insert [courses] on
insert into [courses] ([courseid],[title],[description],[linkimg],[price],[typecourseid],[userid])
values  ( 1 , N'Toán 1' , N'Toán 1 cơ bản ' , N'course1.jpg', 10 , 1 , 10 ),
		( 2 , N'Toán 1' , N'Toán 1 vận dụng' , N'course2.jpg', 10 , 1 , 11 ),
		( 3 , N'Toán 1' , N'Toán 1 nâng cao' , N'course3.jpg', 10 , 1 , 12 ),
		( 4 , N'Văn 1' , N'Văn 1 cơ bản' , N'course4.jpg', 10 , 2 , 13 ),
		( 5 , N'Văn 1' , N'Văn 1 vận dụng' , N'course5.jpg', 10 , 2 , 14 ),
		( 6 , N'Văn 1' , N'Văn 1 nâng cao' , N'course6.jpg', 10 , 2 , 15 ),
		( 7 , N'Anh 1' , N'Anh 1 cơ bản' , N'course7.jpg', 10 , 3 , 16 ),
		( 8 , N'Anh 1' , N'Anh 1 vận dụng' , N'course8.jpg', 10 , 3 , 17 ),
		( 9 , N'Anh 1' , N'Anh 1 nâng cao' , N'course9.jpg', 10 , 3 , 18 ),
		( 10 , N'Toán 2' , N'Toán 2 cơ bản ' , N'course10.jpg', 10 , 4 , 19 ),
		( 11 , N'Toán 2' , N'Toán 2 vận dụng' , N'course11.jpg', 10 , 4 , 20 ),
		( 12 , N'Toán 2' , N'Toán 2 nâng cao' , N'course12.jpg', 10 , 4 , 10 ),
		( 13 , N'Văn 2' , N'Văn 2 cơ bản' , N'course13.jpg', 10 , 5 , 11 ),
		( 14 , N'Văn 2' , N'Văn 2 vận dụng' , N'course14.jpg', 10 , 5 , 12 ),
		( 15 , N'Văn 2' , N'Văn 2 nâng cao' , N'course15.jpg', 10 , 5 , 13 ),
		( 16 , N'Anh 2' , N'Anh 2 cơ bản' , N'course16.jpg', 10 , 6 , 14 ),
		( 17 , N'Anh 2' , N'Anh 2 vận dụng' , N'course17.jpg', 10 , 6 , 15 ),
		( 18 , N'Anh 2' , N'Anh 2 nâng cao' , N'course18.jpg', 10 , 6 , 16 ),
		( 19 , N'Toán 3' , N'Toán 3 cơ bản ' , N'course1.jpg', 10 , 7 , 17 ),
		( 20 , N'Toán 3' , N'Toán 3 vận dụng' , N'course2.jpg', 10 , 7 , 18 ),
		( 21 , N'Toán 3' , N'Toán 3 nâng cao' , N'course3.jpg', 10 , 7 , 19 ),
		( 22 , N'Văn 3' , N'Văn 3 cơ bản' , N'course4.jpg', 10 , 8 , 20 ),
		( 23 , N'Văn 3' , N'Văn 3 vận dụng' , N'course5.jpg', 10 , 8 , 10 ),
		( 24 , N'Văn 3' , N'Văn 3 nâng cao' , N'course6.jpg', 10 , 8 , 11 ),
		( 25 , N'Anh 3' , N'Anh 3 cơ bản' , N'course7.jpg', 10 , 9 , 12 ),
		( 26 , N'Anh 3' , N'Anh 3 vận dụng' , N'course8.jpg', 10 , 9 , 13 ),
		( 27 , N'Anh 3' , N'Anh 3 nâng cao' , N'course9.jpg', 10 , 9 , 14 ),
		( 28 , N'Toán 4' , N'Toán 4 cơ bản ' , N'course10.jpg', 10 , 10 , 15 ),
		( 29 , N'Toán 4' , N'Toán 4 vận dụng' , N'course11.jpg', 10 , 10 , 16 ),
		( 30 , N'Toán 4' , N'Toán 4 nâng cao' , N'course12.jpg', 10 , 10 , 17 ),
		( 31 , N'Văn 4' , N'Văn 4 cơ bản' , N'course13.jpg', 10 , 11 , 18 ),
		( 32 , N'Văn 4' , N'Văn 4 vận dụng' , N'course14.jpg', 10 , 11 , 19 ),
		( 33 , N'Văn 4' , N'Văn 4 nâng cao' , N'course15.jpg', 10 , 11 , 20 ),
		( 34 , N'Anh 4' , N'Anh 4 cơ bản' , N'course16.jpg', 10 , 12 , 10 ),
		( 35 , N'Anh 4' , N'Anh 4 vận dụng' , N'course17.jpg', 10 , 12 , 11 ),
		( 36 , N'Anh 4' , N'Anh 4 nâng cao' , N'course18.jpg', 10 , 12 , 12 ),
		( 37 , N'Toán 5' , N'Toán 5 cơ bản ' , N'course1.jpg', 10 , 13 , 13 ),
		( 38 , N'Toán 5' , N'Toán 5 vận dụng' , N'course2.jpg', 10 , 13 , 14 ),
		( 39 , N'Toán 5' , N'Toán 5 nâng cao', N'course3.jpg' , 10 , 13 , 15 ),
		( 40 , N'Văn 5' , N'Văn 5 cơ bản', N'course4.jpg' , 10 , 14 , 16 ),
		( 41 , N'Văn 5' , N'Văn 5 vận dụng', N'course5.jpg' , 10 , 14 , 17 ),
		( 42 , N'Văn 5' , N'Văn 5 nâng cao', N'course6.jpg' , 10 , 14 , 18 ),
		( 43 , N'Anh 5' , N'Anh 5 cơ bản' , N'course7.jpg', 10 , 15 , 19 ),
		( 44 , N'Anh 5' , N'Anh 5 vận dụng' , N'course8.jpg', 10 , 15 , 20 ),
		( 45 , N'Anh 5' , N'Anh 5 nâng cao' , N'course9.jpg', 10 , 15 , 10 ),
		( 46 , N'Toán 6' , N'Toán 6 cơ bản ', N'course10.jpg' , 10 , 16 , 11 ),
		( 47 , N'Toán 6' , N'Toán 6 vận dụng', N'course11.jpg' , 10 , 16 , 12 ),
		( 48 , N'Toán 6' , N'Toán 6 nâng cao' , N'course12.jpg', 10 , 17 , 13 ),
		( 49 , N'Văn 6' , N'Văn 6 cơ bản', N'course13.jpg' , 10 , 17 , 14 ),
		( 50 , N'Văn 6' , N'Văn 6 vận dụng', N'course14.jpg' , 10 , 17 , 15 ),
		( 51 , N'Văn 6' , N'Văn 6 nâng cao', N'course15.jpg' , 10 , 17 , 16 ),
		( 52 , N'Anh 6' , N'Anh 6 cơ bản' , N'course16.jpg', 10 , 18 , 17 ),
		( 53 , N'Anh 6' , N'Anh 6 vận dụng', N'course17.jpg' , 10 , 18 , 18 ),
		( 54 , N'Anh 6' , N'Anh 6 nâng cao', N'course18.jpg' , 10 , 18 , 19 ),
		( 55 , N'Toán 7' , N'Toán 7 cơ bản ', N'course1.jpg' , 10 , 19 , 20 ),
		( 56 , N'Toán 7' , N'Toán 7 vận dụng' , N'course2.jpg', 10 , 19 , 10 ),
		( 57 , N'Toán 7' , N'Toán 7 nâng cao', N'course3.jpg' , 10 , 19 , 11 ),
		( 58 , N'Văn 7' , N'Văn 7 cơ bản', N'course4.jpg' , 10 , 20 , 12 ),
		( 59 , N'Văn 7' , N'Văn 7 vận dụng', N'course5.jpg' , 10 , 20 , 13 ),
		( 60 , N'Văn 7' , N'Văn 7 nâng cao', N'course6.jpg' , 10 , 20 , 14 ),
		( 61 , N'Anh 7' , N'Anh 7 cơ bản', N'course7.jpg' , 10 , 21 , 15 ),
		( 62 , N'Anh 7' , N'Anh 7 vận dụng', N'course8.jpg' , 10 , 21 , 16 ),
		( 63 , N'Anh 7' , N'Anh 7 nâng cao', N'course9.jpg' , 10 , 21 , 17 ),
		( 64 , N'Toán 8' , N'Toán 8 cơ bản ', N'course10.jpg' , 10 , 22 , 18 ),
		( 65 , N'Toán 8' , N'Toán 8 vận dụng', N'course11.jpg' , 10 , 22 , 19 ),
		( 66 , N'Toán 8' , N'Toán 8 nâng cao', N'course12.jpg' , 10 , 22 , 20 ),
		( 67 , N'Văn 8' , N'Văn 8 cơ bản' , N'course13.jpg', 10 , 23 , 10 ),
		( 68 , N'Văn 8' , N'Văn 8 vận dụng' , N'course14.jpg', 10 , 23 , 11 ),
		( 69 , N'Văn 8' , N'Văn 8 nâng cao' , N'course15.jpg', 10 , 23 , 12 ),
		( 70 , N'Anh 8' , N'Anh 8 cơ bản' , N'course16.jpg', 10 , 24 , 13 ),
		( 71 , N'Anh 8' , N'Anh 8 vận dụng' , N'course17.jpg', 10 , 24 , 14 ),
		( 72 , N'Anh 8' , N'Anh 8 nâng cao', N'course18.jpg' , 10 , 24 , 15 ),
		( 73 , N'Toán 9' , N'Toán 9 cơ bản ' , N'course1.jpg', 10 , 25 , 16 ),
		( 74 , N'Toán 9' , N'Toán 9 vận dụng', N'course2.jpg' , 10 , 25 , 17 ),
		( 75 , N'Toán 9' , N'Toán 9 nâng cao', N'course3.jpg' , 10 , 25 , 18 ),
		( 76 , N'Văn 9' , N'Văn 9 cơ bản' , N'course4.jpg', 10 , 26 , 19 ),
		( 77 , N'Văn 9' , N'Văn 9 vận dụng', N'course5.jpg' , 10 , 26 , 20 ),
		( 78 , N'Văn 9' , N'Văn 9 nâng cao', N'course6.jpg' , 10 , 26 , 10 ),
		( 79 , N'Anh 9' , N'Anh 9 cơ bản', N'course7.jpg' , 10 , 27 , 11 ),
		( 80 , N'Anh 9' , N'Anh 9 vận dụng', N'course8.jpg' , 10 , 27 , 12 ),
		( 81 , N'Anh 9' , N'Anh 9 nâng cao' , N'course9.jpg', 10 , 27 , 13 ),
		( 82 , N'Toán 10' , N'Toán 10 cơ bản ', N'course10.jpg' , 10 , 28 , 14 ),
		( 83 , N'Toán 10' , N'Toán 10 vận dụng', N'course11.jpg' , 10 , 28 , 15 ),
		( 84 , N'Toán 10' , N'Toán 10 nâng cao', N'course12.jpg' , 10 , 28 , 16 ),
		( 85 , N'Văn 10' , N'Văn 10 cơ bản', N'course13.jpg' , 10 , 29 , 17 ),
		( 86 , N'Văn 10' , N'Văn 10 vận dụng' , N'course14.jpg', 10 , 29 , 18 ),
		( 87 , N'Văn 10' , N'Văn 10 nâng cao', N'course15.jpg' , 10 , 29 , 19 ),
		( 88 , N'Anh 10' , N'Anh 10 cơ bản' , N'course16.jpg', 10 , 30 , 20 ),
		( 89 , N'Anh 10' , N'Anh 10 vận dụng', N'course17.jpg' , 10 , 30 , 10 ),
		( 90 , N'Anh 10' , N'Anh 10 nâng cao', N'course18.jpg' , 10 , 30 , 11 ),
		( 91 , N'Toán 11' , N'Toán 11 cơ bản ', N'course1.jpg' , 10 , 31 , 12 ),
		( 92 , N'Toán 11' , N'Toán 11 vận dụng', N'course2.jpg' , 10 , 31 , 13 ),
		( 93 , N'Toán 11' , N'Toán 11 nâng cao' , N'course3.jpg', 10 , 31 , 14 ),
		( 94 , N'Văn 11' , N'Văn 11 cơ bản' , N'course4.jpg', 10 , 32 , 15 ),
		( 95 , N'Văn 11' , N'Văn 11 vận dụng' , N'course5.jpg', 10 , 32 , 16 ),
		( 96 , N'Văn 11' , N'Văn 11 nâng cao', N'course6.jpg' , 10 , 32 , 17 ),
		( 97 , N'Anh 11' , N'Anh 11 cơ bản' , N'course7.jpg', 10 , 33 , 18 ),
		( 98 , N'Anh 11' , N'Anh 11 vận dụng', N'course8.jpg' , 10 , 33 , 19 ),
		( 99 , N'Anh 11' , N'Anh 11 nâng cao', N'course9.jpg' , 10 , 33 , 20 ),
		( 100 , N'Toán 12' , N'Toán 12 cơ bản ', N'course10.jpg' , 10 , 34 , 10 ),
		( 101 , N'Toán 12' , N'Toán 12 vận dụng' , N'course11.jpg', 10 , 34 , 11 ),
		( 102 , N'Toán 12' , N'Toán 12 nâng cao', N'course12.jpg' , 10 , 34 , 12 ),
		( 103 , N'Văn 12' , N'Văn 12 cơ bản', N'course13.jpg' , 10 , 35 , 13 ),
		( 104 , N'Văn 12' , N'Văn 12 vận dụng' , N'course14.jpg', 10 , 35 , 14 ),
		( 105 , N'Văn 12' , N'Văn 12 nâng cao', N'course15.jpg' , 10 , 35 , 15 ),
		( 106 , N'Anh 12' , N'Anh 12 cơ bản', N'course16.jpg' , 10 , 36 , 16 ),
		( 107 , N'Anh 12' , N'Anh 12 vận dụng' , N'course17.jpg', 10 , 36 , 17 ),
		( 108 , N'Anh 12' , N'Anh 12 nâng cao' , N'course18.jpg', 10 , 36 , 18 ),
		( 109 , N'Toán Cao Cấp' , N'Toán Cao Cấp 1 ' , N'course1.jpg', 10 , 37 , 19 ),
		( 110 , N'Toán Cao Cấp' , N'Toán Cao Cấp 2', N'course2.jpg' , 10 , 37 , 20 ),
		( 111 , N'Toán Cao Cấp' , N'Toán Cao Cấp 3', N'course3.jpg' , 10 , 37 , 10 ),
		( 112 , N'Kỹ Thuật Phần Mềm' , N'Kỹ Thuật Phần Mềm 1', N'course4.jpg' , 10 , 38 , 11 ),
		( 113 , N'Kỹ Thuật Phần Mềm' , N'Kỹ Thuật Phần Mềm 2', N'course5.jpg' , 10 , 38 , 12 ),
		( 114 , N'Kỹ Thuật Phần Mềm' , N'Kỹ Thuật Phần Mềm 3', N'course6.jpg' , 10 , 38 , 13 ),
		( 115 , N'Lý Đại Cương' , N'Lý Đại Cương 1 ' , N'course7.jpg', 10 , 39 , 14 ),
		( 116 , N'Lý Đại Cương' , N'Lý Đại Cương 2', N'course8.jpg' , 10 , 39 , 15 ),
		( 117 , N'Lý Đại Cương' , N'Lý Đại Cương 3', N'course9.jpg' , 10 , 39 , 16 )
set identity_insert [courses] off

go 
set identity_insert [enrollments] on
insert into [enrollments] ([enrollmentid],[userid],[courseid])
values  ( 1 , 1 , 109),
		( 2 , 1 , 110),
		( 3 , 1 , 111),
		( 4 , 1 , 112),
		( 5 , 2 , 109),
		( 6 , 2 , 113),
		( 7 , 2 , 114),
		( 8 , 2 , 117),
		( 9 , 3 , 109),
		( 10 , 4 , 110),
		( 11 , 4 , 111),
		( 12 , 5 , 112),
		( 13 , 5 , 115),
		( 14 , 5 , 116),
		( 15 , 6 , 109),
		( 16 , 6 , 110),
		( 17 , 6 , 113),
		( 18 , 6 , 116),
		( 19 , 6 , 115),
		( 20 , 7 , 109),
		( 21 , 7 , 110),
		( 22 , 8 , 109),
		( 23 , 9 , 109),
		( 24 , 9 , 112)
set identity_insert [enrollments] off
go 
set identity_insert [grades] on
insert into [grades] ([gradeid], [midtermscore], [finalscore], [average], [enrollmentid])
values  ( 1 , 8.8 , 9 , 8.9 , 1 ),
		( 2 , 8.6 , 9 , 8.8 , 2 ),
		( 3 , 8.4 , 9 , 8.7 , 3 ),
		( 4 , 8.2 , 9 , 8.6 , 4 ),
		( 5 , 8 , 9 , 8.5 , 5 ),
		( 6 , 8.2 , 9 , 8.6 , 6 ),
		( 7 , 8.4 , 9 , 8.7 , 7 ),
		( 8 , 8.6 , 9 , 8.8 , 8 ),
		( 9 , 8.8 , 9 , 8.9 , 9 ),
		( 10 , 7 , 9 , 8 , 10 ),
		( 11 , 7.8 , 9 , 8.4 , 11 ),
		( 12 , 6.8 , 9 , 7.9 , 12 ),
		( 13 , 8.2 , 9 , 8.6 , 13 ),
		( 14 , 8.8 , 9 , 8.9 , 14 ),
		( 15 , 8.4 , 9 , 8.7 , 15),
		( 16 , 8.8 , 9 , 8.9 , 16 ),
		( 17 , 8.8 , 9 , 8.9 , 17 ),
		( 18 , 8.8 , 9 , 8.9 , 18 ),
		( 19 , 8.8 , 9 , 8.9 , 19 ),
		( 20 , 8.8 , 9 , 8.9 , 20 ),
		( 21 , 8.8 , 9 , 8.9 , 21 ),
		( 22 , 8.8 , 9 , 8.9 , 22 ),
		( 23 , 8.8 , 9 , 8.9 , 23 ),
		( 24 , 8.8 , 9 , 8.9 , 24 )
set identity_insert [grades] off

go 
set identity_insert [lessons] on
insert into [lessons]([lessonid],[lessonname],[courseid])
values  ( 1 , N'Slide chapter 1' , 109),
		( 2 , N'Slide chapter 2' , 109),
		( 3 , N'Slide chapter 3' , 109),
		( 4 , N'Slide chapter 4' , 109)
set identity_insert [lessons] off

go 
set identity_insert [document] on
insert into [document]([documentid],[lessonsid],[slideurl],[videourl])
values  ( 1 , 1 , N'slidechapter1.xlsx', null),
		( 2 , 1 , N'slidechapter1a.xlsx', null),
		( 3 , 2 , N'slidechapter2.xlsx', null),
		( 4 , 2 , N'slidechapter2a.xlsx', null),
		( 5 , 3 , N'slidechapter3.xlsx', null),
		( 6 , 3 , N'slidechapter3a.xlsx', null),
		( 7 , 4 , N'slidechapter4.xlsx', null),
		( 8 , 4 , N'slidechapter4a.xlsx', null)
set identity_insert [document] off
go
insert into [shift]([shiftid],[dayofweek],[shiftname])
values  ( 1 , 'Monday' , 1 ),
		( 2 , 'Monday' , 2 ),
		( 3 , 'Monday' , 3 ),
		( 4 , 'Monday' , 4 ),
		( 5 , 'Monday' , 5 ),
		( 6 , 'Monday' , 6 ),
		( 7 , 'Tuesday' , 1 ),
		( 8 , 'Tuesday' , 2 ),
		( 9 , 'Tuesday' , 3 ),
		( 10 , 'Tuesday' , 4 ),
		( 11 , 'Tuesday' , 5 ),
		( 12 , 'Tuesday' , 6 ),
		( 13 , 'Wednesday' , 1 ),
		( 14 , 'Wednesday' , 2 ),
		( 15 , 'Wednesday' , 3 ),
		( 16 , 'Wednesday' , 4 ),
		( 17 , 'Wednesday' , 5 ),
		( 18 , 'Wednesday' , 6 ),
		( 19 , 'Thursday' , 1 ),
		( 20 , 'Thursday' , 2 ),
		( 21 , 'Thursday' , 3 ),
		( 22 , 'Thursday' , 4 ),
		( 23 , 'Thursday' , 5 ),
		( 24 , 'Thursday' , 6 ),
		( 25 , 'Friday' , 1 ),
		( 26 , 'Friday' , 2 ),
		( 27 , 'Friday' , 3 ),
		( 28 , 'Friday' , 4 ),
		( 29 , 'Friday' , 5 ),
		( 30 , 'Friday' , 6 )



select *
from [users]