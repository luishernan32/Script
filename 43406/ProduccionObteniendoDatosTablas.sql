-- Ejemplo de Caso de Coactivo replicado
select top 1 * from circulemos2.dbo.coactivo_pendiente
where tipo_coactivo = 1
and coactivo_exitoso = 1
order by id_coactivo_pendiente desc
 
select pr.* from circulemos2.dbo.proceso pr
inner join circulemos2.dbo.coactivo co on pr.id_proceso = co.id_proceso
where co.numero_coactivo ='13531331'-- '14625684'
 
-- Caso real de los coactivos a replicar
 
------------------------------------------------------------------------------------------------------------------------ 
--De esté quri tengo los datos
select * from circulemos2.dbo.coactivo_pendiente   --obtengo 'numero_proceso' fecha_inicio='fecha_creacion'=fecha_fin
where numero_coactivo = '13531331'--'13664847';
------------------------------------------------------------------------------------------------------------------------
 select top 10 *from cartera


--INSERT proceso 
id_proceso	id_tipo_proceso	numero_proceso	fecha_inicio	               fecha_fin	                          observacion	    id_estado_proceso
          	4	            2087	         2024-01-03 06:14:38.0000000	2024-01-03 06:14:38.0000000            'COACTIVO ANULADO'	31


--Referencia coactivo ya creado
select * from circulemos2.dbo.coactivo co 
where co.numero_coactivo = '14625684'

------------------------------------------------------------------------------------------------
select --cp.*
--ca.id_cartera 
--ca.*
pe.*
from circulemos2.dbo.coactivo_pendiente cp   --obtengo 'numero_proceso' fecha_inicio='fecha_creacion'=fecha_fin
inner join persona pe on pe.numero_identificacion=cp.numero_identificacion
inner join cartera ca on pe.id_persona=ca.id_deudor
where numero_coactivo = '13531331'--'13664847';
and cp.id_coactivo_pendiente=142565
and ca.saldo_costas_procesales is null
------------------------------------------------------------------------------------------------



select top 10 *from obligacion_coactivo

select top 10 *from obligacion_coactivo
select top 10 *from comparendo_proceso
select top 10 *from trazabilidad_proceso

------------------------------------------------------------------------
select top 2
oc.*
from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
inner join coactivo_pendiente cp on cp.id_tramite=co.id_tramite
--where co.numero_coactivo = '13531331'
select top 2
co.*
from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
inner join coactivo_pendiente cp on cp.id_tramite=co.id_tramite
select top 2
cp.*
from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
inner join coactivo_pendiente cp on cp.id_tramite=co.id_tramite





--De esté quri tengo los datos
select * from circulemos2.dbo.coactivo_pendiente cp  --obtengo 'numero_proceso' fecha_inicio='fecha_creacion'=fecha_fin
inner join coactivo co on co.id_tramite=cp.id_tramite
where cp.numero_coactivo = '13531331'--'13664847';


select top 2 *
from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
where co.numero_coactivo = '13531331'