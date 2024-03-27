select *from rol



select *from rol
where id_rol='1060'


begin tran
delete rol
where id_rol='1061'
commit tran

--1060	Director	Tiene permisos para cambiar fechas	1	2	3