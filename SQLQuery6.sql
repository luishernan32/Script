select top 100 *from coactivo c
join proceso p on p.id_proceso=c.id_proceso
join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso
where p.id_estado_proceso not in (31,27,28) and tp.id_estado_proceso not in(29)
and c.anio=2019

--6932011
--6000362 0922791215

--14823735 x
--14823733 12909659

select top 100 
c.numero_coactivo,
c.id_tramite,
c.valor_total_obligaciones,
c.valor_total_costas_procesales,
p.observacion
from coactivo c
join proceso p on p.id_proceso=c.id_proceso
join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso
where p.id_estado_proceso not in (31,27,28) and tp.id_estado_proceso not in(29)
and c.anio=2019 and p.observacion='SOLICITUD BUSQUEDA DE BIENES'

-- id_tramite 8394314   176.65
-- 7274185	8394314
--Ver documentos con numero de coactivo: 12909666

-------------------Insert------------------------------

INSERT INTO integracion_terceros.dbo.it_recaudo (codigo_organismo ,fecha_transaccion ,
hora_transaccion ,numero_recaudo ,numero_cuenta ,
codigo_tipo_cuenta ,
codigo_banco ,total_efectivo ,total_cheque ,total_recaudo,
codigo_tipo_identificacion ,numero_identificacion ,estado_lectura ,numero_obligacion ,valor_obligacion ,numero_cuota ,codigo_tipo_recaudo ,fecha_creacion ,usuario,total_tcr) VALUES
(11001,'2023-08-11' ,'08:08:00.0000000',777677679795994, --nro recaudo ir aumentando, que no se repita
NULL,NULL,'BPA',
NULL, --total pago
NULL,0, --total pago
NULL,NULL,1,12909668,  --factura finan    --4007661  3087948
0, --total pago
0, --cuota
'02',---tipo recaudo
getdate(),
'axis',
0)  ----total_tcr

--------------------------------------------------------------------------------------

select *from integracion_terceros..it_recaudo where numero_recaudo='777677679790892'

select *from detalle_pago 
where numero_obligacion='7274185'




select top 100 *from coactivo c
join proceso p on p.id_proceso=c.id_proceso
join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso
where p.id_estado_proceso not in (31,27,28) and tp.id_estado_proceso not in(29)
and c.anio=2019


---------------

SELECT numero_proceso,
       Concat (p.numero_proceso, '-', c.anio),
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper (pj.nombre_comercial)
         ELSE
Upper(
       Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2))
       END AS nombreCompleto,
       pe.numero_identificacion
FROM   proceso p
       JOIN coactivo c (nolock)
         ON c.id_proceso = p.id_proceso
       JOIN persona pe
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
WHERE  c.id_coactivo = 2108038


select *from coactivo
where numero_coactivo='12909666' 

--REGISTRO_FALLO id_plantilla=2542  id_plantilla_config=2
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'REGISTRO_FALLO';
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

select *from  documentos..plantilla where codigo_plantilla like '%Resol%'--=@codigoPlantilla

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--REGISTRO_FALLO id_plantilla=2542  id_plantilla_config=2
begin tran
--update documentos..plantilla set fecha_fin='2023-06-21' where id_plantilla=2532
update documentos..plantilla set fecha_inicio='2023-08-31' where id_plantilla=2542--2524
commit tran


select *from coactivo c
join proceso p on c.id_proceso=p.id_proceso
where p.id_estado_proceso=29

--3088013