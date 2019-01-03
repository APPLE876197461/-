create database FishAndBearPaw
on(
	name='FishAndBearPaw_mdf',
	filename='E:\HXD\ASP.NET\鱼和熊掌\数据库\FishAndBearPaw.mdf'
)
log on(
	name='FishAndBearPaw_ldf',
	filename='E:\HXD\ASP.NET\鱼和熊掌\数据库\FishAndBearPaw.ldf'
)
--创建字典表
create table td_Code(
Desstr nvarchar(10) primary key,	--名称，主键
GroupId int,						--类型ID
[State] int,						--状态
OrderBy int,						--排序
)

--创建字典类型表
create table td_CodeType(
GroupId int primary key,			--类型ID，主键
GroupStr nvarchar(10),				--类型名称，人员1，标签2，注册来源3，发布信息布局4
Oint int,							--类型组
)

--创建用户表
create table td_User(
id int primary key identity(1,1),	--用户ID，主键
User_hd nvarchar(50),				--头像
UserName nvarchar(20),				--用户名
Pwd nvarchar(20),					--密码
WhereCom int,						--注册来源
[State] int check([State]=0 or [State]=1 or [State]=2),--状态，0可用，1拉黑，2禁言
RegTime datetime,					--注册时间
PhoneNum nvarchar(20),				--手机号
PetName nvarchar(10),				--昵称
Sex int check(Sex=0 or Sex=1),		--性别 0:男 1:女
Pinfo nvarchar(10),					--简介
Utype int,							--用户类型
UserImg nvarchar(50),				--用户中心上面的图片
)

--创建发布表
create table td_Content(
id int primary key identity(1,1),	--发布表ID，主键
UserId int references td_User(id),  --用户ID
Content1 nvarchar(50),				--内容1(图片)
Content2 nvarchar(50),				--内容2(图片)
Code_id int,						--布局，0横着，1不可用
[State] int,						--状态，0可用，1不可用
[Des] nvarchar(140),				--描述
AddTime datetime default(getdate()),--发布时间
Content1Num int,					--内容1票选数
Content2Num int,					--内容2票选数
Tag nvarchar(500),					--标签，用","分隔
Fw int check(Fw=0 or Fw=1),			--可见范围，0全部可见，1关注我的人可见
)

--创建留言表
create table td_Call(
id int primary key identity(1,1),		--留言表ID，主键
UserId int references td_User(id),	    --用户Id
Content_id int references td_Content(id),--发布表，Content_id如果是-1，则是回复的
AddTime datetime default(getdate()),	--留言时间
Msg nvarchar(140),						--留言内容
[State] int,							--状态，0可用，1不可用
ReplyId int references td_Call(id),		--对哪条留言回复的，留言表ID
UserName2 int references td_User(id),	--关联用户，用于关联用户显示最新消息
LookU int check(LookU=0 or LookU=1),	--关联用户是否查看，1为已查看，0为未查看
cid int references td_Content(id),		--关联的发布表id，外键(发布表)
)

--创建留言是否查看表
create table td_CallLook(
id int primary key identity(1,1),							--ID主键
UserId int references td_User(id),						    --用户ID
Call_id int references td_Content(id),						--留言表ID，Content_id的值
AddTime datetime default(getdate()),						--查看时间
)

--创建投票表
create table td_Vote(
id int primary key references td_User(id),					--ID主键
UserId int references td_User(id),						    --用户ID
ContentId int references td_Content(id),					--投票的发布表Id
AddTime datetime default(getdate()),						--投票时间
ContentInt int check(ContentInt=1 or ContentInt=2),			--投票内容，1代表第一张图片，2代表第二张图片
[State] int check([State]=0 or [State]=1),					--状态，0可用，1不可用
)

--创建关注表
create table td_Attention(
id int primary key identity(1,1),					        --关注表ID，主键
UserId int references td_User(id),						    --用户Id
User_IdLook nvarchar(20),									--关注的用户Id
CheckTime datetime default(getdate()),					    --关注时间
[State] int check([State]=0 or [State]=1),					--状态，0可用，1不可用
)

--创建举报表
create table td_ReportTable(
id int primary key identity(1,1),					        --ID主键
UserName int references td_User(id),						--用户Id
Content_Id int references td_Content(id),					--举报的发布表
AddTime datetime default(getdate()),						--举报时间
[Des] nvarchar(200),										--举报说明
)

--创建屏蔽表
create table td_shield(
id int primary key references td_User(id),					--ID主键
UserId int references td_User(id),						    --用户Id
UserId2 nvarchar(20),										--屏蔽的用户Id
AddTime datetime default(getdate()),						--屏蔽时间
)