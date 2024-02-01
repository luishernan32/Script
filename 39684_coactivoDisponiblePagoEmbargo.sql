DROP TABLE #tmp_coa_axis

select * INTO #tmp_coa_axis from openquery (SRVPRATM, 'SELECT ID_FACTURA_COACTIVA,SALDO_CAPITAL,  SALDO_MULTAS, valor_interes_hoy, valor_costa_hoy 
FROM V_COACTIVAS WHERE SALDO_CAPITAL = 0 AND SALDO_MULTAS > 0')

use circulemos2
SELECT year(PR.fecha_inicio) año,co.numero_coactivo, PR.numero_proceso numero_juicio
, co.id_tramite
, PR.fecha_inicio fecha_coactivo
, co.fecha_notificacion
, tnc.nombre tipo_notificacion
, t.codigo AS 'TIPO_IDENTIFICACION'
,pe.numero_identificacion
,CASE pe.id_tipo_identificacion WHEN 2 THEN pj.nombre_comercial
ELSE CONCAT(pe.nombre1,' ',pe.nombre2,' ',pe.apellido1,' ',pe.apellido2) end 'Nombre infractor',
co.valor_total_obligaciones,
co.valor_total_costas_procesales,
ep.nombre estado_coactivo,
tca.saldo_multas
  from  proceso pr
  JOIN  coactivo co (nolock) on co.id_proceso = pr.id_proceso
  inner join #tmp_coa_axis tca on tca.id_factura_coactiva =  co.numero_coactivo
  join estado_proceso ep (nolock) on pr.id_estado_proceso = eP.id_estado_proceso
  join persona pe (nolock) on pe.id_persona =co.id_deudor
  join tipo_identificacion_persona t on t.id_tipo_identificacion = pe.id_tipo_identificacion
  LEFT JOIN persona_juridica pj (NOLOCK) ON pj.id_persona_juridica = pe.id_persona
  left join tipo_notificacion_coactivo tnc (NOLOCK) ON tnc.id_tipo_notificacion_coactivo = co.id_tipo_notificacion_coactivo
where  PR.id_tipo_proceso = 4
--and exists (select 1 from trazabilidad_proceso tp where tp.id_proceso = pr.id_proceso and --tp.id_estado_proceso = 23  )
--and (co.id_tipo_notificacion_coactivo  is null )
--and (co.id_tipo_notificacion_coactivo = 2 )
--and not exists (select 1 from detalle_gaceta_coactivo dgc where co.id_coactivo = dgc.id_coactivo)
--and year( pr.fecha_inicio) = 2022
--AND co.numero_coactivo in ()
and pr.id_estado_proceso = 45
and exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = pr.id_proceso and tp.id_estado_proceso = 37)
--order by co.numero_coactivo;