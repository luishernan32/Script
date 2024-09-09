DROP TABLE IF EXISTS #tmp_reporte_reconstr_sol_bienes

select  *,
case when error  like '%UNIQUE KEY%' then 'Incidencia al Registrar Datos Documento' else error end erro_presentacion
into #tmp_reporte_reconstr_sol_bienes
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null


ALTER TABLE #tmp_reporte_reconstr_sol_bienes ADD estado varchar(200), observacion varchar(5000)
-- 1098 , registros procesados desde que se tomó la activadd.

update #tmp_reporte_reconstr_sol_bienes
set estado = 'Pendiente Gestion'


update #tmp_reporte_reconstr_sol_bienes
set estado = 'Gestionado - Pendiente Respuesta Operacion'
, observacion = 'Se validó con area de notificaciones y se nos indicó que estos registros no fueron notificados por recibir un pago antes de notificarse. 
Se informó por correo a la operación de Coactiva'
where numero_juicio in (
'326309-2023',
'322737-2023',
'3013-2024',
'15583-2024',
'3011-2024',
'317073-2023',
'322740-2023',
'3010-2024',
'3015-2024',
'326305-2023',
'38283-2024',
'322739-2023',
'3014-2024',
'15587-2024')


select  rs.erro_presentacion, COUNT (id_consecutivo_reconstruccion) cantidad from #tmp_reporte_reconstr_sol_bienes rs
where procesado = 0
and error is not null
group by rs.erro_presentacion
order by COUNT (id_consecutivo_reconstruccion) desc



select  rs.erro_presentacion, estado, COUNT (id_consecutivo_reconstruccion) cantidad,  MAX(observacion)  observacion from #tmp_reporte_reconstr_sol_bienes rs
where procesado = 0
and error is not null
and error  = 'El coactivo no ha sido NOTIFICADO'
group by rs.erro_presentacion, estado
order by COUNT (id_consecutivo_reconstruccion) desc


-- Coactivo No Existe
-- 30 Juicios que no encontramos Datos y se solictaron datos a la operación de Coactiva
-- 7 Juicios se encontraron Datos, pero no se pudo replicar a sogit, por estar anulados
-- 2 juicios sí se encontrados, pero el numero de juicio a reconstruir no existe en SOGIT, Se validó en AXIS y tiene juicio diferente. 



select * from #tmp_reporte_reconstr_sol_bienes

select  rs.erro_presentacion, COUNT (id_consecutivo_reconstruccion) cantidad from #tmp_reporte_reconstr_sol_bienes rs
where procesado = 0
and error is not null
group by rs.erro_presentacion
order by COUNT (id_consecutivo_reconstruccion) desc
