--SENTAR RAZON
--https://www.youtube.com/watch?v=mMJns0A5pCo
--HACER UNA IMPUGNACION
--Hay primero que realizar un impugnaci�n del min 6  "Procesos Juridicos:impugnaciones:Gestionar Impugnaciones administrativas" Script consultaDatos
--"Gestion personas:persona:Administrar persona" a�adir el correo electronico de interes
--**********************************
--Procesos Juridicos: Sentar Raz�n *
--**********************************

--RAZON_NOTI_RES_ADMIN 2649 78 ok
--RAZON_NOTI_CORREO 2650 9  OK
--RAZON_NO_PRUEBAS 2651 76 ok
--RAZON_NOTI_TRA_ADMIN 2652 10157 ok
--RAZON_SI_PRUEBAS 2653 10094 ok
--RAZON_CIER_SUBS_CAL 2457 10156 no se deja crear nueva version tambien al editarla PENDIENTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

--(2649,2650,2651,2652,2653)

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'RAZON_CIER_SUBS_CAL';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZ�N
update documentos..plantilla set fecha_inicio='2024-04-23' where id_plantilla in(2649,2650,2651,2652,2653,2457)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- C�digos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(2649,2650,2651,2652,2653)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISI�N DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=2628--2648--2604  -    *
--Impugnaci�n de comparendo	Apertura impugnaci�n sin tercero	APERT_IMPUG_SIN_TERC
																																	   *
select top 200 *from [documentos].[dbo].[documento] order by 1 desc																	   *
--**************************************************************************************************************************************

select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2647' order by 1 desc


select *from parametro
select upper(nombre) cargo(NOLOCK) where id_cargo==11

select (valor_parametro_defecto) from parametro
where codigo_parametro=434

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 5 p.codigo_plantilla from documentos.dbo.documento d
inner join documentos.dbo.plantilla p on d.id_plantilla=p.id_plantilla
order by 1 desc
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--DATOS PARA PRUEBA
--GLT0230
--gqh0010
--GNA0319
--RTB0950
--GPN0289
--GBL0616
--HZ370D
--GS09740
--GPJ0369
--GQH0870
--GLL0890 
--GIK0109 *
--GRW7830 x
------------------------------------------------------------------------------------

select *from interes



