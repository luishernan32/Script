--------------Actualización de plantillas-----------------------
--ACTA_POSESION_DEP  id_plantilla_config=73     id_plantilla= 2524  
--PROVIDENCIA_PAGO   id_plantilla_config=61     id_plantilla= 2148  "Faltan datos prueba"
--OFICIO_EMBARGO     id_plantilla_config=74     id_plantilla=2483 
--ORDEN_EMBARGO      id_plantilla_config=72     id_plantilla= 2485
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'ORDEN_EMBARGO';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2023-06-21' where id_plantilla=2532
update documentos..plantilla set fecha_inicio='2023-08-13' where id_plantilla=2485
commit tran