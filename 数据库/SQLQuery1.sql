create database FishAndBearPaw
on(
	name='FishAndBearPaw_mdf',
	filename='E:\HXD\ASP.NET\�������\���ݿ�\FishAndBearPaw.mdf'
)
log on(
	name='FishAndBearPaw_ldf',
	filename='E:\HXD\ASP.NET\�������\���ݿ�\FishAndBearPaw.ldf'
)
--�����ֵ��
create table td_Code(
Desstr nvarchar(10) primary key,	--���ƣ�����
GroupId int,						--����ID
[State] int,						--״̬
OrderBy int,						--����
)

--�����ֵ����ͱ�
create table td_CodeType(
GroupId int primary key,			--����ID������
GroupStr nvarchar(10),				--�������ƣ���Ա1����ǩ2��ע����Դ3��������Ϣ����4
Oint int,							--������
)

--�����û���
create table td_User(
id int primary key identity(1,1),	--�û�ID������
User_hd nvarchar(50),				--ͷ��
UserName nvarchar(20),				--�û���
Pwd nvarchar(20),					--����
WhereCom int,						--ע����Դ
[State] int check([State]=0 or [State]=1 or [State]=2),--״̬��0���ã�1���ڣ�2����
RegTime datetime,					--ע��ʱ��
PhoneNum nvarchar(20),				--�ֻ���
PetName nvarchar(10),				--�ǳ�
Sex int check(Sex=0 or Sex=1),		--�Ա� 0:�� 1:Ů
Pinfo nvarchar(10),					--���
Utype int,							--�û�����
UserImg nvarchar(50),				--�û����������ͼƬ
)

--����������
create table td_Content(
id int primary key identity(1,1),	--������ID������
UserId int references td_User(id),  --�û�ID
Content1 nvarchar(50),				--����1(ͼƬ)
Content2 nvarchar(50),				--����2(ͼƬ)
Code_id int,						--���֣�0���ţ�1������
[State] int,						--״̬��0���ã�1������
[Des] nvarchar(140),				--����
AddTime datetime default(getdate()),--����ʱ��
Content1Num int,					--����1Ʊѡ��
Content2Num int,					--����2Ʊѡ��
Tag nvarchar(500),					--��ǩ����","�ָ�
Fw int check(Fw=0 or Fw=1),			--�ɼ���Χ��0ȫ���ɼ���1��ע�ҵ��˿ɼ�
)

--�������Ա�
create table td_Call(
id int primary key identity(1,1),		--���Ա�ID������
UserId int references td_User(id),	    --�û�Id
Content_id int references td_Content(id),--������Content_id�����-1�����ǻظ���
AddTime datetime default(getdate()),	--����ʱ��
Msg nvarchar(140),						--��������
[State] int,							--״̬��0���ã�1������
ReplyId int references td_Call(id),		--���������Իظ��ģ����Ա�ID
UserName2 int references td_User(id),	--�����û������ڹ����û���ʾ������Ϣ
LookU int check(LookU=0 or LookU=1),	--�����û��Ƿ�鿴��1Ϊ�Ѳ鿴��0Ϊδ�鿴
cid int references td_Content(id),		--�����ķ�����id�����(������)
)

--���������Ƿ�鿴��
create table td_CallLook(
id int primary key identity(1,1),							--ID����
UserId int references td_User(id),						    --�û�ID
Call_id int references td_Content(id),						--���Ա�ID��Content_id��ֵ
AddTime datetime default(getdate()),						--�鿴ʱ��
)

--����ͶƱ��
create table td_Vote(
id int primary key references td_User(id),					--ID����
UserId int references td_User(id),						    --�û�ID
ContentId int references td_Content(id),					--ͶƱ�ķ�����Id
AddTime datetime default(getdate()),						--ͶƱʱ��
ContentInt int check(ContentInt=1 or ContentInt=2),			--ͶƱ���ݣ�1�����һ��ͼƬ��2����ڶ���ͼƬ
[State] int check([State]=0 or [State]=1),					--״̬��0���ã�1������
)

--������ע��
create table td_Attention(
id int primary key identity(1,1),					        --��ע��ID������
UserId int references td_User(id),						    --�û�Id
User_IdLook nvarchar(20),									--��ע���û�Id
CheckTime datetime default(getdate()),					    --��עʱ��
[State] int check([State]=0 or [State]=1),					--״̬��0���ã�1������
)

--�����ٱ���
create table td_ReportTable(
id int primary key identity(1,1),					        --ID����
UserName int references td_User(id),						--�û�Id
Content_Id int references td_Content(id),					--�ٱ��ķ�����
AddTime datetime default(getdate()),						--�ٱ�ʱ��
[Des] nvarchar(200),										--�ٱ�˵��
)

--�������α�
create table td_shield(
id int primary key references td_User(id),					--ID����
UserId int references td_User(id),						    --�û�Id
UserId2 nvarchar(20),										--���ε��û�Id
AddTime datetime default(getdate()),						--����ʱ��
)