-- resumen de errores
--Vamos a ver el detalle del error

select  *,
case when error  like '%UNIQUE KEY%' then 'Incidencia al Registrar Datos Documento' else error end erro_presentacion
into #tmp_reporte_reconstr_sol_bienes
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where procesado = 0
and error is not null

select * from #tmp_reporte_reconstr_sol_bienes


select * from #tmp_reporte_reconstr_sol_bienes

select  rs.erro_presentacion, COUNT (id_reconstruccion) cantidad from #tmp_reporte_reconstr_sol_bienes rs
where procesado = 0
and error is not null
group by rs.erro_presentacion
order by COUNT (id_reconstruccion) desc


select MAX(fecha_procesamiento) from #tmp_reporte_reconstr_sol_bienes




-- resumen de errores
--Vamos a ver el detalle del error

select  *,
case when error  like '%UNIQUE KEY%' then 'Incidencia al Registrar Datos Documento' else error end erro_presentacion
into #tmp_reporte_reconstr_sol_bienes
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null

select * from #tmp_reporte_reconstr_sol_bienes

select  rs.erro_presentacion, COUNT (id_consecutivo_reconstruccion) cantidad from #tmp_reporte_reconstr_sol_bienes rs
where procesado = 0
and error is not null
group by rs.erro_presentacion
order by COUNT (id_consecutivo_reconstruccion) desc


select MAX(fecha_procesamiento) from #tmp_reporte_reconstr_sol_bienes






select  *,
case when error  like '%UNIQUE KEY%' then 'El coactivo no ha sido NOTIFICADO' else error end erro_presentacion
into #tmp_reporte_reconstr_sol_bienes
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where procesado = 0
and error is not null


------Me muestra la información del error numero de Juicios y all sus datos-------------------
--25/09/2024
select *from #tmp_reporte_reconstr_sol_bienes rs
where erro_presentacion='El coactivo no ha sido NOTIFICADO'

--------------------------------------------------------------------------------------------------------------
--reconstr_notifica_coactivo_multas

select *from integracion_terceros.dbo.reconstr_notifica_coactivo_multas
where numero_juicio in--('239514','239529','239565','239583','239663')
('239514-2023','239529-2023','239565-2023','239583-2023','239663-2023')


select top 1 *from circulemos2.dbo.coactivo
select top 1 *from circulemos2.dbo.obligacion_coactivo
select top 1 *from circulemos2.dbo.proceso

--------------------------------------------------------------------------------------------------------------

/*--- Reprocesamiento  -- Debe ser enviado a DBA.
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
set error = null
where procesado = 0
and error is not null
COMMIT TRAN

EXEC circulemos2.[dbo].[sp_reconstruir_solicitud_bienes_coactivo_documentos]

--Creese una tarea para los coactivos Notificados, estos de aquí ya debería saber como resolverlo
*/


----------------------------------------------------------------------------------------------


select  * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null
and error = 'El proceso coactivo no existe'



select top 10 *from integracion_terceros.dbo.reconstr_notifica_coactivo_multas
where NUMERO_JUICIO='314769-2023'



select po.numero_proceso,co.numero_coactivo,id_tramite,oc.numero_obligacion, concat(po.numero_proceso,'-',year(po.fecha_inicio)) as juicio,co.fecha_notificacion,co.id_tipo_notificacion_coactivo
from circulemos2.dbo.coactivo co
inner join circulemos2.dbo.obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
inner join circulemos2.dbo.proceso po on po.id_proceso=co.id_proceso
--inner join persona pe on pe.id_persona=co.id_deudor
--where po.numero_proceso ='314769'
--where co.id_tramite='873422'
where po.numero_proceso in('239514','239529','239565','239583','239663')  --('239514-2023','239529-2023','239565-2023','239583-2023','239663-2023')
--in('314769','21280','319878','319883','326307','20046','319877','319882','15595','324828','319876','319880','15591','3003','324830','319875','319879','319884')
--='314769'
--in('','','','','','','','','','','','','','','','','','')
and year(po.fecha_inicio)='2023'

--Añada en la columna tipo y fecha de notificación

--Añada en la columna tipo y fecha de notificación

-------------------

select COUNT(1) as 'Solventados' from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where 1=1
and procesado = 1
and CONVERT(date, fecha_procesamiento)>=  CONVERT(date, '2024-09-04')



select top 2 *from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where error='No hay registro en tabla solicitud_bien_entidad'
--where error is not null

select top 2 *from circulemos2.dbo.coactivo
where id_coactivo in(2172266,2180484)

select top 2 *from circulemos2.dbo.solicitud_oficio_bien
where id_coactivo in(2172266,2180484)

select top 2 *from circulemos2.dbo.solicitud_bien_entidad
where id_solicitud_oficio_bien in(1805292,1805639)


--239514-2023
--239529-2023
--239565-2023
--239583-2023
--239663-2023


select 
*from circulemos2.dbo.solicitud_oficio_bien
where id_coactivo = 2172266
and fecha_solicitud = '2023-10-02'

--id_solicitud_oficio_bien 1805292

----------------------------

--- Reprocesamiento  -- Debe ser enviado a DBA.
/*BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
set error = null
where procesado = 0
and error is not null
and numero_juicio = '227539-2023'
COMMIT TRAN
 
EXEC circulemos2.[dbo].[sp_reconstruir_solicitud_bienes_coactivo_documentos]*/
 
select * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where numero_juicio ='227539-2023'


--- Reprocesamiento  -- Debe ser enviado a DBA.
--Rconstrucción de solicitud de bienes DB fase 2
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
set error = null
where procesado = 0
and error is not null
and numero_juicio in('100855-2017')
COMMIT TRAN

EXEC circulemos2.[dbo].[sp_reconstruir_solicitud_bienes_coactivo_documentos]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Consulta de errores
select * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where 
procesado = 0
and error is not null
and error = 'Cannot insert the value NULL into column ''id_trazabilidad_proceso'', table ''circulemos2.dbo.documento_proceso''; column does not allow nulls. INSERT fails.'
--and 
--numero_juicio in('100855-2017')
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'Cannot insert the value NULL into column ''id_trazabilidad_proceso'', table ''circulemos2.dbo.documento_proceso''; column does not allow nulls. INSERT fails.'

select *from circulemos2.dbo.documento_proceso

--sp_documento_proceso

select * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where numero_juicio in('239514-2023',
'239529-2023',
'239565-2023',
'239583-2023',
'239663-2023')

select top 1 * from integracion_terceros.dbo.reconstr_notifica_coactivo_multas
where numero_juicio in('239514-2023',
'239529-2023',
'239565-2023',
'239583-2023',
'239663-2023')

-- FECHA_REGISTRO, date,==   fecha coactiva o fecha_infraccion o fecha notifica_coactivo
--VALOR_FACTURA, numeric(38,2), == valor_infraccion o valor coactivo multa
--ID_TIPO_COACTIVO, varchar(50),== creo que 1 ok
--ESTADO_LECTURA, tinyint,== creo que 2 es 1
--ERROR, varchar(4000)== creo que debe ser null
--Los campos mas importantes son:
--numero_juicio, fecha , tipo de notifica, estado lectura=1

