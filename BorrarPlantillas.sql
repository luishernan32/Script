--QUERY GENERAR  eliminar 2650

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCIA_ANULAR';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

---------------------------------------------------------------
begin tran
delete from documentos..plantilla   where id_plantilla=4762
commit tran
---------------------------------------------------------------
begin tran
delete from documentos..jasper_plantilla   where id_plantilla=4762
commit tran

begin tran
delete from documentos..xml_plantilla   where id_xml_plantilla=4762
commit tran

begin tran
delete from documentos..variable_plantilla   where id_plantilla=4762
commit tran


-----------------------------------------------------------------
begin tran--Afecta varias rows
delete from documentos..documento   where id_plantilla=4762
commit tran

begin tran
--delete select *from documentos.dbo.documento where id_documento in(18204887,18204888,18204889,18204890,18204891) 
begin tran
delete from documentos.dbo.documento where id_documento in(18204887,18204888,18204889,18204890,18204891) commit tran

select *from documentos..documento d
left join documentos..xml_documento xd on d.id_documento=xd.id_xml_documento
where id_plantilla=4762
-----------------------------------------------------------------
begin tran
delete from documentos..xml_documento   where id_xml_documento in(18204888,18204889,18204890)